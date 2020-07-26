from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from socket import SOL_SOCKET, SO_REUSEADDR
import re
import time
from tabulate import tabulate
import socket

namad = input("سهم مورد نظر را وارد کنید: ")

s = socket.socket()
print('#'*80)
print("Socket successfully created")
port = 8000

s.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
s.bind(('192.168.0.104', port))
print("socket binded to %s" % port)

s.listen(5)
print("socket is listening")

c, addr = s.accept()
        
chrome_options = Options()
chrome_options.add_argument("--headless")
driver = webdriver.Chrome(options=chrome_options)

driver.get("http://tsetmc.ir/")
driver.find_element_by_id("search").click()

driver.find_element_by_id("SearchKey").send_keys(namad)

time.sleep(2)
search = driver.find_element_by_xpath('//*[@id="SearchResult"]/div/div[2]/table/tbody/tr[1]/td[1]/a')

index = 2
while 'نماد قدیمی' in search.text:
    search = driver.find_element_by_xpath('//*[@id="SearchResult"]/div/div[2]/table/tbody/tr['+str(index)+']/td[1]/a')
    index += 1
search.click()

situation = driver.find_element_by_xpath('//*[@id="d01"]')

while situation.text=='':
    pass

situation = situation.text

if situation != 'ممنوع-متوقف' and situation != 'ممنوع':  
    while True:
 
        buy_number = []
        vol_buy = []
        price_buy = []

        buy_number.append([driver.find_element_by_xpath('//*[@id="bl"]/tr['+str(i)+']/td[1]') \
                                                        for i in range (2,5)])
        vol_buy.append([driver.find_element_by_xpath('//*[@id="bl"]/tr['+str(i)+']/td[2]') \
                                                        for i in range (2,5)])
        price_buy.append([driver.find_element_by_xpath('//*[@id="bl"]/tr['+str(i)+']/td[3]') \
                                                        for i in range (2,5)])
        sell_number = []
        vol_sell = []
        price_sell = []
        
        sell_number.append([driver.find_element_by_xpath('//*[@id="bl"]/tr['+str(i)+']/td[4]') \
                                                        for i in range (2,5)])
        vol_sell.append([driver.find_element_by_xpath('//*[@id="bl"]/tr['+str(i)+']/td[5]') \
                                                        for i in range (2,5)])
        price_sell.append([driver.find_element_by_xpath('//*[@id="bl"]/tr['+str(i)+']/td[6]') \
                                                        for i in range (2,5)])
        
        
<<<<<<< HEAD
        lprice = driver.find_element_by_xpath('//*[@id="d02"]')
        fprice = driver.find_element_by_xpath('//*[@id="d03"]')
        turnover = driver.find_element_by_xpath('//*[@id="d09"]')
        
        private_turn_buy = driver.find_element_by_xpath('//*[@id="e0"]')
        legal_turn_buy = driver.find_element_by_xpath('//*[@id="e1"]')
        private_turn_sell = driver.find_element_by_xpath('//*[@id="e3"]')
        legal_turn_sell = driver.find_element_by_xpath('//*[@id="e4"]')
        
        private_num_buy = driver.find_element_by_xpath('//*[@id="e5"]')
        legal_num_buy = driver.find_element_by_xpath('//*[@id="e6"]')
        private_num_sell = driver.find_element_by_xpath('//*[@id="e8"]')
        legal_num_sell = driver.find_element_by_xpath('//*[@id="e9"]')
        
        min_price = driver.find_element_by_xpath('//*[@id="d07"]')
        max_price = driver.find_element_by_xpath('//*[@id="d06"]')
        
        buy_number = [buy_number[0][i].text for i in range(3)]
        buy_number = [int(re.sub(r',', '', i).strip()) if i!=' ' else 0 for i in buy_number]
        bn = buy_number
        vol_buy = [vol_buy[0][i].text for i in range(3)]
        vol_buy = [int(re.sub(r',', '', i).strip()) if i!=' ' else 0 for i in vol_buy]
        vb = vol_buy
        price_buy = [price_buy[0][i].text for i in range(3)]
        price_buy = [int(re.sub(r',', '', i).strip()) if i!=' ' else 0 for i in price_buy]
        pb = price_buy
        sell_number = [sell_number[0][i].text for i in range(3)]
        sell_number = [int(re.sub(r',', '', i).strip()) if i!=' ' else 0  for i in sell_number]
        sn = sell_number
        vol_sell = [vol_sell[0][i].text for i in range(3)]
        vol_sell = [int(re.sub(r',', '', i).strip()) if i!=' ' else 0 for i in vol_sell]
        vs = vol_sell
        price_sell = [price_sell[0][i].text for i in range(3)]
        price_sell = [int(re.sub(r',', '', i).strip()) if i!=' ' else 0 for i in price_sell]
        ps = price_sell
        
        lp = lprice.text.split()
        last_price = int(re.sub(r',', '', lp[0]).strip())
        fp = fprice.text.split()
        final_price = int(re.sub(r',', '', fp[0]).strip())
        try:
            state = driver.find_element_by_xpath('//*[@id="d02"]/span[2]')
            state_lp = state.get_attribute('style')
            
            lp = lprice.text.split()     
            lp_shakhes = int(re.sub(r',', '', lp[1]).strip())
