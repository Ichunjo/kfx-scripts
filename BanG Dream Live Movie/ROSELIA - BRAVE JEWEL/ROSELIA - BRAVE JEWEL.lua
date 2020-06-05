#! by Vardë

-- Bleu 
color_top = "&HE0B06B&"
color_mid = "&H8C2A2B&"
color_bot = "&H6B004F&"

-- Rouge
color_top2 = "&HC960ED&"
color_mid2 = "&H270248&"
color_bot2 = "&H1B025B&"

ms_per_frame = 1000 / 23.976


function roumaji(line, l)
    l.effect = "Roselia fx"
    fad = "\\fad(120,160)"

    l.start_time = line.start_time
    l.end_time = line.end_time

    l.layer = 1
    l.text = string.format(
                    "{\\pos(%.3f,%.3f)\\fsp2\\c&HFFFFFF&\\1a&HFE&\\3a&HB9&\\blur10%s}%s",
                    line.center, line.top, fad, line.text)
    io.write_line(l);

    l.layer = 2
    l.text = string.format(
                    "{\\pos(%.3f,%.3f)\\fsp2\\c&HFFFFFF&\\blur5%s}%s",
                    line.center, line.top, fad, line.text)
    io.write_line(l);


    for j = 1, line.ascent do
        color_bleu = utils.interpolate(j / line.ascent, color_top, color_mid)
        color = "\\c"..color_bleu

        l.layer = 100
        l.text = string.format(
                        "{\\pos(%.3f,%.3f)\\fsp2\\bord0\\blur0.7%s\\t(%.3f,%.3f,\\blur5)\\clip(%.3f,%.3f,%.3f,%.3f)%s}%s", 
                        line.center, line.top, color, 
                        line.duration - 160, line.duration,
                        line.left - 10, math.round(line.top + line.height - line.descent - line.ascent + (j - 1)), 
                        line.right + 10, math.round(line.top + line.height - line.descent - line.ascent + j), 
                        fad, line.text)
        io.write_line(l);
    end

    for j = 1, line.descent + 5  do
        color_bleu = utils.interpolate(j / (line.descent + 5), color_mid, color_bot)
        color = "\\c"..color_bleu

        l.layer = 100
        l.text = string.format(
                        "{\\pos(%.3f,%.3f)\\fsp2\\bord0\\blur0.7%s\\t(%.3f,%.3f,\\blur5)\\clip(%.3f,%.3f,%.3f,%.3f)%s}%s", 
                        line.center, line.top, color, 
                        line.duration - 160, line.duration,
                        line.left - 10, math.round(line.top + line.height - line.descent + (j - 1)), 
                        line.right + 10, math.round(line.top  + line.height - line.descent + j), 
                        fad, line.text)
        io.write_line(l);
    end


    for ci, char in ipairs(line.chars) do
        l.start_time = line.start_time
        l.end_time = line.end_time
        l.layer = 0
        for s, e, i, n in utils.frames(l.start_time, l.end_time, ms_per_frame*2) do
            l.start_time = s
            l.end_time = s + ms_per_frame * 9

            shiftx = math.sin(i)*math.random(1,10)

            l.text = string.format(
                "{\\an5\\move(%.6f,%.6f,%.6f,%.6f)\\fsp0\\c&HFFFFFF&\\blur7.5\\bord0\\fscx%s\\fscy%s\\t(\\c&HF5A635&\\fscx0\\fscy0)\\fad(%.6f,%.6f)}%s", 
                char.center + math.random(-15,15) + shiftx, 
                char.middle + 5, 
                char.center + math.random(-15,15) + shiftx,
                char.middle - 50,
                math.random(80, 90),
                math.random(80, 90),
                ms_per_frame * 1, ms_per_frame * 3,
                char.text)
            io.write_line(l);
        end
    end
end


function sub(line, l)
    l.effect = "Roselia fx"

    fad = "\\fad(120,160)"

    l.start_time = line.start_time
    l.end_time = line.end_time

    l.layer = 1
    l.text = string.format(
                    "{\\pos(%.3f,%.3f)\\fsp2\\c&HFFFFFF&\\1a&HFE&\\3a&HB9&\\blur15%s}%s",
                    line.center, line.bottom, fad, line.text)
    io.write_line(l);

    l.layer = 2
    l.text = string.format(
                    "{\\pos(%.3f,%.3f)\\fsp2\\c&HFFFFFF&\\blur5%s}%s",
                    line.center, line.bottom, fad, line.text)
    io.write_line(l);

    for j = 1, line.ascent do
        color_bleu = utils.interpolate(j / line.ascent, color_top, color_mid)
        color = "\\c"..color_bleu

        l.layer = 3
        l.text = string.format(
                        "{\\pos(%.3f,%.3f)\\fsp2\\bord0\\blur0.7%s\\t(%.3f,%.3f,\\blur5)\\clip(%.3f,%.3f,%.3f,%.3f)%s}%s", 
                        line.center, line.bottom, color, 
                        line.duration - 160, line.duration,
                        line.left - 10, math.round(line.top + line.height - line.descent - line.ascent + (j - 1)), 
                        line.right + 10, math.round(line.top + line.height - line.descent - line.ascent + j), 
                        fad, line.text)
        io.write_line(l);
    end

    for j = 1, line.descent + 10  do
        color_bleu = utils.interpolate(j / (line.descent + 10), color_mid, color_bot)
        color = "\\c"..color_bleu

        l.layer = 3
        l.text = string.format(
                        "{\\pos(%.3f,%.3f)\\fsp2\\bord0\\blur0.7%s\\t(%.3f,%.3f,\\blur5)\\clip(%.3f,%.3f,%.3f,%.3f)%s}%s", 
                        line.center, line.bottom, color,
                        line.duration - 160, line.duration, 
                        line.left - 10, math.round(line.top + line.height - line.descent + (j - 1)), 
                        line.right + 10, math.round(line.top  + line.height - line.descent + j), 
                        fad, line.text)
        io.write_line(l);
    end


    for ci, char in ipairs(line.chars) do
        l.start_time = line.start_time
        l.end_time = line.end_time
        l.layer = 0
        for s, e, i, n in utils.frames(l.start_time, l.end_time, ms_per_frame*2) do
            l.start_time = s
            l.end_time = s + ms_per_frame * 9

            shiftx = math.sin(i)*math.random(1,10)

            l.text = string.format(
                "{\\an5\\move(%.6f,%.6f,%.6f,%.6f)\\c&HFFFFFF&\\blur7.5\\bord0\\fscx%s\\fscy%s\\t(\\c&HF5A635&\\fscx0\\fscy0)\\fad(%.6f,%.6f)}%s", 
                char.center + math.random(-15,15) + shiftx, 
                line.middle + 5, 
                char.center + math.random(-15,15) + shiftx,
                line.middle - 50,
                math.random(80, 90),
                math.random(80, 90),
                ms_per_frame * 1, ms_per_frame * 3,
                char.text)
            io.write_line(l);
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
