import asyncio
import websockets
import nest_asyncio

async def hello():

    uri = "ws://192.168.1.3:8000"
    async with websockets.connect(uri) as websocket:

        while True:
            try:
                greeting = await websocket.recv()
                print(f"< {greeting}")
            except:
                print('Server disconnected')
                print('Try to reconnect')
                websocket = await websockets.connect(uri)
            
nest_asyncio.apply()
asyncio.get_event_loop().run_until_complete(hello())
asyncio.get_event_loop().run_forever()