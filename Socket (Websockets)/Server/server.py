from clientserver import ClientThread
import nest_asyncio
import websockets
import sys
sys.path.append('.')
import asyncio
import threading

stopFlag = False

class GetData (threading.Thread):
    def __init__(self, obj, data):
        threading.Thread.__init__(self)
        self.data = data
        self.lastData = 0
        self.obj = obj

    def get(self):
        if self.lastData is not self.data:
            self.lastData = self.obj.read()
            return self.lastData

class Handler (threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)
        self.connected = set()

    def run(self):
        while not stopFlag:
            data = getdata.get()
            if data:
                loop1 = asyncio.new_event_loop()
                asyncio.set_event_loop(loop1)
                loop1.run_until_complete(self.sendData(data))
                loop1.close()   

    async def handler(self, websocket, path):
        print(websocket)
        self.connected.add(websocket)
        print('connect successfully.')
        print('#'*80)
        try:
          await websocket.recv()
        except websockets.exceptions.ConnectionClosed:
          pass
        finally:
          self.connected.remove(websocket)
          
    async def sendData(self, data):
        print('kir')
        print(self.connected)
        for websocket in self.connected.copy():
            await websocket.send(data)

if __name__ == "__main__":
    namad = ['خمحرکه','شپنا']
    host = '192.168.1.3'
    port = 8000
    obj = ClientThread(host, port, namad)
    print('#'*80)
    print('Please wait while scraping...')
    data = obj.scrape()
    print('Scrape completed.')
    print('#'*80)
    getdata = GetData(obj, data)
    print('Waiting for client to connect...')
    handle = Handler()

    try:
        handle.start()

        ws_server = websockets.serve(handle.handler, '192.168.1.3', 8000)
        nest_asyncio.apply()
        loop = asyncio.get_event_loop()
        loop.run_until_complete(ws_server)
        loop.run_forever()
    except KeyboardInterrupt:
        stopFlag = True
        print("Exiting program...")