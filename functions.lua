-----------------------------------------------------------------------------------------------------------------------------
-- Initialize Tables -------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
local ts = {} 

ts.queueSpell = nil
ts.queueTime = 0
-----------------------------------------------------------------------------------------------------------------------------
-- Notify Frame -- (c)xrn overlay for pqr -----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
    local function onUpdate(self,elapsed) 
      if self.time < GetTime() - 2.5 then
        if self:GetAlpha() == 0 then self:Hide() else self:SetAlpha(self:GetAlpha() - .05) end
      end
    end
    ecn = CreateFrame("Frame",nil,ChatFrame1) 
    ecn:SetSize(ChatFrame1:GetWidth(),30)
    ecn:Hide()
    ecn:SetScript("OnUpdate",onUpdate)
    ecn:SetPoint("TOPLEFT",0,150)
    ecn.text = ecn:CreateFontString(nil,"OVERLAY","MovieSubtitleFont")
    ecn.text:SetAllPoints()
    ecn.texture = ecn:CreateTexture()
    ecn.texture:SetAllPoints()
    ecn.texture:SetTexture(0,0,0,.50) 
    ecn.time = 0
    function ecn:message(message) 
      self.text:SetText(message)
      self:SetAlpha(1)
      self.time = GetTime() 
      self:Show() 
    end
    
    local function onUpdate(self,elapsed) 
      if self.time < GetTime() - 2.8 then
        if self:GetAlpha() == 0 then self:Hide() else self:SetAlpha(self:GetAlpha() - .05) end
      end
    end
    ecn = CreateFrame("Frame",nil,ChatFrame1) 
    ecn:SetSize(ChatFrame1:GetWidth(),30)
    ecn:Hide()
    ecn:SetScript("OnUpdate",onUpdate)
    ecn:SetPoint("TOP",0,0)
    ecn.text = ecn:CreateFontString(nil,"OVERLAY","MovieSubtitleFont")
    ecn.text:SetAllPoints()
    ecn.texture = ecn:CreateTexture()
    ecn.texture:SetAllPoints()
    ecn.texture:SetTexture(0,0,0,.50) 
    ecn.time = 0
    function ecn:message(message) 
      self.text:SetText(message)
      self:SetAlpha(1)
      self.time = GetTime() 
      self:Show() 
    end
    
    
    
ProbablyEngine.command.register('ts', function(msg, box)
  local command, text = msg:match("^(%S*)%s*(.-)$")

-----------------------------------------------------------------------------------------------------------------------------
-- Toggle -------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
  if command == 'pause' then
    if ProbablyEngine.config.read('button_states', 'MasterToggle', false) then
        ProbablyEngine.buttons.toggle('MasterToggle')
        ecn:message("|cFFB30000Beastly DISABLED")
    else
        ProbablyEngine.buttons.toggle('MasterToggle')
        ecn:message("|cFF00B34ABeastly ENABLED")
    end
  end
  if command == 'kick' then
    if ProbablyEngine.config.read('button_states', 'interrupt', false) then
      ProbablyEngine.buttons.toggle('interrupt')
      ecn:message("|cFFB30000Interrupts DISABLED")
    else
      ProbablyEngine.buttons.toggle('interrupt')
      ecn:message("|cFF00B34AInterrupts ENABLED")
    end
  end

  if command == 'cooldowns' then
    if ProbablyEngine.config.read('button_states', 'cooldowns', false) then
      ProbablyEngine.buttons.toggle('cooldowns')
      ecn:message("|cFFB30000Offensive Cooldowns DISABLED")
    else
      ProbablyEngine.buttons.toggle('cooldowns')
      ecn:message("|cFF00B34AOffensive Cooldowns ENABLED")
    end
  end

  if command == 'aoe' then
    if ProbablyEngine.config.read('button_states', 'multitarget', false) then
      ProbablyEngine.buttons.toggle('multitarget')
      ecn:message("|cFFB30000AoE DISABLED")
    else
      ProbablyEngine.buttons.toggle('multitarget')
      ecn:message("|cFF00B34AAoE ENABLED")
    end
  end

  if command == 'aspect' then
    if ProbablyEngine.config.read('button_states', 'aspect', false) then
      ProbablyEngine.buttons.toggle('aspect')
      ecn:message("|cFFB30000Auto Aspect DISABLED")
    else
      ProbablyEngine.buttons.toggle('aspect')
      ecn:message("|cFF00B34AAuto Aspect ENABLED")
    end
  end

-----------------------------------------------------------------------------------------------------------------------------
-- Spell Queue -- thank you merq for basic code -----------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
  if command == "Concussive" or command == 5116 then
    ts.queueSpell = 5116
    ecn:message("Concussive Shot queued")
  elseif command == "Widow" or command == 82654 then
    ts.queueSpell = 82654
    ecn:message("Widow Venom queued")
  elseif command == "Tranquilizing" or command == 19801 then
    ts.queueSpell = 19801
    ecn:message("Tranquilizing Shot queued")
  elseif command == "amoc" or command == 131894 then
    ts.queueSpell = 131894
    ecn:message("A Murder of Crows queued")
  elseif command == "Lynx" or command == 120697 then
    ts.queueSpell = 120697
    ecn:message("Lynx Rush queued")
  elseif command == "Intimidation" or command == 19577 then
    ts.queueSpell = 19577
    ecn:message("Intimidation queued") 
  else
    ts.queueSpell = nil
  end
  if ts.queueSpell ~= nil then ts.queueTime = GetTime() end
end)
-----------------------------------------------------------------------------------------------------------------------------
-- Spell Queue Check -- thank you merq for basic code ----------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
ts.checkQueue = function (spellId)
    if (GetTime() - ts.queueTime) > 2 then
        ts.queueTime = 0
        ts.queueSpell = nil
    return false
    else
    if ts.queueSpell then
        if ts.queueSpell == spellId then
            if ProbablyEngine.parser.lastCast == GetSpellName(spellId) then
                ts.queueSpell = nil
                ts.queueTime = 0
                if spellId == 5116 then
                    ecn:message("|cFFB30000Concussive Shot casted")
                elseif spellId == 82654 then
                    ecn:message("|cFFB30000Widow Venom casted")
                elseif spellId == 19801 then
                    ecn:message("|cFFB30000Tranq Shot casted")
                elseif spellId == 131894 then
                    ecn:message("|cFFB30000A Murder of Crows casted")
                elseif spellId == 120697 then
                    ecn:message("|cFFB30000Lynx rush casted")
                end
            end
        return true
        end
    end
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------
-- Check for T16 2Piece------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

