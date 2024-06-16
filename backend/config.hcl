
server {
  bind = "0.0.0.0:8080"
}

logger {
  console = true
  level = "debug"
  file {
    path = "log/application.log"
  }
}

database {
  host = "hm_roomfinder_geodata_postgis"
#  host = "localhost"
  port = 5432
  username = "hmroomfinder"
  password = "password"
  database = "hmroomfinder"
}