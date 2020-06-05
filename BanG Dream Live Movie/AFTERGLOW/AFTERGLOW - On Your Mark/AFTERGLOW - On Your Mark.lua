#! by Vardë

noir = "&H000000&"
rouge = "&H0000FF&"

ms_from_frame = 1000 / 23.976

function char_counter(line)
    local compteur = 0
    for ci, char in ipairs(line.chars) do
        if char.text ~= " " then compteur = compteur + 1 end
    end
    return compteur
end

function char_counter2(line)
    local compteur = 0
    for ci, char in ipairs(line.chars) do compteur = compteur + 1 end
    return compteur
end

function roumaji(line, l)
    l.effect = "Afterglow fx"

    l.start_time = line.start_time
    l.end_time = line.end_time

    total_char2 = char_counter2(line)
    p0x, p0y = 0,                               math.round(line.bottom)
    p1x, p1y = meta.width,                      math.round(line.bottom)
    q0x, q0y = meta.width/3 + 2,                math.round(line.top) - 15 - 12
    q1x, q1y = meta.width - meta.width/3 - 2,   math.round(line.top) - 15 - 12

    clip = string.format("m %s %s b %s %s %s %s %s %s l %s %s b %s %s %s %s %s %s",
                        p0x, p0y, q0x, q0y, q1x, q1y, p1x, p1y,
                        p1x, p1y+1, q1x, q1y+1, q0x, q0y+1, p0x, p0y+1)

    shift = 10
    clip = shape.move(clip, 0, shift)
    text = ""
    for ci, char in ipairs(line.chars) do
        if char.text ~= " " then
            -- form = 1 - math.abs(2 * (ci - 1) / (total_char2 - 1) - 1)
            -- form = math.abs(math.abs(4 * (ci - 1) / (total_char2 - 1) - 2) - 1)
            -- form = math.abs((4 * (ci - 1) / (total_char2 - 2)^2 - 2))
            form = math.abs(math.abs(math.cos(2 * math.pi * (ci - 1) / (total_char2 - 1))) - 1)
            -- print(form)
            text = text .. string.format(
                                "{\\alpha&HFF&\\t(%.9f,%.9f,\\alpha&H00&)\\t(%.9f,%.9f,\\alpha&HFF&)}",
                                ms_from_frame * 2 * form,
                                ms_from_frame * 3 * form + ms_from_frame,
                                (line.duration - ms_from_frame) - ms_from_frame * 3 * form, 
                                line.duration - ms_from_frame * 2 * form) .. char.text
        end
        if char.text == " " then
            text = text .. " "
        end
    end

    l.layer = 0
    l.text = string.format(
                 "{\\pos(%.9f,%.9f)\\org(%.9f,%.9f)\\bord3.5\\1a&HFE&\\blur0.5\\be1\\c%s}%s",
                 line.center, line.top, line.center, line.top + 4735, noir, text)
    io.write_line(l);

    
    l.layer = 1
    l.text = string.format(
                 "{\\pos(%.9f,%.9f)\\org(%.9f,%.9f)\\blur0.5\\be1\\clip(m %s %s b %s %s %s %s %s %s l %s %s b %s %s %s %s %s %s)}%s",
                 line.center, line.top, line.center, line.top + 4735, 
                 p0x, p0y, q0x, q0y, q1x, q1y, p1x, p1y,
                 p1x, p1y+45 + shift, q1x, q1y+45 + shift, q0x, q0y+45 + shift, p0x, p0y+45 + shift,
                 text)
    io.write_line(l);

    for j = 1, line.ascent + line.descent do
        color = utils.interpolate(math.max(0,1-math.abs(5*(j-1)/(line.ascent + line.descent - 1)-2.5)), noir, rouge)
        -- color = utils.interpolate(math.abs(math.sin(2 * math.pi * (j-1) / (line.ascent + line.descent - 1))), noir, rouge)
        -- color = utils.interpolate(math.abs(math.abs(4 *  (j-1) / (line.ascent + line.descent - 1) - 2) - 1), noir, rouge)
        -- print(math.max(0,1-math.abs(10*(j-1)/(line.ascent + line.descent - 1)-5)))
        if color ~= "&H000000&" then
            l.layer = 1
            l.text = string.format(
                            "{\\pos(%.9f,%.9f)\\org(%.9f,%.9f)\\blur0.5\\be1\\c%s\\clip(%s)}%s",
                            line.center, line.top, line.center, line.top + 4735, color, shape.move(clip, 0, (j - 1)),
                            text)
            io.write_line(l);
        end
    end
    l.layer = 1
    l.text = string.format(
                 "{\\pos(%.9f,%.9f)\\org(%.9f,%.9f)\\blur0.5\\be1\\clip(m %s %s b %s %s %s %s %s %s l %s %s b %s %s %s %s %s %s)}%s",
                 line.center, line.top, line.center, line.top + 4735, 
                 p0x, p0y+69 + shift, q0x, q0y+69 + shift, q1x, q1y+69 + shift, p1x, p1y+69 + shift,
                 p1x, p1y+114 + shift, q1x, q1y+114 + shift, q0x, q0y+114 + shift, p0x, p0y+114 + shift,
                 text)
    io.write_line(l);
