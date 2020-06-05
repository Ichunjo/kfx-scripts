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


function char_counter2(line)
    local compteur = 0
    for ci, char in ipairs(line.chars) do compteur = compteur + 1 end
    return compteur
end

function sub(line, l)
    l.effect = "PASUPARE fx"

    total_char2 = char_counter2(line)

    l.start_time = line.start_time
    l.end_time = line.end_time

    if line.actor == "two" then
        yshift = line.height
    else
        yshift = 0
    end

    text = ""
    for ci, char in ipairs(line.chars) do
        form = math.abs(1 - math.abs(2 * (ci - 1) / (total_char2 - 1) - 1) - 1)
        text = text .. string.format(
            "{\\fsp%.3f\\t(0,%.3f,\\fsp0)\\t(%.3f,%.3f,\\fsp%.3f)}",
            form * 20, ms_per_frame * 3, line.duration - ms_per_frame * 3, line.duration, form * -15
        ) .. char.text
    end

    lignes(l, line.center, line.middle - yshift, text, "\\fad(126,126)")
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
