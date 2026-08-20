# techage-lua-chat
Чат для TechAge, побудований на Lua Controller.
Термінали визначаються через список TERMINALS, відповідні Player Detector — через DETECTORS. Lua Controller отримує повідомлення через $get_msg(), визначає гравця та розсилає повідомлення на всі зареєстровані термінали.
