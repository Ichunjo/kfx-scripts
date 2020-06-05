#! by Vardë

ms_from_frame = 1000 / 23.976

function tout(line, l)
    l.effect = "HHW fx"
    for wo, word in ipairs(line.words) do

        -- Début
        l.start_time = line.start_time - ms_from_frame*3
        l.end_time = line.start_time + ms_from_frame*3
        if word.i % 2 == 0 then
            transform = string.format(
                "\\fry270\\t(\\fry0)")
        else
            transform = string.format(
                "\\fry-270\\t(\\fry0)")
        end

        l.layer = 0
        l.text = string.format(
                        "{\\an5\\pos(%.9f,%.9f)\\bord0\\t(\\bord12)\\3c&H020E54&\\1a&HFE&\\blur0.5%s}%s",
                        word.center, word.middle, transform, word.text)
        io.write_line(l);
    
        l.layer = 1
        l.text = string.format(
                        "{\\an5\\pos(%.9f,%.9f)\\bord0\\t(\\bord6)\\1a&HFE&\\blur0.5%s}%s",
                        word.center, word.middle, transform, word.text)
        io.write_line(l);
    
        l.layer = 2
        l.text = string.format(
                        "{\\an5\\pos(%.9f,%.9f)\\blur0.5%s}%s",
                        word.center, word.middle, transform, word.text)
        io.write_line(l);


        -- Milieu
        l.start_time = l.end_time 
        l.end_time = line.end_time - ms_from_frame*6
        duration = l.end_time - l.start_time

        l.layer = 0
        l.text = string.format(
                        "{\\an5\\pos(%.9f,%.9f)\\bord12\\3c&H020E54&\\1a&HFE&\\blur0.5}%s",
                        word.center, word.middle, word.text)
        io.write_line(l);
    
        l.layer = 1
        l.text = string.format(
                        "{\\an5\\pos(%.9f,%.9f)\\bord6\\1a&HFE&\\blur0.5}%s",
                        word.center, word.middle, word.text)
        io.write_line(l);
    
        l.layer = 2
        l.text = string.format(
                        "{\\an5\\pos(%.9f,%.9f)\\blur0.5}%s",
                        word.center, word.middle, word.text)
        io.write_line(l);

        -- Fin
        l.start_time = l.end_time 
        l.end_time = line.end_time

        if word.i % 2 == 0 then
            transform = "\\t(\\fry270)"
        else
            transform = "\\t(\\fry-270)"
        end

        l.layer = 0
        l.text = string.format(
                        "{\\an5\\pos(%.9f,%.9f)\\bord12\\t(\\bord0)\\3c&H020E54&\\1a&HFE&\\blur0.5%s}%s",
                        word.center, word.middle, transform, word.text)
        io.write_line(l);
    
        l.layer = 1
        l.text = string.format(
                        "{\\an5\\pos(%.9f,%.9f)\\bord6\\t(\\bord0)\\1a&HFE&\\blur0.5%s}%s",
                        word.center, word.middle, transform, word.text)
        io.write_line(l);
    
        l.layer = 2
        l.text = string.format(
                        "{\\an5\\pos(%.9f,%.9f)\\blur0.5%s}%s",
                        word.center, word.middle, transform, word.text)
        io.write_line(l);

    end
end

-- Process
for li, line in ipairs(lines) do
    if not line.comment then
        tout(line, table.copy(line))
    end
    io.progressbar(li / #lines)
end
