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
    text = ""
    for ci, char in ipairs(line.chars) do
        if char.text ~= " " then
            form = 1 - math.abs(2 * (ci - 1) / (total_char2 - 1) - 1)
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
                 "{\\pos(%.9f,%.9f)\\org(%.9f,%.9f)\\bord3.5\\1a&HFE&\\blur0.5\\be1\\c%s}%s",
                 line.center, line.top, line.center, line.top + 4735, noir, text)
    io.write_line(l);

    
    l.layer = 1
    l.text = string.format(
                 "{\\pos(%.9f,%.9f)\\org(%.9f,%.9f)\\blur0.5\\be1\\clip(m %s %s b %s %s %s %s %s %s l %s %s b %s %s %s %s %s %s)}%s",
                 line.center, line.top, line.center, line.top + 4735, 
                 p0x, p0y, q0x, q0y, q1x, q1y, p1x, p1y,
                 p1x, p1y+39, q1x, q1y+39, q0x, q0y+39, p0x, p0y+39,
                 text)
    io.write_line(l);

    for j = 1, line.ascent + line.descent do
        color = utils.interpolate(math.max(0,1-math.abs(6*(j-1)/(line.ascent + line.descent - 1)-3)), noir, rouge)
        -- print(math.max(0,1-math.abs(6*(j-1)/(line.ascent + line.descent - 1)-3)))
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
                 p0x, p0y+76, q0x, q0y+76, q1x, q1y+76, p1x, p1y+76,
                 p1x, p1y+114, q1x, q1y+114, q0x, q0y+114, p0x, p0y+114,
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
    clip = shape.move(clip, 0, -97)
    text = ""
    for ci, char in ipairs(line.chars) do
        if char.text ~= " " then
            form = 1 - math.abs(2 * (ci - 1) / (total_char2 - 1) - 1)
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
                 p0x, p0y-97, q0x, q0y-97, q1x, q1y-97, p1x, p1y-97,
                 p1x, p1y-97+39, q1x, q1y-97+39, q0x, q0y-97+39, p0x, p0y-97+39,
                 text)
    io.write_line(l);

    for j = 1, line.ascent + line.descent do
        color = utils.interpolate(math.max(0,1-math.abs(6*(j-1)/(line.ascent+line.descent- 1)-3)), noir, rouge)
        l.layer = 1
        l.text = string.format(
                     "{\\an8\\pos(%.9f,%.9f)\\org(%.9f,%.9f)\\blur0.5\\be1\\c%s\\clip(%s)}%s",
                     line.center, line.top, line.center, line.top - 4735, color, shape.move(clip, 0, j - 1),
                     text)
        io.write_line(l);
    end

    l.layer = 1
    l.text = string.format(
                 "{\\an8\\pos(%.9f,%.9f)\\org(%.9f,%.9f)\\blur0.5\\be1\\clip(m %s %s b %s %s %s %s %s %s l %s %s b %s %s %s %s %s %s)}%s",
                 line.center, line.top, line.center, line.top - 4735, 
                 p0x, p0y-97+76, q0x, q0y-97+76, q1x, q1y-97+76, p1x, p1y-97+76,
                 p1x, p1y-97+114, q1x, q1y-97+114, q0x, q0y-97+114, p0x, p0y-97+114,
                 text)
    io.write_line(l);

end

-- Process
for li, line in ipairs(lines) do
    if not line.comment then
        -- if line.i <= 2 then roumaji(line, table.copy(line)) end
        if line.i <= 22 then roumaji(line, table.copy(line)) end
        if line.i >= 23 then sub(line, table.copy(line)) end
    end
    io.progressbar(li / #lines)
end