=======
        if 'red' in state_fp:
            fp_percent = -1*fp_percent
            fp_shakhes = -1*fp_shakhes
    except:
        lp_shakhes = 0
        lp_percent = 0
        fp_shakhes = 0
        fp_percent = 0
    
    turnover = turnover.text
    
    min_price = min_price.text.split()
    min_price = [int(re.sub(r',', '', i).strip()) for i in min_price]
    min_price = int(min_price[0])
    max_price = max_price.text.split()
    max_price = [int(re.sub(r',', '', i).strip()) for i in max_price]
    max_price = int(max_price[0])

    try:
        private_turn_buy = private_turn_buy.text.split()    
        ptb = private_turn_buy
        ptb[0] = re.sub(',','', ptb[0])
        if len(ptb)==3:
            try:
                private_turn_buy_percent = float(re.findall(r'\d+\W\d+', ptb[2])[0])
            except:
                private_turn_buy_percent = float(re.findall(r'\d+', ptb[2])[0])
            pvb_hajm = str(ptb[0]) + str(ptb[1])
        else:
            try:
                private_turn_buy_percent = float(re.findall(r'\d+\W\d+', ptb[1])[0])
            except:
                private_turn_buy_percent = float(re.findall(r'\d+', ptb[1])[0])
            pvb_hajm = str(ptb[0])
        ptbp = private_turn_buy_percent
            
        legal_turn_buy = legal_turn_buy.text.split()
        ltb = legal_turn_buy
        ltb[0] = re.sub(',','', ltb[0])
        if len(ltb)==3:
            try:
                legal_turn_buy_percent = float(re.findall(r'\d+\W\d+', ltb[2])[0])
            except:
                legal_turn_buy_percent = float(re.findall(r'\d+', ltb[2])[0])
            lvb_hajm = str(ltb[0]) + str(ltb[1])
        else:
            try:
                legal_turn_buy_percent = float(re.findall(r'\d+\W\d+', ltb[1])[0])
            except:
                legal_turn_buy_percent = float(re.findall(r'\d+', ltb[1])[0])
            lvb_hajm = str(ltb[0]) 
        ltbp = legal_turn_buy_percent
        
        private_turn_sell = private_turn_sell.text.split()
        pts = private_turn_sell
        pts[0] = re.sub(',','', pts[0])
        if len(pts)==3:
            try:
                private_turn_sell_percent = float(re.findall(r'\d+\W\d+', pts[2])[0])
            except:
                private_turn_sell_percent = float(re.findall(r'\d+', pts[2])[0])
            pvs_hajm = str(pts[0]) + str(pts[1])
        else:
            try:
                private_turn_sell_percent = float(re.findall(r'\d+\W\d+', pts[1])[0])
            except:
                private_turn_sell_percent = float(re.findall(r'\d+', pts[1])[0])
            pvs_hajm = str(pts[0])
        ptsp = private_turn_sell_percent
            
        legal_turn_sell = legal_turn_sell.text.split()
        lts = legal_turn_sell
        lts[0] = re.sub(',','', lts[0])
        if len(lts)==3:
