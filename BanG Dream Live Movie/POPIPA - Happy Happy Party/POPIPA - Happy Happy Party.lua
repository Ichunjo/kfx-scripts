#! by Vardë


function sub(line, l)
    l.effect = "Popipa fx"

    for ci, char in ipairs(line.chars) do

        l.start_time = line.start_time + (ci-1) * 10
        l.end_time = line.end_time + (ci-1) * 10

        l.layer = 0
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\3c&H8D37E6&\\bord12\\blur5\\alpha&H64&\\fad(120,140)}%s",
                        char.center, char.middle,
                        char.text)
        io.write_line(l);

        l.layer = 1
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\3c&H8D37E6&\\bord8\\blur0.6\\fad(120,140)}%s",
                        char.center, char.middle,
                        char.text)
        io.write_line(l);

        l.layer = 2
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\3c&HFFFFFF&\\bord4\\blur0.6\\fad(120,140)}%s",
                        char.center, char.middle,
                        char.text)
        io.write_line(l);

        l.layer = 3
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\bord0\\blur0.8\\fad(120,140)}%s",
                        char.center, char.middle, 
                        char.text)
        io.write_line(l);
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
