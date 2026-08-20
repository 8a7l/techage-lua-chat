-- Отримуємо повідомлення
num, msg = $get_msg()

if num then

    -- Шукаємо термінал, з якого прийшло повідомлення
    sender_idx = nil

    for i, terminal in TERMINALS.next() do
        if terminal == num then
            sender_idx = i
        end
    end

    -- Якщо термінал знайдений
    if sender_idx then

        -- Визначаємо гравця через відповідний Player Detector
        detector = DETECTORS.get(sender_idx)
        player_name = $send_cmnd(detector, "name")

        -- Перевіряємо, що детектор справді бачить гравця
        if player_name and player_name ~= "" then

            -- Формуємо повідомлення
            text = player_name .. ": " .. msg

            -- Розсилаємо повідомлення на всі термінали
            for i, terminal in TERMINALS.next() do
                $put_term(terminal, text)
            end

        else
            -- Якщо гравця біля детектора немає
            $put_term(num, "Помилка: гравця не знайдено.")
        end

    else
        -- Повідомлення прийшло не від зареєстрованого термінала
        $print("Unknown terminal: " .. num)
    end
end
