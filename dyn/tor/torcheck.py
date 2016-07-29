def application(environ, start_response):
    #response_body = "Not using Tor, ip: " + environ['REMOTE_ADDR'] # Just assume
    response_body = "#tor{color:#d75f00 !important}"
    with open("/var/cache/dyn/exits.txt") as f:
        for l in f:
            if environ['REMOTE_ADDR'] == l.strip('\n'):
                #response_body = "Congrats for using Tor, ip: " \
                #        + environ['REMOTE_ADDR']
                response_body = "#tor{color:#008700 !important}"
                break

    response_headers = [
        ('Content-Type', 'text/css'),
    ]

    start_response('200 OK', response_headers)

    yield response_body.encode('utf-8')
    yield b'\n'
#    yield ('\n'.join(['%s: %s' % (key, value) for key, value in sorted(environ.items())])).encode('utf-8')

