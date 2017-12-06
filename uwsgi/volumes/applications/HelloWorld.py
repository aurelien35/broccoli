# -*- coding: utf-8 -*-
import pprint

# Main application : call the requested application if available
def application(env, start_response):
	response = pprint.pformat(env).encode('utf-8')
	start_response('200 OK', [('Content-Type','text/html')])
	return [response]