end

function sub(line, l)
    l.effect = "Afterglow fx"

    l.start_time = line.start_time
    l.end_time = line.end_time

    total_char2 = char_counter2(line)
    p0x, p0y = 0,                               math.round(line.top)
    p1x, p1y = meta.width,                      math.round(line.top)
    q0x, q0y = meta.width/3 + 2,                math.round(line.bottom) + 15 + 12
    q1x, q1y = meta.width - meta.width/3 - 2,   math.round(line.bottom) + 15 + 12

    clip = string.format("m %s %s b %s %s %s %s %s %s l %s %s b %s %s %s %s %s %s",
                        p0x, p0y, q0x, q0y, q1x, q1y, p1x, p1y,
                        p1x, p1y+1, q1x, q1y+1, q0x, q0y+1, p0x, p0y+1)
    -- print(clip)
    shift = 82
    clip = shape.move(clip, 0, -82)
    text = ""
    for ci, char in ipairs(line.chars) do
        if char.text ~= " " then
            -- form = 1 - math.abs(2 * (ci - 1) / (total_char2 - 1) - 1)
            -- form = math.abs(math.abs(4 * (ci - 1) / (total_char2 - 1) - 2) - 1)
            form = math.abs(math.abs(math.cos(2 * math.pi * (ci - 1) / (total_char2 - 1))) - 1)
            text = text .. string.format(
                                "{\\alpha&HFF&\\t(%.9f,%.9f,\\alpha&H00&)\\t(%.9f,%.9f,\\alpha&HFF&)}",
                                ms_from_frame * 4 * form,
                                ms_from_frame * 5 * form + ms_from_frame,
                                (line.duration - ms_from_frame) - ms_from_frame * 5 * form, 
                                line.duration - ms_from_frame * 4 * form) .. char.text
        end
        if char.text == " " then
            text = text .. " "
        end
    end

    l.layer = 0
    l.text = string.format(
                 "{\\an8\\pos(%.9f,%.9f)\\org(%.9f,%.9f)\\bord3.5\\1a&HFE&\\blur0.5\\be1\\c%s}%s",
                 line.center, line.top, line.center, line.top - 4735, noir, text)
    io.write_line(l);


    l.layer = 1
    l.text = string.format(
                 "{\\an8\\pos(%.9f,%.9f)\\org(%.9f,%.9f)\\blur0.5\\be1\\clip(m %s %s b %s %s %s %s %s %s l %s %s b %s %s %s %s %s %s)}%s",
                 line.center, line.top, line.center, line.top - 4735, 
                 p0x, p0y-shift, q0x, q0y-shift, q1x, q1y-shift, p1x, p1y-shift,
                 p1x, p1y-shift+44, q1x, q1y-shift+44, q0x, q0y-shift+44, p0x, p0y-shift+44,
                 text)
    io.write_line(l);

    for j = 1, line.ascent + line.descent do
        color = utils.interpolate(math.max(0,1-math.abs(5*(j-1)/(line.ascent + line.descent - 1)-2.5)), noir, rouge)
        if color ~= "&H000000&" then
            l.layer = 1
            l.text = string.format(
                         "{\\an8\\pos(%.9f,%.9f)\\org(%.9f,%.9f)\\blur0.5\\be1\\c%s\\clip(%s)}%s",
                         line.center, line.top, line.center, line.top - 4735, color, shape.move(clip, 0, j - 1),
                         text)
            io.write_line(l);
        end
    end

    l.layer = 1
    l.text = string.format(
                 "{\\an8\\pos(%.9f,%.9f)\\org(%.9f,%.9f)\\blur0.5\\be1\\clip(m %s %s b %s %s %s %s %s %s l %s %s b %s %s %s %s %s %s)}%s",
                 line.center, line.top, line.center, line.top - 4735, 
                 p0x, p0y-shift+66, q0x, q0y-shift+66, q1x, q1y-shift+66, p1x, p1y-shift+66,
                 p1x, p1y-shift+109, q1x, q1y-shift+109, q0x, q0y-shift+109, p0x, p0y-shift+109,
                 text)
    io.write_line(l);

end

-- Process
for li, line in ipairs(lines) do
    if not line.comment then
        if line.styleref.alignment == 8 then 
            roumaji(line, table.copy(line))
        else
            sub(line, table.copy(line))
        end
        -- if line.i == 1 then roumaji(line, table.copy(line)) end
        -- if line.i >= 25 then sub(line, table.copy(line)) end
    end
    io.progressbar(li / #lines)
end
