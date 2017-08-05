# Riq
Content management system for internet radio, based on rails, liquidsoap and icecast2.

## This is the very early version!

### liquidsoap
Create file for logs

    mkdir log/liquidsoap && touch log/liquidsoap/radio.liq


Go to radio.liq and start server

    cd lib/liquidsoap && liquidsoap radio.liq



### icecast2
Create file for logs

    mkdir log/icecast2 && touch log/icecast2/access.log log/icecast2/access.log


Start icecast2 server

    icecast2 -c lib/icecast2/icecast.xml
