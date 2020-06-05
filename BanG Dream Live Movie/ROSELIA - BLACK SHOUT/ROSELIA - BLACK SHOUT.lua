#! by Vardë

-- Bleu 
color_top = "&HE0B06B&"
color_mid = "&H8C2A2B&"
color_bot = "&H6B004F&"

-- Rouge
color_top2 = "&HC960ED&"
color_mid2 = "&H270248&"
color_bot2 = "&H1B025B&"

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


function roumaji(line, l)
    l.effect = "Roselia fx"

    if line.i == 14 or line.i == 16 or line.i == 19 then
        fad = "\\fad(120,0)"
    elseif line.i == 28 or line.i == 10 or line.i == 11 or line.i == 29 then
        fad = ""
    else
        fad = "\\fad(120,160)"
    end

    l.start_time = line.start_time
    l.end_time = line.end_time

    l.layer = 1
    l.text = string.format(
                    "{\\pos(%.3f,%.3f)\\c&HFFFFFF&\\1a&HFE&\\3a&HB9&\\blur15%s}%s",
                    line.center, line.top, fad, line.text)
    io.write_line(l);

    l.layer = 2
    l.text = string.format(
                    "{\\pos(%.3f,%.3f)\\c&HFFFFFF&\\blur5%s}%s",
                    line.center, line.top, fad, line.text)
    io.write_line(l);

    for j = 1, line.ascent do
        color_bleu = utils.interpolate(j / line.ascent, color_top, color_mid)
        color = "\\c"..color_bleu

        l.layer = 3
        l.text = string.format(
                        "{\\pos(%.3f,%.3f)\\bord0\\blur0.7%s\\clip(%.3f,%d,%.3f,%d)%s}%s", 
                        line.center, line.top, color, 
                        line.left - 10, math.floor(line.top + line.height - line.descent - line.ascent + (j - 1)), 
                        line.right + 10, math.floor(line.top + line.height - line.descent - line.ascent + j), 
                        fad, line.text)
        io.write_line(l);
    end

    for j = 1, line.descent + 5  do
        color_bleu = utils.interpolate(j / (line.descent + 5), color_mid, color_bot)
        color = "\\c"..color_bleu

        l.layer = 3
        l.text = string.format(
                        "{\\pos(%.3f,%.3f)\\bord0\\blur0.7%s\\clip(%.3f,%d,%.3f,%d)%s}%s", 
                        line.center, line.top, color, 
                        line.left - 10, math.floor(line.top + line.height - line.descent + (j - 1)), 
                        line.right + 10, math.floor(line.top  + line.height - line.descent + j), 
                        fad, line.text)
        io.write_line(l);
    end

    total_char = char_counter(line)
    lead = ms_from_frame*16 / total_char
    interval = ms_from_frame*24
    duration = line.duration
    count = math.ceil(duration/interval) - 1
    for i = 1, count do 
        for ci, char in ipairs(line.chars) do
            if char.text ~= " " then
                l.start_time = line.start_time + (i-1)*interval + (ci-1)*lead
                l.end_time = line.start_time + i*interval + (ci-1)*lead
                if l.end_time > line.end_time then
                    l.end_time = line.end_time
                end
            
                l.layer = 0
                l.text = string.format(
                    "{\\pos(%.3f,%.3f)\\3c&HFFFFFF&\\c&HFFFFFF&\\blur20\\bord4.5\\alpha&H81&\\fad(%d,%d)}%s",
                    char.center, line.top, ms_from_frame*8, ms_from_frame*8, char.text)
                io.write_line(l);
            end
        end
    end
end


function sub(line, l)
    l.effect = "Roselia fx"

    if line.i == 14+28 or line.i == 16+28 or line.i == 19+28 then
        fad = "\\fad(120,0)"
    elseif line.i == 28+28 or line.i == 10+28 or line.i == 11+28 or line.i == 29+28 then
        fad = ""
    else
        fad = "\\fad(120,160)"
    end

    l.start_time = line.start_time
    l.end_time = line.end_time

    l.layer = 1
    l.text = string.format(
                    "{\\pos(%.3f,%.3f)\\c&HFFFFFF&\\1a&HFE&\\3a&HB9&\\blur15%s}%s",
                    line.center, line.bottom, fad, line.text)
    io.write_line(l);

    l.layer = 2
    l.text = string.format(
                    "{\\pos(%.3f,%.3f)\\c&HFFFFFF&\\blur5%s}%s",
                    line.center, line.bottom, fad, line.text)
    io.write_line(l);

    for j = 1, line.ascent do
        color_bleu = utils.interpolate(j / line.ascent, color_top, color_mid)
        color = "\\c"..color_bleu

        l.layer = 3
        l.text = string.format(
                        "{\\pos(%.3f,%.3f)\\bord0\\blur0.7%s\\clip(%.3f,%d,%.3f,%d)%s}%s", 
                        line.center, line.bottom, color, 
                        line.left - 10, math.floor(line.top + line.height - line.descent - line.ascent + (j - 1)), 
                        line.right + 10, math.floor(line.top + line.height - line.descent - line.ascent + j), 
                        fad, line.text)
        io.write_line(l);
    end

    for j = 1, line.descent + 5  do
        color_bleu = utils.interpolate(j / (line.descent + 5), color_mid, color_bot)
        color = "\\c"..color_bleu

        l.layer = 3
        l.text = string.format(
                        "{\\pos(%.3f,%.3f)\\bord0\\blur0.7%s\\clip(%.3f,%d,%.3f,%d)%s}%s", 
                        line.center, line.bottom, color, 
                        line.left - 10, math.floor(line.top + line.height - line.descent + (j - 1)), 
                        line.right + 10, math.floor(line.top  + line.height - line.descent + j), 
                        fad, line.text)
        io.write_line(l);
    end

    total_char = char_counter(line)
    lead = ms_from_frame*16 / total_char
    interval = ms_from_frame*24
    duration = line.duration
    count = math.ceil(duration/interval) - 1
    for i = 1, count do 
        for ci, char in ipairs(line.chars) do
            if char.text ~= " " then
                l.start_time = line.start_time + (i-1)*interval + (ci-1)*lead
                l.end_time = line.start_time + i*interval + (ci-1)*lead
                if l.end_time > line.end_time then
                    l.end_time = line.end_time
                end
            
                l.layer = 0
                l.text = string.format(
                    "{\\pos(%.3f,%.3f)\\3c&HFFFFFF&\\c&HFFFFFF&\\blur20\\bord4.5\\alpha&H81&\\fad(%d,%d)}%s",
                    char.center, line.bottom, ms_from_frame*8, ms_from_frame*8, char.text)
                io.write_line(l);
            end
        end
    end
end

-- Process
for li, line in ipairs(lines) do
    if not line.comment then
        if line.styleref.alignment == 8 then 
            roumaji(line, table.copy(line))
        else 
            sub(line, table.copy(line))
        end
    end
    io.progressbar(li / #lines)
end