>>>>>>> 5e9d283de24ab39065c943b0a9c63489ef50a1c2
            try:
                lp_percent = float(re.findall(r'\d+\W\d+', lp[2])[0])
            except:
                lp_percent = float(re.findall(r'\d', lp[2])[0])
                
            if 'red' in state_lp:
                lp_percent = -1*lp_percent
                lp_shakhes = -1*lp_shakhes
                
            
            state = driver.find_element_by_xpath('//*[@id="d03"]/span')
            state_fp = state.get_attribute('style')
                   
            fp_shakhes = int(re.sub(r',', '', fp[1]).strip())
            try:
                fp_percent = float(re.findall(r'\d+\W\d+', fp[2])[0])
            except:
                fp_percent = float(re.findall(r'\d', fp[2])[0])
            
            if 'red' in state_fp:
                fp_percent = -1*fp_percent
                fp_shakhes = -1*fp_shakhes
        except:
            lp_shakhes = 0
            lp_percent = 0
            fp_shakhes = 0
            fp_percent = 0
        
        turnover = turnover.text
        
        min_price = min_price.text.split()
        min_price = [int(re.sub(r',', '', i).strip()) for i in min_price]
        min_price = int(min_price[0])
        max_price = max_price.text.split()
        max_price = [int(re.sub(r',', '', i).strip()) for i in max_price]
        max_price = int(max_price[0])
    
        try:
            private_turn_buy = private_turn_buy.text.split()    
            ptb = private_turn_buy
            ptb[0] = re.sub(',','', ptb[0])
            if len(ptb)==3:
                try:
                    private_turn_buy_percent = float(re.findall(r'\d+\W\d+', ptb[2])[0])
                except:
                    private_turn_buy_percent = float(re.findall(r'\d+', ptb[2])[0])
                pvb_hajm = str(ptb[0]) + str(ptb[1])
            else:
                try:
                    private_turn_buy_percent = float(re.findall(r'\d+\W\d+', ptb[1])[0])
                except:
                    private_turn_buy_percent = float(re.findall(r'\d+', ptb[1])[0])
                pvb_hajm = str(ptb[0])
            ptbp = private_turn_buy_percent
                
            legal_turn_buy = legal_turn_buy.text.split()
            ltb = legal_turn_buy
            ltb[0] = re.sub(',','', ltb[0])
            if len(ltb)==3:
                try:
                    legal_turn_buy_percent = float(re.findall(r'\d+\W\d+', ltb[2])[0])
                except:
                    legal_turn_buy_percent = float(re.findall(r'\d+', ltb[2])[0])
                lvb_hajm = str(ltb[0]) + str(ltb[1])
            else:
                try:
                    legal_turn_buy_percent = float(re.findall(r'\d+\W\d+', ltb[1])[0])
                except:
                    legal_turn_buy_percent = float(re.findall(r'\d+', ltb[1])[0])
                lvb_hajm = str(ltb[0]) 
            ltbp = legal_turn_buy_percent
            
            private_turn_sell = private_turn_sell.text.split()
            pts = private_turn_sell
            pts[0] = re.sub(',','', pts[0])
            if len(pts)==3:
                try:
                    private_turn_sell_percent = float(re.findall(r'\d+\W\d+', pts[2])[0])
                except:
                    private_turn_sell_percent = float(re.findall(r'\d+', pts[2])[0])
                pvs_hajm = str(pts[0]) + str(pts[1])
            else:
                try:
                    private_turn_sell_percent = float(re.findall(r'\d+\W\d+', pts[1])[0])
                except:
                    private_turn_sell_percent = float(re.findall(r'\d+', pts[1])[0])
                pvs_hajm = str(pts[0])
            ptsp = private_turn_sell_percent
                
            legal_turn_sell = legal_turn_sell.text.split()
            lts = legal_turn_sell
            lts[0] = re.sub(',','', lts[0])
            if len(lts)==3:
                try:
                    legal_turn_sell_percent = float(re.findall(r'\d+\W\d+', lts[2])[0])
                except:
                    legal_turn_sell_percent = float(re.findall(r'\d+', lts[2])[0])
                lvs_hajm = str(lts[0]) + str(lts[1])
            else:
                try:
                    legal_turn_sell_percent = float(re.findall(r'\d+\W\d+', lts[1])[0])
                except:
                    legal_turn_sell_percent = float(re.findall(r'\d+', lts[1])[0])
                lvs_hajm = str(lts[0]) 
            ltsp = legal_turn_sell_percent
                
            private_num_buy = private_num_buy.text.split()
            private_num_buy = [int(re.sub(r',', '', i).strip()) for i in private_num_buy]
            pnb = int(private_num_buy[0])
            legal_num_buy = legal_num_buy.text.split()
            legal_num_buy = [int(re.sub(r',', '', i).strip()) for i in legal_num_buy]
            lnb = int(legal_num_buy[0])
            private_num_sell = private_num_sell.text.split()
            private_num_sell = [int(re.sub(r',', '', i).strip()) for i in private_num_sell]
            pns = int(private_num_sell[0])
            legal_num_sell = legal_num_sell.text.split()
            legal_num_sell = [int(re.sub(r',', '', i).strip()) for i in legal_num_sell]
            lns = int(legal_num_sell[0])
        except:
            pnb = 0
            ptbp = 0
            pvb_hajm = 0
            lnb = 0
            ltbp = 0
            lvb_hajm = 0
            pns = 0
            ptsp = 0
            pvs_hajm = 0
            lns = 0
            ltsp = 0
            lvs_hajm = 0
        
        print('\nنماد %s %s می باشد.'%(namad, situation))
        print('\n')
        print('آخرین قیمت: %i  تاثیر شاخص: %i  درصد: %s'% (last_price, lp_shakhes, str(lp_percent)))
        print('قیمت پایانی: %i  تاثیر شاخص: %i  درصد: %s'% (final_price, fp_shakhes, str(fp_percent)))
        
        print('حجم معاملات: %s'% turnover)
        print('\n')
        print('بازه قیمت: کمترین: %i   بیشترین: %i'% (min_price, max_price))
        print('\n')
        print(tabulate([['Private', pnb, ptbp, pvb_hajm], ['Legal', lnb, ltbp, lvb_hajm]],\
                       headers=['Buy', 'Number', 'Precent', 'Turn'], tablefmt='orgtbl'))
        print('\n')    
        print(tabulate([['Private', pns, ptsp, pvs_hajm], ['Legal', lns, ltsp, lvs_hajm]],\
                   headers=['Sell', 'Number', 'Precent', 'Turn'], tablefmt='orgtbl'))
        print('\n')    
        print(tabulate([[ps[0], vs[0], sn[0], pb[0], vb[0], bn[0]], [ps[1], vs[1], sn[1], pb[1], vb[1], bn[1]] , [ps[2], vs[2], sn[2], pb[2], vb[2], bn[2]]],\
                   headers=['Number', 'Turn', 'Price','Price', 'Turn', 'Number'], tablefmt='orgtbl'))  
        print('#'*80)
              
        with open("data.txt", "w") as f:
            f.write('%s,%s,%s,'% (str(last_price),str(lp_shakhes),str(lp_percent)))
            f.write('%s,%s,%s,'% (str(final_price),str(fp_shakhes),str(fp_percent)))
            f.write('%s,'%str(turnover))
            f.write('%s,%s,'%(str(min_price), str(max_price)))
            f.write('%s,%s,%s,'%(str(pnb), str(ptbp), str(pvb_hajm)))
            f.write('%s,%s,%s,'%(str(lnb), str(ltbp), str(lvb_hajm)))
            f.write('%s,%s,%s,'%(str(pns), str(ptsp), str(pvs_hajm)))
            f.write('%s,%s,%s,'%(str(lns), str(ltsp), str(lvs_hajm)))
            for i in range(3):
                f.write('%s, %s, %s, %s, %s, %s,'%(str(ps[i]), str(vs[i]), str(sn[i]), str(pb[i]),\
                str(vb[i]), str(bn[i])))

        time.sleep(1)
    
        ##################################  Socket  #########################################

        with open('data.txt', 'rb') as f:
            c.sendfile(f)
        
