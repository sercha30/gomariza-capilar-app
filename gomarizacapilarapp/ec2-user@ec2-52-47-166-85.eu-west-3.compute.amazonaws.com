services:
  db:
    image: postgres
    ports:
      - "5432:5432"
    environment:
      - POSTGRES_PASSWORD=admin
  
  admin:
    image: dpage/pgadmin4
    ports:
      - "80:80"
    environment:
      - PGADMIN_DEFAULT_EMAIL=chamorrogarciasergio@gmail.com
      - PGADMIN_DEFAULT_PASSWORD=301295.Serchagar
    depends_on:
      - db