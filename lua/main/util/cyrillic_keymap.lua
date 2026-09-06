local qwerty_to_cyrillic = {
    a = "ф", b = "и", c = "с", d = "в", e = "у", f = "а",
    g = "п", h = "р", i = "ш", j = "о", k = "л", l = "д",
    m = "ь", n = "т", o = "щ", p = "з", q = "й", r = "к",
    s = "ы", t = "е", u = "г", v = "м", w = "ц", x = "ч",
    y = "н", z = "я",
    A = "Ф", B = "И", C = "С", D = "В", E = "У", F = "А",
    G = "П", H = "Р", I = "Ш", J = "О", K = "Л", L = "Д",
    M = "Ь", N = "Т", O = "Щ", P = "З", Q = "Й", R = "К",
    S = "Ы", T = "Е", U = "Г", V = "М", W = "Ц", X = "Ч",
    Y = "Н", Z = "Я",
}

local function transliterate(lhs)
    local placeholders = {}
    local result = lhs:gsub("<([^>]+)>", function(inner)
        local base = inner:gsub("^[CSMA]+%-", "")
        local idx = #placeholders + 1
        if #base > 1 then
            placeholders[idx] = "<" .. inner .. ">"
        else
            placeholders[idx] = "<" .. inner:gsub("([a-zA-Z])", function(ch)
                return qwerty_to_cyrillic[ch] or ch
            end) .. ">"
        end
        return "\1" .. tostring(idx) .. "\1"
    end)
    result = result:gsub("([a-zA-Z])", function(ch)
        return qwerty_to_cyrillic[ch] or ch
    end)
    result = result:gsub("\1(%d+)\1", function(idx)
        return placeholders[tonumber(idx)]
    end)
    return result
end

return function(mode, lhs, rhs, opts)
    local cyrillic_lhs = transliterate(lhs)
    vim.keymap.set(mode, lhs, rhs, opts)
    if cyrillic_lhs == lhs then
        return
    end
    vim.keymap.set(mode, cyrillic_lhs, rhs, opts)
end
