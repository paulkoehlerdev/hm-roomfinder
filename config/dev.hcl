server {
  bind = "0.0.0.0:8080"
}

logger {
  level = "debug"
}

database {
  path = "./hmrf.db"
}

frontend {
  proxy_url = "http://hmrf_frontend:5173"
}
