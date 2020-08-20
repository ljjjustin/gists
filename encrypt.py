import bcrypt
import sys
import hashlib


if __name__ == '__main__':

    m = hashlib.sha512()
    m.update(sys.argv[1])
    sha512_code = m.hexdigest()
    print bcrypt.hashpw(sha512_code, bcrypt.gensalt(rounds=10, prefix=b"2a"))
