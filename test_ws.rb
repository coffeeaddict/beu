require 'soap/wsdlDriver'
wsdl = "http://127.0.0.5/beu/ws/wsdl"
item_server = SOAP::WSDLDriverFactory.new(wsdl).create_rpc_driver

item_id = item_server.login('coffeeaddict_nl', 'beu wachtwoord')
item_server.add('ws-*')
