set('log.file.path', '../../log/liquidsoap/radio.log')

transmissions = ref []
meta = ref []

out = output.icecast(
  %vorbis(quality = 0.4),
  host = "localhost",
  port = 8000,
  password = "hackme",
  mount = "radio.ogg",
  fallible = true
)

def update_meta(m) =
  m = metadata.export(m)
  recode = string.recode(out_enc='UTF-8')

  def f(x) =
    (recode(fst(x)), recode(snd(x)))
  end

  meta := list.map(f, m)
end

def set_playlist(~protocol,~data,~headers,uri) =
 log('Setting playlist...')
 log("protocol: #{protocol}")
 log("data: #{data}")
 log("headers: #{headers}")
 log("uri: #{uri}")

 stream = playlist(data)
 stream = on_metadata(update_meta, stream)
 output = out(stream)
 transmissions := list.append([output], !transmissions)

 log("transmissions: #{transmissions}")
 log('Done!')

 http_response(code=200)
end

def stop_transmission(~protocol,~data,~headers,uri) =
  log('Stopping transmissions...')
  log("transmissions: #{transmissions}")

  list.iter(source.shutdown, !transmissions)

  log('Done!')
  http_response(code=200)
end

harbor.http.register(port=8080, method='POST', '/set_playlist', set_playlist)
harbor.http.register(port=8080, method='DELETE', '/stop_transmission', stop_transmission)

output.dummy(blank())
