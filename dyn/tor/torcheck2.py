def application(environ, start_response):
    response_body = [
        '%s: %s' % (key, value) for key, value in sorted(environ['HTTP_HOST'])
    ]

#    with open("/tmp/exit.txt") as f:
#        for l in f:
#            if environ['HTTP_HOST'] == l.strip('\n'):
#                response_body = "Congrats for using Tor, ip: " + environ['HTTP_HOST']
#                break
#    try:
#        response_body
#    except NameError:
#        response_body = "Not using Tor, ip: " + environ['HTTP_HOST']

    response_headers = [
        ('Content-Type', 'text/plain'),
    ]

    start_response('200 OK', response_headers)

    yield response_body.encode('utf-8')
    yield b'\n'