function ts.t16()
    local counter = 0
    
    if IsEquippedItem(99080) or IsEquippedItem(99660) or IsEquippedItem(99157) or IsEquippedItem(99402) then
        counter = counter + 1
    end
    
    if IsEquippedItem(99082) or IsEquippedItem(99574) or IsEquippedItem(99159) or IsEquippedItem(99404) then
        counter = counter + 1
    end
    
    if IsEquippedItem(99085) or IsEquippedItem(99577) or IsEquippedItem(99167) or IsEquippedItem(99405) then
        counter = counter + 1
    end
    
    if IsEquippedItem(99081) or IsEquippedItem(99573) or IsEquippedItem(99158) or IsEquippedItem(99403) then
        counter = counter + 1
    end
    
    if IsEquippedItem(99086) or IsEquippedItem(99578) or IsEquippedItem(99168) or IsEquippedItem(99406) then
        counter = counter + 1
    end
    
    if counter >= 2 then
        return true
    end
end

-----------------------------------------------------------------------------------------------------------------------------
-- Rabid---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

function ts.rabid()
    local start, duration, enabled = GetSpellCooldown(53401)
    
    if UnitBuff("player", "The Beast Within") then
        if duration == 0 then
            return true
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------
-- Cobra shot & kill command-------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

function ts.casttime(spellId)
    --Get cast time for spellID
    local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(spellId)
    --Check world latency
    local down, up, lagHome, lagWorld = GetNetStats()
    --Change castTime from milliseconds to seconds
    local mstos = ((castTime + lagWorld) / 1000)
    --Get the Current Time
    local current_time = GetTime()
    --Get time that Kill Command was casted at
    local start, duration, enabled = GetSpellCooldown(34026)
    --Calculate time elapsed
    local time_elapsed = (current_time - start)
    --Calculate Cooldown remaining
    local cooldown_remaining = (duration - time_elapsed)
    
    if duration == 0 then
        return false
    end
    
    if cooldown_remaining >= mstos then
        return true
    end
end


-----------------------------------------------------------------------------------------------------------------------------
-- Cobra shot doesn't cap us-------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

function ts.cobra(spellId)
    local max_focus = UnitPowerMax("player")
    local current_focus = UnitPower("player")
    local regen_focus = GetPowerRegen()
    local missing_focus = (max_focus - current_focus)
    local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(spellId)
    local mstos = (castTime / 1000)
    
    local ttf = (current_focus + 14) + (mstos*regen_focus)
    
    if ttf >= 105 then
        return false
    elseif ttf < 105 then
        return true
    end
end

-----------------------------------------------------------------------------------------------------------------------------
-- GCD doesnt clip kill command----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

