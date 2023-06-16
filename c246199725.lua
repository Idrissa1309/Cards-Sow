--Code Change
function c246199725.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c246199725.condition)
	e1:SetTarget(c246199725.target)
	e1:SetOperation(c246199725.operation)
	c:RegisterEffect(e1)
end
function c246199725.condition(e,tp,eg,ep,ev,re,r,rp)
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_ANNOUNCE)
	return ex and cv==ANNOUNCE_RACE
end
function c246199725.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_ONFIELD,0,1,1,nil)
	local val=0xffffff
	local reg=g:GetFirst():GetFlagEffectLabel(246199725)
	if reg then val=val-reg end
	Duel.Hint(HINT_SELECTMSG,tp,563)
	local att=Duel.AnnounceRace(tp,1,val)
	e:SetLabel(att)
end
function c246199725.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local att=e:GetLabel()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetLabel(att)
		e1:SetOperation(c246199725.desop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1,true)
		local reg=tc:GetFlagEffectLabel(246199725)
		if reg then
			reg=bit.bor(reg,att)
			tc:SetFlagEffectLabel(246199725,reg)
		else
			tc:RegisterFlagEffect(246199725,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,att)
		end
	end
end
function c246199725.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeTargetParam(tc,e:GetLabel())
end