#! by Vardë

ms_from_frame = 1000 / 23.976

function tout(line, l)
    l.effect = "HHW fx"
    for wo, word in ipairs(line.words) do

        l.start_time = line.start_time - ms_from_frame
        l.end_time = l.start_time + line.duration / 2 
        if word.i % 2 == 0 then
            transform = string.format(
                "\\fscx0\\fscy0\\t(0,%.9f,0.75,\\fscx%s\\fscy%s)\\t(%.9f,%.9f,0.75,\\fscx%s\\fscy%s)",
                ms_from_frame*4, line.styleref.scale_x*1.3, line.styleref.scale_y*1.3,
                ms_from_frame*4, ms_from_frame*6,
                line.styleref.scale_x, line.styleref.scale_y)
            bord0 = string.format(
                "\\bord0\\t(0,%.9f,0.75,\\bord%s)\\t(%.9f,%.9f,0.75,\\bord%s)",
                ms_from_frame*4, 12*1.3,
                ms_from_frame*4, ms_from_frame*6, 12)
            bord1 = string.format(
                "\\bord0\\t(0,%.9f,0.75,\\bord%s)\\t(%.9f,%.9f,0.75,\\bord%s)",
                ms_from_frame*4, 6*1.3,
                ms_from_frame*4, ms_from_frame*6, 6)
        else
            transform = string.format(
                "\\fscx%s\\fscy%s\\t(0,%.9f,0.75,\\fscx%s\\fscy%s)\\t(%.9f,%.9f,0.75,\\fscx%s\\fscy%s)",
                 line.styleref.scale_x*1.7, line.styleref.scale_y*1.7,
                 ms_from_frame*4, line.styleref.scale_x*0.7, line.styleref.scale_y*0.7,
                 ms_from_frame*4, ms_from_frame*6,
                 line.styleref.scale_x, line.styleref.scale_y)
            bord0 = string.format(
                "\\bord%s\\t(0,%.9f,0.75,\\bord%s)\\t(%.9f,%.9f,0.75,\\bord%s)",
                12*2, ms_from_frame*4, 12*0.7,
                ms_from_frame*4, ms_from_frame*6, 12)
            bord1 = string.format(
                "\\bord%s\\t(0,%.9f,0.75,\\bord%s)\\t(%.9f,%.9f,0.75,\\bord%s)",
                6*2, ms_from_frame*4, 6*0.7,
                ms_from_frame*4, ms_from_frame*6, 6)
        end

        l.layer = 0
        l.text = string.format(
                        "{\\an5\\pos(%.9f,%.9f)\\3c&H020E54&\\1a&HFE&\\blur0.5%s}%s",
                        word.center, word.middle, transform .. bord0, word.text)
        io.write_line(l);
    
        l.layer = 1
        l.text = string.format(
                        "{\\an5\\pos(%.9f,%.9f)\\1a&HFE&\\blur0.5%s}%s",
                        word.center, word.middle, transform.. bord1, word.text)
        io.write_line(l);
    
        l.layer = 2
        l.text = string.format(
                        "{\\an5\\pos(%.9f,%.9f)\\blur0.5%s}%s",
                        word.center, word.middle, transform, word.text)
        io.write_line(l);


        l.start_time = l.end_time 
        l.end_time = line.end_time

        transform = string.format(
            "\\t(%.9f,%.9f,0.5,\\fscx0\\fscy0\\bord0)",
            line.duration/2 - ms_from_frame*4, line.duration/2)

        l.layer = 0
        l.text = string.format(
                        "{\\an5\\pos(%.9f,%.9f)\\bord12\\3c&H020E54&\\1a&HFE&\\blur0.5%s}%s",
                        word.center, word.middle, transform, word.text)
        io.write_line(l);
    
        l.layer = 1
        l.text = string.format(
                        "{\\an5\\pos(%.9f,%.9f)\\bord6\\1a&HFE&\\blur0.5%s}%s",
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
