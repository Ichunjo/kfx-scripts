#! by Vardë

ms_per_frame = 1000 / 23.976

logo_pasupare = "m -10 -6 b -7 -8 -3 -5 -2 -1 b -6 0 -11 -2 -10 -6 m 0 -3 b -4 -6 -3 -11 0 -12 b 3 -11 4 -6 0 -3 m 2 -1 b 3 -5 6 -8 10 -6 b 11 -2 8 0 2 -1 m 2 1 b 6 1 11 1 10 6 b 6 9 4 5 2 1 m 0 3 b 2 4 5 10 0 12 b -5 10 -2 4 0 3 m -2 1 b -4 5 -6 9 -10 6 b -11 3 -8 0 -2 1 "


function lignes(l, posx, posy, text, tag_opt)
    if tag_opt == nil then
        tag_opt = ""
    end
    l.layer = 5
    l.text = string.format(
                    "{\\an5\\pos(%.6f,%.6f)\\bord0\\be1%s}%s",
                    posx, posy, tag_opt, text)
    io.write_line(l);
    l.layer = 4
    l.text = string.format(
                    "{\\an5\\pos(%.6f,%.6f)\\1a&HFE&%s}%s",
                    posx, posy, tag_opt, text)
    io.write_line(l);
    l.layer = 3
    l.text = string.format(
                    "{\\an5\\pos(%.6f,%.6f)\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad1\\be1%s}%s",
                    posx, posy, tag_opt, text)
    io.write_line(l);
    l.layer = 2
    l.text = string.format(
                    "{\\an5\\pos(%.6f,%.6f)\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad2\\3a&HFF&\\be1%s}%s",
                    posx, posy, tag_opt, text)
    io.write_line(l);
    l.layer = 1
    l.text = string.format(
                    "{\\an5\\pos(%.6f,%.6f)\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad3\\3a&HFF&\\be1%s}%s",
                    posx, posy, tag_opt, text)
    io.write_line(l);
    l.layer = 0
    l.text = string.format(
                    "{\\an5\\pos(%.6f,%.6f)\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad4\\3a&HFF&\\be1%s}%s",
                    posx, posy, tag_opt, text)
    io.write_line(l);
end


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
    l.effect = "PASUPARE fx"

    total_char = char_counter(line)

    if line.actor == "two" then
        yshift = line.height
    else
        yshift = 0
    end

    for wo, word in ipairs(line.words) do
        l.start_time = line.start_time - ms_per_frame*3
        l.end_time = line.start_time + line.duration / 2

        if word.i % 2 == 0 then 
            shift = 50 
        else 
            shift = -50
        end

        move = string.format(
            "\\move(%.3f,%.3f,%.3f,%.3f,0,%.3f)",
            word.center, word.middle - shift - yshift, word.center, word.middle - yshift, ms_per_frame * 3
        )

        l.layer = 5
        l.text = string.format(
                        "{\\an5\\bord0\\be1%s\\fad(126,0)}%s",
                        move, word.text)
        io.write_line(l);
        l.layer = 4
        l.text = string.format(
                        "{\\an5\\1a&HFE&%s\\fad(126,0)}%s",
                        move, word.text)
        io.write_line(l);
        l.layer = 3
        l.text = string.format(
                        "{\\an5\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad1\\be1%s\\fad(126,0)}%s",
                        move, word.text)
        io.write_line(l);
        l.layer = 2
        l.text = string.format(
                        "{\\an5\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad2\\3a&HFF&\\be1%s\\fad(126,0)}%s",
                        move, word.text)
        io.write_line(l);
        l.layer = 1
        l.text = string.format(
                        "{\\an5\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad3\\3a&HFF&\\be1%s\\fad(126,0)}%s",
                        move, word.text)
        io.write_line(l);
        l.layer = 0
        l.text = string.format(
                        "{\\an5\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad4\\3a&HFF&\\be1%s\\fad(126,0)}%s",
                        move, word.text)
        io.write_line(l);
        
        -- 2
        l.start_time = l.end_time
        l.end_time = line.end_time

        if word.i % 2 == 0 then 
            shift = -50
        else 
            shift = 50
        end

        move = string.format(
            "\\move(%.3f,%.3f,%.3f,%.3f,%.3f,%.3f)",
            word.center, word.middle - yshift, word.center, word.middle - shift - yshift, l.end_time - l.start_time - ms_per_frame * 3, l.end_time - l.start_time
        )

        l.layer = 5
        l.text = string.format(
                        "{\\an5\\bord0\\be1%s\\fad(0,126)}%s",
                        move, word.text)
        io.write_line(l);
        l.layer = 4
        l.text = string.format(
                        "{\\an5\\1a&HFE&%s\\fad(0,126)}%s",
                        move, word.text)
        io.write_line(l);
        l.layer = 3
        l.text = string.format(
                        "{\\an5\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad1\\be1%s\\fad(0,126)}%s",
                        move, word.text)
        io.write_line(l);
        l.layer = 2
        l.text = string.format(
                        "{\\an5\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad2\\3a&HFF&\\be1%s\\fad(0,126)}%s",
                        move, word.text)
        io.write_line(l);
        l.layer = 1
        l.text = string.format(
                        "{\\an5\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad3\\3a&HFF&\\be1%s\\fad(0,126)}%s",
                        move, word.text)
        io.write_line(l);
        l.layer = 0
        l.text = string.format(
                        "{\\an5\\bord2.75\\1a&HFE&\\3c&HD8BCF8&\\4c&HD8BCF8&\\yshad4\\3a&HFF&\\be1%s\\fad(0,126)}%s",
                        move, word.text)
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