#        
#        for i in range(3):
#            a = str(ps[i]) + ',' + str(vs[i]) + ',' + str(sn[i]) + ',' + str(pb[i]) +\
#            ',' + str(vb[i]) + ',' + str(bn[i])
#            c.send(a.encode())
#            time.sleep(1)
#        
#        c.send((str(pnb) + ',' + str(ptbp) + ',' + str(pvb_hajm)).encode()) 
#        time.sleep(1)
#        c.send((str(lnb) + ',' + str(ltbp) + ',' + str(lvb_hajm)).encode()) 
#        time.sleep(1)
#        c.send((str(pns) + ',' + str(ptsp) + ',' + str(pvs_hajm)).encode()) 
#        time.sleep(1)
#        c.send((str(lns) + ',' + str(ltsp) + ',' + str(lvs_hajm)).encode())
#        time.sleep(1)
#        c.send((str(max_price) + ',' + str(min_price)).encode())
#        time.sleep(1)
#        c.send((str(last_price) + ',' + str(lp_shakhes) + ',' + str(lp_percent)).encode())
#        time.sleep(1)
#        c.send((str(final_price) + ',' + str(fp_shakhes) + ',' + str(fp_percent)).encode())
#        
        time.sleep(2)
    c.close()
        
else:
    print('\nنماد %s ممنوع (متوقف) می باشد.'%namad)

driver.quit()