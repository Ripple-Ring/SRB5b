
-- opacandaestar
-- -pac

states[freeslot("S_SRB5B_GANGNAM")] = {
    sprite = SPR_PLAY,
    frame = SPR2_MSC0,
    tics = -1
}

---@param skin integer | string
---@param spr2 integer
local function getSPR2FrameCount(skin, spr2)
    local sprites = skins[skin].sprites

    local count
    while spr2 ~= SPR2_STND
    and not count do
        count = sprites[spr2].numframes
        spr2 = spr2defaults[$]
    end

    return (count or 1)
end

addHook("PlayerThink", function(p)
    if not (p.mo and SRB5b.is5bChar(p.mo.skin)) then return end

    local pmo = p.mo ---@type mobj_t

    if (p.cmd.buttons & BT_CUSTOM3)
    and not (p.lastbuttons & BT_CUSTOM3)
    and (p.panim == PA_IDLE or p.panim == PA_EDGE) then
        p.bookgangnam = not $

        local old_panim = p.panim
        pmo.state = S_SRB5B_GANGNAM
        p.panim = old_panim
    end

    if p.bookgangnam then
        p.pflags = $1|PF_FULLSTASIS

        if pmo.state == S_SRB5B_GANGNAM then
            local count = getSPR2FrameCount(pmo.skin, pmo.sprite2)
            pmo.frame = ((leveltime / 2) % count) | ($ & ~FF_FRAMEMASK)
        else
            p.bookgangnam = not $
        end
    elseif pmo.state == S_SRB5B_GANGNAM then
        pmo.state = S_PLAY_STND
    end
end)