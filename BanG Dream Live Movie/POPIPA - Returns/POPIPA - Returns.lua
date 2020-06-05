#! by Vardë

ms_from_frame = 1000 / 23.976

function char_counter(line)
    local compteur = 0
    for ci, char in ipairs(line.chars) do
        if char.text ~= " " then
            compteur = compteur + 1
        end
    end
    return compteur
end

function sub(line, l)
    l.effect = "Popipa fx"

    total_char = char_counter(line)

    leadin = 500 / total_char
    leadout = 350 / total_char

    for ci, char in ipairs(line.chars) do
        if char.text ~= " " then
            l.start_time = line.start_time + (ci-1) * leadin
            if line.i == 41 or line.i == 21 then
                l.end_time = line.end_time
                fadb = ms_from_frame * 24
            else
                l.end_time = line.end_time + (ci-1) * leadout
                fadb = ms_from_frame * 3
            end

            l.layer = 0
            l.text = string.format(
                            "{\\an5\\pos(%.3f,%.3f)\\3c&H8D37E6&\\bord12\\blur5\\alpha&H64&\\fad(%d,%d)}%s",
                            char.center, char.middle, ms_from_frame * 4, fadb,
                            char.text)
            io.write_line(l);

            l.layer = 1
            l.text = string.format(
                            "{\\an5\\pos(%.3f,%.3f)\\3c&H8D37E6&\\bord8\\blur0.6\\fad(%d,%d)}%s",
                            char.center, char.middle, ms_from_frame * 4, fadb,
                            char.text)
            io.write_line(l);

            l.layer = 2
            l.text = string.format(
                            "{\\an5\\pos(%.3f,%.3f)\\3c&HFFFFFF&\\bord4\\blur0.6\\fad(%d,%d)}%s",
                            char.center, char.middle, ms_from_frame * 4, fadb,
                            char.text)
            io.write_line(l);

            l.layer = 3
            l.text = string.format(
                            "{\\an5\\pos(%.3f,%.3f)\\bord0\\blur0.8\\fad(%d,%d)}%s",
                            char.center, char.middle, ms_from_frame * 4, fadb,
                            char.text)
            io.write_line(l);
        end
    end
end

-- Process
for li, line in ipairs(lines) do
    if not line.comment then
        if line.styleref.alignment == 8 or line.styleref.alignment == 2 then 
            sub(line, table.copy(line))
        end
    end
    io.progressbar(li / #lines)
end