function ts.clip()
    --Get the Current Time
    local current_time = GetTime()
    --Get time that Kill Command was casted at
    local start, duration, enabled = GetSpellCooldown(34026)
    --Calculate time elapsed
    local time_elapsed = (current_time - start)
    --Calculate Cooldown remaining
    local cooldown_remaining = (duration - time_elapsed)
    --Check world latency
    local down, up, lagHome, lagWorld = GetNetStats()
    --Calculate GCD
    local haste = UnitSpellHaste("player")
    --local gcd = (1.5 / ((haste/100) + 1)) + (lagWorld/1000)
    local gcd = (1 + (lagWorld/1000))
    
    if duration == 0 then
        return false
    end
    
    if cooldown_remaining >= gcd then
        return true
    end
end

-----------------------------------------------------------------------------------------------------------------------------
-- Focus Fire----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

function ts.focusfire()
    --Do we have Bestial Wrath up?
    if UnitBuff("player", "The Beast Within") then
        return false
    end
    --Check stacks of Frenzy
    local spell={UnitBuff("player", "Frenzy")} 
        if UnitBuff("player", "Frenzy") and spell[4]==5 then
        return true
    end
end
    
--/run local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitBuff("player", "Aspect of the Iron Hawk"); print(icon)

-----------------------------------------------------------------------------------------------------------------------------
-- Pause for CC--------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
function ts.cc()
    local cc = {
        115078, --Paralysis
        118, --Polymorph
        61305, --Polymorph
        28272, --Polymorph
        61721, --Polymorph
        61780, --Polymorph
        28271, --Polymorph
        1499, --Freezing Trap
        19386, --Wyvern sting
        6358, --Seductions
        2637, --Hibernate
        33786, --Cyclone
        20066, --Repentance
        6770, --Sap
        2094, --Blind
    }
    
    
    for i=1,25 do
        for j=1,#cc do
            local _,_,_,_,_,_,_,_,_,_,spellId = UnitDebuff("target", i)
            if spellId == (cc[j]) then
                PetFollow()
                StopAttack()
                return true
            end
        end
    end
end

--/run local cc={ 118253, 1130, }; for i=1,25 do for j=1,#cc do local _,_,_,_,_,_,_,_,_,_,spellId = UnitDebuff("target", i); if spellId == (cc[j]) then print(spellId) end end end

-----------------------------------------------------------------------------------------------------------------------------
-- In Party or Raid (Misdirection)?------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

function ts.misdirect()
    --local membersRaid = GetNumRaidMembers()
    local membersParty = GetNumGroupMembers()
    
    local party = { "party1", "party2", "party3", "party4" }
    local raid = { "raid1", "raid2", "raid3", "raid4", "raid5", "raid6", "raid7", "raid8", "raid9", "raid10", "raid11", "raid12", "raid13", "raid14", "raid15", "raid16", "raid17", "raid18", "raid19", "raid20", "raid21", "raid22", "raid23", "raid24", "raid25" } 
    
    if IsInGroup() and membersParty <= 5 then
        for i=1,membersParty do
            role[i] = UnitGroupRolesAssigned(party[i])
            if role[i] == "TANK" then
                return false
            end
        end
    elseif IsInRaid() and membersParty > 5 then
        for i=1,membersParty do
            role[i] = UnitGroupRolesAssigned(raid[i])
            if role[i] == "TANK" then
                return false
            end
        end
    end
    return true
end

-----------------------------------------------------------------------------------------------------------------------------
-- Time to Max Focus---------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
--[[    
function ts.focus(value)    
    local max_focus = UnitPowerMax("player")
    local current_focus = UnitPower("player")
    local regen_focus = GetPowerRegen()
    local missing_focus = (max_focus - current_focus)
    local ttf = (missing_focus / regen_focus)
]]
-----------------------------------------------------------------------------------------------------------------------------
-- Time to Max Energy -------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------

function ts.energyless(value)
    local max_energy = UnitPowerMax("player")
    local current_energy = UnitPower("player")
    local energy_regen = GetPowerRegen()
    local energy_missing = (max_energy - current_energy)
    local ttm = (energy_missing / energy_regen)
    
    if ttm <= value then
        return true
    end
end

function ts.energygreater(value)
    local max_energy = UnitPowerMax("player")
    local current_energy = UnitPower("player")
    local energy_regen = GetPowerRegen()
    local energy_missing = (max_energy - current_energy)
    local ttm = (energy_missing / energy_regen)
    
    if ttm >= value then
        return true
    end
end

-----------------------------------------------------------------------------------------------------------------------------
-- Healthstone -------------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
function ts.Healthstone(...)
    local PlayerHP = 100 * UnitHealth("player") / UnitHealthMax("player")
    if PlayerHP < 35
    and GetItemCount(5512,false,false) > 0 
    and ( select(2, GetItemCooldown(5512)) == 0 ) then
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------
-- Register Library --------------------------------------------------------------------------------------------------------- 
-----------------------------------------------------------------------------------------------------------------------------
ProbablyEngine.library.register("ts", ts)