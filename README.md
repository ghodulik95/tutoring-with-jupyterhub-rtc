Setup

1. docker compose build --no-cache && docker compose up -d
2. Set passwords:
     docker exec -it jupyterhub-rtc bash
     passwd <username>