#! by Vardë


color_tablo = {"\\c&H4AC2C9&\\3c&H4AC2C9&","\\c&HDB60D9&\\3c&HDB60D9&","\\c&HD6D02B&\\3c&HD6D02B&","\\c&H4642F3&\\3c&H4642F3&"}

function sub(line, l)
    l.effect = "Popipa fx"

    start_line = 0

    for ci, char in ipairs(line.chars) do
        start_line = (ci-1) * 10
    end

    count = math.ceil(line.duration/1000)

    autotag = ""
    interval = 0
    for i = 1, count do
        autotag = autotag.."\\t("..interval..","..(interval+250)..","..color_tablo[1]..")".."\\t("..(interval+250)..","..(interval+500)..","..color_tablo[2]..")".."\\t("..(interval+500)..","..(interval+750)..","..color_tablo[3]..")".."\\t("..(interval+750)..","..(interval+1000)..","..color_tablo[4]..")".."" 
        interval = interval + 1000
    end

    l.start_time = line.start_time + start_line
    l.end_time = line.end_time

    l.layer = 0
    l.text = string.format(
                    "{\\an5\\pos(%.6f,%.6f)\\bord16\\blur10\\alpha&H53&\\fsp2%s\\fad(84,84)}%s", 
                    line.center, line.middle, autotag, line.text)
    io.write_line(l);


    for ci, char in ipairs(line.chars) do

        l.start_time = line.start_time + (ci-1) * 10
        l.end_time = line.end_time + (ci-1) * 10

        l.layer = 1
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\3c&H8D37E6&\\bord12\\blur5\\alpha&H64&\\fsp2\\fad(120,140)}%s",
                        char.center, char.middle,
                        char.text)
        io.write_line(l);

        l.layer = 2
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\3c&H8D37E6&\\bord8\\blur0.6\\fsp2\\fad(120,140)}%s",
                        char.center, char.middle,
                        char.text)
        io.write_line(l);

        l.layer = 3
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\3c&HFFFFFF&\\bord4\\blur0.6\\fsp2\\fad(120,140)}%s",
                        char.center, char.middle,
                        char.text)
        io.write_line(l);

        l.layer = 4
        l.text = string.format(
                        "{\\an5\\pos(%.6f,%.6f)\\bord0\\blur0.8\\fsp2\\fad(120,140)}%s",
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
