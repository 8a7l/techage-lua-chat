$events(true)
$loopcycle(0)

-- Номери терміналів
TERMINALS = Array()
TERMINALS.add("21627")  -- 1
TERMINALS.add("21628")  -- 2
TERMINALS.add("21629")  -- 3


-- Номери детекторів, що відповідають терміналам
DETECTORS = Array()
DETECTORS.add("21633")  -- 1
DETECTORS.add("21634")  -- 2
DETECTORS.add("21635")  -- 3

-- Перевірка, щоб кількість терміналів і детекторів збігалася
if TERMINALS.size() ~= DETECTORS.size() then
    $print("ERROR: TERMINALS and DETECTORS size mismatch")
end
