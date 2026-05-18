
rawset(_G, "SRB5b", {})

---@param skin integer | string
function SRB5b.is5bChar(skin)
    skin = skins[$].name
    return (
        skin == "book"
        or skin == "icecube"
        or skin == "match"
    )
end

dofile("General/gangnam style.lua")