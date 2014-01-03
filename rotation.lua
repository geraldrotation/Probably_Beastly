-- ProbablyEngine Rotation Packager
-- Custom Beast Mastery Hunter Rotation
-- Created on Dec 31st 2013 4:57 am
ProbablyEngine.rotation.register_custom(253, "Beastly", {
  --Pause @ player Feign Death
    --FD
    { "pause", "player.buff(5384)" },
    --Pause on target has CC
    { "pause", "@ts.cc" },

  --Queue
    --Concussive
    { "!5116", "@ts.checkQueue(5116)" },
    --Widow Venom
    { "!82654", "@ts.checkQueue(82654)" },
    --Tranq
    { "!19801", "@ts.checkQueue(19801)" },
    --A Murder of Crows
    { "!131894", "@ts.checkQueue(131894)" },
    --Lynx Rush
    { "!120697", "@ts.checkQueue(120697)" },
    --Intimidation
    { "!19577", "@ts.checkQueue(19577)" },
    
  --Binding Shot
    { "109248", "modifier.ralt", "ground" },
  --Wyvern Sting
    { "19386", "modifier.lalt", "mouseover" },
    
  --Buffs
    --Aspect of the Hawk
    {{
        { "13165", "!player.buff(13165)" },

    --Aspect of the Iron Hawk
        { "109260", "!player.buff(109260)" },
    }, "toggle.aspect" },


  --Revive Pets
    --Heart of the Phoenix
    { "55709", { "!pet.exists", "!pet.alive" }},
    
    --Revive Pet
    { "982", "!pet.alive" },
    
  --Call Pet
    --Pet 1
    { "883", { "!pet.exists", "pet.alive" }},


  --Self Healing & Survival
    --Exhilaration
    { "109304", "player.health <= 45" },
    
    --Healthstone
    { "/run UseItemByName(5512)", "@ts.Healthstone" },
    
    --Mend Pet
    { "136", { "pet.exists", "pet.health <= 45", "!pet.buff(136)" }},
    
    
  --Misdirection
    --MD @ focus
    { "34477", { "!player.buff(34477)", "target.threat >= 50", "focus.exists" }, "focus" },
    
    --MD @ Pet
    { "34477", { "!player.buff(34477)", "target.threat >= 50", "!focus.exists", "pet.exists" }, "pet" },
    
    
  --Racials
    -- Dwarves
        { "Stoneform", "player.health <= 65" },
        
    -- Draenei
        { "Gift of the Naaru", "player.health <= 70", "player" },
        { "Gift of the Naaru", "focus.health <= 70", "focus" },
        { "Gift of the Naaru", "tank.health <= 60", "tank" },
        
    -- Night Elves
        { "Shadowmeld", "target.threat >= 80" },
        { "Shadowmeld", "focus.threat >= 80"},
        
    -- Worgen
        { "Darkflight", "modifier.cooldowns", "player.moving" },
        
    -- Orcs
        { "Blood Fury" },
        
    -- Trolls
        { "Berserking", "player.buff(Time Warp)" },
        { "Berserking", "player.buff(Bloodlust)" },
        { "Berserking", "player.debuff(Exhaustion)" },
        
    -- Goblins
        { "Rocket Barrage", "player.moving" },
        
        
  --Break CC
    -- Humans (Sexist fuckers)
        { "Every Man for Himself", "player.state.charm" },
        { "Every Man for Himself", "player.state.disorient" },
        { "Every Man for Himself", "player.state.fear" },
        { "Every Man for Himself", "player.state.incapacitate" },
        { "Every Man for Himself", "player.state.misc" },
        { "Every Man for Himself", "player.state.root" },
        { "Every Man for Himself", "player.state.sleep" },
        { "Every Man for Himself", "player.state.snare" },
        { "Every Man for Himself", "player.state.stun" },
        
    -- Gnomes
        { "Escape Artist", "player.state.root" },
        { "Escape Artist", "player.state.snare" },
        
    -- Forsaken (Undead, you uninformed bastards)
        { "Will of the Forsaken", "player.state.fear" },
        { "Will of the Forsaken", "player.state.charm" },
        { "Will of the Forsaken", "player.state.sleep" },
        
    --Masters Call
        { "53271", "player.state.snare", "player" },
        { "53271", "player.state.root", "player" },
    
    
  --Interrupts
    {{
    --Counter Shot
        { "147362", "target.interruptAt(50)" },
    --Tauren
        { "War Stomp", { "target.range <= 10", "target.casting", "!player.moving", "target.interruptsAt(50)" }},
    -- Blood Elves, Fuck everything about this racial.
        { "Arcane Torrent", { "target.casting", "target.range <= 10", "target.interruptsAt(50)" }},
    -- Pandaren
        { "Quaking Palm", { "target.casting", "target.interruptsAt(50)" }},
    }, "modifier.interrupts" },


  --Cooldowns
    {{
    --Stampede
        { "121818" },
    --A Murder of Crows
        { "131894" },
    --Lynx rush
        { "120697" },
    --Rapid Fire
        { "3045" },
    --Globes
        { "#gloves" },
    }, "modifier.cooldowns" },

  --Aoe
    {{
    --5+ Targets
        {{
        --Bestial Wrath
            { "19574", { "@coreHunter.petInRange", "pet.exists", "player.spell(34026).cooldown <= 2" }},
        --Rabid Doesnt work
            { "/run CastSpellByID(53401)", { "@coreHunter.petInRange", "@ts.rabid" }},
        --Fervor
            { "82726", { "player.focus < 50", "pet.focus < 50" }},
        --Multishot
            { "2643" },
        --Kill Shot
            { "53351", "target.health <= 20" },
        --Glaive toss
            { "117050" },
        --Barrage
            { "120360" },
        --Dire Beast
            { "120679" },
        --Cobra Shot
            { "77767" },
        }, "modifier.enemies >= 5" }, 
    
    --3/4 Targets
        {{
        --Bestial Wrath
            { "19574", { "@coreHunter.petInRange", "pet.exists", "player.spell(34026).cooldown <= 2" }},
        --Rabid Doesnt work
            { "/run CastSpellByID(53401)", { "@coreHunter.petInRange", "@ts.rabid" }},
        --Fervor
            { "82726", { "player.focus < 50", "pet.focus < 50" }},
        --Multishot
            { "2643", { "!pet.buff(Beast Cleave)", "player.focus >= 75", "player.spell(34026).cooldown <= 2" }},
        --Kill Command
            { "34026", { "@coreHunter.petInRange", "pet.exists" }},
        --Kill Shot
            { "53351", "target.health <= 20" },
        --Multishot
            { "2643", { "player.focus >= 40", "player.spell(34026).cooldown >= 4" }},
        --Rapid Fire T16 2piece
            { "3045", { "player.spell(3045).cooldown = 0", "@ts.t16" }},
        --Serpent Sting
            { "1978", "!target.debuff(118253)" },
        --Glaive toss
            { "117050" },
        --Dire Beast
            { "120679" },
        --Focus Fire
            { "82692", "@ts.focusfire" },
        --Cobra Shot refresh Serpent Sting
            { "77767", "target.debuff(118253).duration <= 3" },
        --Arcane Shot
            { "3044", { "player.focus >= 50", "player.spell(34026).cooldown >= 3", "pet.buff(115939" }},
        --Arcane Shot
            { "3044", { "player.focus >= 70", "pet.buff(115939)" }},
        --Cobra Shot
            { "77767", { "@ts.casttime(77767)", "@ts.cobra(77767)", "!player.spell(34026).cooldown <= 1" }},
        --Cobra Shot
            { "77767", { "player.focus < 35", "player.spell(34026).cooldown >= 2" }},
        }, { "modifier.enemies > 2", "modifier.enemies < 5" }},    
    
    --2 Targets
        {{
        --Bestial Wrath
            { "19574", { "@coreHunter.petInRange", "pet.exists", "player.spell(34026).cooldown <= 2" }},
        --Rabid Doesnt work
            { "/run CastSpellByID(53401)", { "@coreHunter.petInRange", "@ts.rabid" }},
        --Fervor
            { "82726", { "player.focus < 50", "pet.focus < 50" }},
        --Kill Command
            { "34026", { "@coreHunter.petInRange", "pet.exists" }},
        --Kill Shot
            { "53351", "target.health <= 20" },
        --Rapid Fire T16 2piece
            { "3045", { "player.spell(3045).cooldown = 0", "@ts.t16" }},
        --Serpent Sting
            { "1978", "!target.debuff(118253)" },
        --Multishot
            { "2643", { "!pet.buff(115939)", "player.focus >= 75", "!player.spell(34026).cooldown <= 2" }},
        --Multishot
            { "2643", { "!pet.buff(115939)", "player.focus >= 40", "player.spell(34026).cooldown >= 2" }},
        --Glaive toss
            { "117050" },
        --Dire Beast
            { "120679" },
        --Focus Fire
             { "82692", "@ts.focusfire" },
        --Cobra Shot refresh Serpent Sting
            { "77767", "target.debuff(118253).duration <= 3" },
        --Arcane Shot
            { "3044", { "player.focus >= 50", "player.spell(34026).cooldown >= 3" }},
        --Arcane Shot
            { "3044", "player.focus >= 70" },
        --Cobra Shot
            { "77767", { "@ts.casttime(77767)", "@ts.cobra(77767)", "!player.spell(34026).cooldown <= 1" }},
        --Cobra Shot
            { "77767", { "player.focus < 35", "player.spell(34026).cooldown >= 2" }},
        }, "modifier.enemies = 2" },
    }, "modifier.multitarget" },

  --Single Target
    --Bestial Wrath
    { "19574", { "@coreHunter.petInRange", "pet.exists", "player.spell(34026).cooldown <= 2" }},
    --Rabid Doesnt work
    { "/run CastSpellByID(53401)", { "@coreHunter.petInRange", "@ts.rabid" }},
    --Fervor
    { "82726", { "player.focus < 50", "pet.focus < 50" }},
    --Kill Command
    { "34026", { "@coreHunter.petInRange", "pet.exists" }},
    --Kill Shot
    { "53351", "target.health <= 20" },
    --Rapid Fire T16 2piece
    { "3045", { "player.spell(3045).cooldown = 0", "@ts.t16" }},
    --Serpent Sting
    { "1978", { "!target.debuff(118253)", "target.ttd >= 14" }},
    --Glaive Toss
    { "117050", { "player.focus >= 55", "@ts.clip" }},
    --Glaive Toss
    { "117050", { "player.focus >= 40", "player.spell(34026).cooldown >= 2" }},
    --Glaive Toss
    { "117050", { "player.focus <= 40", "@ts.clip", "player.spell(34026).cooldown > 3" }},
    --Dire Beast
    { "120679" },
    --Focus Fire
    { "82692", "@ts.focusfire" },
    --Cobra Shot refresh Serpent Sting
    { "77767", "target.debuff(118253).duration <= 3" },
    --Arcane Shot
    { "3044", { "player.focus >= 50", "player.spell(34026).cooldown >= 3" }},
    --Arcane Shot
    { "3044", { "player.focus >= 70", "@ts.clip" }},
    --Cobra Shot
    { "77767", { "@ts.casttime(77767)", "@ts.cobra(77767)", "!player.spell(34026).cooldown <= 1" }},
    --Cobra Shot
    { "77767", { "player.focus < 35", "player.spell(34026).cooldown >= 2" }},
    
    

},{
  --Buffs
    --Aspect of the Cheetah
    { "5118", { "player.moving", "!player.buff(5118)", "!player.combat", "toggle.aspect" }},
        
  --Call Pet
    --Pet 1
    { "883", { "!pet.exists", "pet.alive" }},

    --Mend Pet
    { "136", { "pet.health <= 45", "!pet.buff(136)" }},
        
  --Binding Shot
    { "109248", "modifier.ralt", "ground" },
    
  --Wyvern Sting
    { "19386", "modifier.lalt", "mouseover" },
},

function()
ProbablyEngine.toggle.create(
    'aspect',
    'Interface\\Icons\\spell_hunter_aspectoftheironhawk',
    'Auto Aspect',
	'Enable/Disable auto aspect.')

end)