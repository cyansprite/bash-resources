#!/usr/bin/env python3

import base64
import hmac
import struct
import sys
import time

def totp(key, time_step, digits=6, digest='sha1'):
    counter = struct.pack('>Q', time_step)
    key = base64.b32decode(key.upper() + '=' * ((8 - len(key)) % 8))
    mac = hmac.new(key, counter, digest).digest()
    offset = mac[-1] & 0x0f
    binary = struct.unpack('>L', mac[offset:offset+4])[0] & 0x7fffffff
    return str(binary)[-digits:].zfill(digits)

def main():
    if len(sys.argv) < 3:
        print("first param must be totp secret and second must be time step")
        sys.exit(1)

    X = int(sys.argv[2])
    time_step = int(time.time() / X)
    time_step_lookback = int((time.time() - X) / X)

    print("Time: {}".format(int(time.time())))
    print("TOTP: {}".format(totp(sys.argv[1], time_step)))
    print("TOTPLook back: {}".format(totp(sys.argv[1], time_step_lookback)))

if __name__ == '__main__':
    main()
