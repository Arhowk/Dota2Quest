require('quest/qgen')
print("Hello World!")

local function QuickClass(a)
    a.mt = {}
    a.mt.__index =  function(table, key)
       return QuestGenerator.prototype[key]
    end

end
    

Quest = {}
Quest.prototype = {name = "",
				minLevel = 0,
				active = false,
				minLevel = 0,
				maxPartySize = 0,
				minPartySize = 0,
				stages = {},
				starters = {},
				activeStage = {},
				bounty = {}}
QuickClass(Quest)


QuestStage = {}
QuestStageRequirement = {}



function Quest.onUnitDeath(eventData)
	print("On Unit Death")
    for k,v in pairs(eventData) do
       print(k,v)
    end
end

    
function Quest.registerEvents()
	--local n = CDotaQuest:new()
	--n:SetTextReplaceString("HorzArrow(Vector a, Vector b, float c, int d, int")
	--ListenToGameEvent("entity_killed", Dynamic_Wrap(Quest, 'onUnitDeath'), nil)
end
Quest.registerEvents()