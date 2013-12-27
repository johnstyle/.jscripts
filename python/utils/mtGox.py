#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Un app-indicator de suivi de la valeur du Bitcoin en Euro
# Créé par JohnStyle http://www.johnstyle.fr
#

import gtk
import appindicator
import webbrowser

import json
import urllib

PING_FREQUENCY = 60
DEFAULT_CURRENCY = 'EUR'

CURRENCIES = ('EUR', 'USD', 'JPY', 'CAD', 'GBP', 'CHF', 'RUB', 'AUD', 'SEK', 'DKK', 'HKD', 'PLN', 'CNY', 'SGD', 'THB', 'NZD', 'NOK')

class MtGox:
    def __init__(self):
        
        self.currency = DEFAULT_CURRENCY
    
        self.ind = appindicator.Indicator("mtgox-indicator", "indicator-messages", appindicator.CATEGORY_APPLICATION_STATUS)
        self.ind.set_status (appindicator.STATUS_ACTIVE)
        
        self.ind.set_icon("")

        self.menu_setup()
        
    def menu_setup(self):
        self.menu = gtk.Menu()
        
        item = gtk.MenuItem("Site internet Mt.Gox")
        item.connect("activate", self.goToWebsite)
        item.show()
        self.menu.append(item)
        
        separator = gtk.SeparatorMenuItem()
        separator.show()
        self.menu.append(separator)
        
        group=gtk.RadioMenuItem(None, 'currency')        
        for currency in CURRENCIES:
            radio = gtk.RadioMenuItem(group, currency)
            
            if(currency == DEFAULT_CURRENCY):
                radio.set_active(True)
            
            radio.connect("activate", self.setCurrency, currency)
            radio.show()
            self.menu.append(radio)

        separator = gtk.SeparatorMenuItem()
        separator.show()
        self.menu.append(separator)
        
        item = gtk.ImageMenuItem(gtk.STOCK_QUIT)
        item.connect("activate", self.quit)
        item.show()
        self.menu.append(item)
        
        self.menu.show()
        self.ind.set_menu(self.menu)

    def main(self):
        self.check()
        gtk.timeout_add(PING_FREQUENCY * 1000, self.check)
        gtk.main()
        
    def check(self):
    
        if self.currency == 'EUR':
            money = '€'
        elif self.currency == 'USD' or self.currency == 'CAD' or self.currency == 'AUD' or self.currency == 'HKD' or self.currency == 'SGD' or self.currency == 'NZD':
            money = '$'
        elif self.currency == 'JPY' or self.currency == 'CNY':
            money = '¥'
        elif self.currency == 'GBP':
            money = '£'
        elif self.currency == 'CHF':
            money = 'CHF'
        elif self.currency == 'RUB':
            money = 'руб'
        elif self.currency == 'SEK' or self.currency == 'DKK' or self.currency == 'NOK':
            money = 'kr'
        elif self.currency == 'PLN':
            money = 'zł'
        elif self.currency == 'THB':
            money = '฿'

        f = urllib.urlopen('http://data.mtgox.com/api/2/BTC'+self.currency+'/money/ticker')
        data = json.loads(f.read())
        display  = "⇩%.2f" % float(data['data']['low']['value'])
        display += " [ " + money + "%.2f" % float(data['data']['last_local']['value']) + " ] "
        display += "⇧%.2f" % float(data['data']['high']['value'])
        
        self.ind.set_label("Mt.Gox: " + display)

        return True

    def quit(self, widget, data=None):
        gtk.main_quit()

    def setCurrency(self, widget, data=None):
        self.currency = data
        self.check()

    def goToWebsite(self, widget, data=None):
        webbrowser.open("https://mtgox.com/index.html?Currency=" + self.currency)

if __name__ == "__main__":
    indicator = MtGox()
    indicator.main()
