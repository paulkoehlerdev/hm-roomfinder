server {
  bind = "0.0.0.0:8080"
}

logger {
  level = "debug"
}

frontend {
  proxy_url = "http://hmrf_frontend:5173"
}