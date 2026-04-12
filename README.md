# DEVE Chat Service

Простенький чатик, с базовым WS функционалом: Отравка, чтение, создание комнат.

- REST ручки в lib/chat_web/controllers/room_controller.ex
- WS в lib/chat_web/endpoint.ex

P.S:

Путь /socket/websocket такой, потому что phoenix клиент на React какого то хера сам дорисовывает /websocket в urlесл его там ещё нет