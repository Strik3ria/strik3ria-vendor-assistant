local settings, panel = ...
local kSellGreyNRepair, localization = ...

local function ShowCurrentStatus()
    if useGuildFunds then
        currentStatus = localization.useTrue[localization.locale]
    else
        currentStatus = localization.useFalse[localization.locale]
    end
    DEFAULT_CHAT_FRAME:AddMessage(localization.status[localization.locale]..currentStatus, 255, 255, 255)
end

local function Usage()
    DEFAULT_CHAT_FRAME:AddMessage(localization.usage[localization.locale], 255, 255, 255)
end

local settingsPanel = CreateFrame("Frame")
settingsPanel.name = "Auto Sell Grey & Repair"
InterfaceOptions_AddCategory(settingsPanel)

local title = settingsPanel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
title:SetPoint("TOP")
title:SetText(settingsPanel.name)

local guildRepairCheckButton = CreateFrame("CheckButton", "guildRepairCheckButton_GlobalName", settingsPanel, "ChatConfigCheckButtonTemplate")
guildRepairCheckButton:SetPoint("TOPLEFT", 100, -65)
guildRepairCheckButton_GlobalNameText:SetText(localization.settings.text[localization.locale])
guildRepairCheckButton.tooltip = localization.settings.tooltip[localization.locale]

local function ToggleGuildRepairs()
    if useGuildFunds then
        useGuildFunds = false
        guildRepairCheckButton:SetChecked(useGuildFunds)
        DEFAULT_CHAT_FRAME:AddMessage(localization.disabled[localization.locale], 255, 255, 255)
    else
        useGuildFunds = true
        guildRepairCheckButton:SetChecked(useGuildFunds)
        DEFAULT_CHAT_FRAME:AddMessage(localization.enabled[localization.locale], 255, 255, 255)
    end
end

SLASH_ASGRE1 = "/asgre"
SlashCmdList["ASGRE"] = function(msg)
    if string.len(msg) > 0 then
        -- '/asgre guild' will enable or disable guild repairs depending on current
        -- state
        if msg == "guild" then
            ToggleGuildRepairs()
        -- '/asgre status' will show the current status of guild repairs
        elseif msg == "status" then
            ShowCurrentStatus()
        else
            -- No command was given, give them a hint
            Usage()
        end
    else
        Usage()
    end
end

guildRepairCheckButton:SetScript("OnClick", ToggleGuildRepairs)
panel.checkbutton = guildRepairCheckButton
