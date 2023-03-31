
local DressUpItemLink_orig = DressUpItemLink;

function DressUpItemLink(link)
	if ( not link ) then
		return;
	end

	if ( AuctionFrame:IsShown() ) then
		local itemId = GetItemInfoFromHyperlink(link)
		if VANITY_ITEMS[itemId] then
			local preview = VANITY_ITEMS[itemId] and VANITY_ITEMS[itemId].creaturePreview
			if preview and preview > 0 then
				if not AuctionDressUpFrame:IsShown() then
					ShowUIPanel(AuctionDressUpFrame);
				end
				AuctionDressUpModel:SetDisplayInfo(preview)
				AuctionDressUpModel:ResetValues()
				AuctionDressUpModel.isCreature = true
				return
			end
		end

		if ( not AuctionDressUpFrame:IsShown() ) then
			ShowUIPanel(AuctionDressUpFrame);
			AuctionDressUpModel:SetUnit("player");
		end

		if AuctionDressUpModel.isCreature then
			AuctionDressUpModel:SetUnit("player")
			AuctionDressUpModel:ResetValues()
			AuctionDressUpModel.isCreture = false
		end

		AuctionDressUpModel:TryOn(link);
		AuctionDressUpModel:RefreshValues()
	else
		DressUpItemLink_orig(link);
	end
end

function SetAuctionDressUpBackground()
	local texture = DressUpTexturePath();
	AuctionDressUpBackgroundTop:SetTexture(texture..1);
	AuctionDressUpBackgroundBot:SetTexture(texture..3);
end

function AuctionDressUpFrame_OnShow()
	UIPanelWindows["AuctionFrame"].width = 1020;
	UpdateUIPanelPositions(AuctionFrame);
	PlaySound("igCharacterInfoOpen");
end

function AuctionDressUpFrame_OnHide()
	UIPanelWindows["AuctionFrame"].width = 840;
	UpdateUIPanelPositions();
	PlaySound("igCharacterInfoClose");
end
