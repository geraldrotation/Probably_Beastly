function ts.cc()
    local cc = {
        115078,
        118,
        61305,
        28272,
        61721,
        61780,
        28271,
        1499,
        19386,
        6358,
        2637,
        33786,
        20066,
        6770,
        2094,
        '\"Serpent Sting\"',
    }
    
    local a = 'yes'
    
    for ccCount = 1, #cc do
        if UnitDebuff("target", (cc[ccCount])) then
            print(a)
            return true
        end
    end
end