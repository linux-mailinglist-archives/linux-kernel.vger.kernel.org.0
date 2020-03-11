Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B83E181029
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 06:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgCKFko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 01:40:44 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:50315 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbgCKFko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:40:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583905242; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=CuTTPYKq85t63Axk9HyMoqq5/OUIc6WxQrsQ/SayQzs=; b=ZIPMzqQ0kpq/Lfn1cQxRccoPn24TZX119WpGvymj2jf00UczzwVCwf/B01+5KBDg5nnEO9Wq
 3XlRrBE1AYpotQhpQUDMwSex5XDQ2Qfvwk4PMwEon8sTSK9cRGBOgFSUIkK4ieSTSoIDEKmy
 Kc5xkwFU4SXBStFts8xrMnMYd18=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6879da.7f94b5a1d6c0-smtp-out-n03;
 Wed, 11 Mar 2020 05:40:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 24A75C43636; Wed, 11 Mar 2020 05:40:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.206.13.37] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2B86C433D2;
        Wed, 11 Mar 2020 05:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2B86C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH v10 2/3] soc: qcom: rpmh: Update dirty flag only when data
 changes
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
References: <1583238415-18686-1-git-send-email-mkshah@codeaurora.org>
 <1583238415-18686-3-git-send-email-mkshah@codeaurora.org>
 <CAD=FV=VOARbQzY_p-SyDFu0mzFROp8nV9E=sraNrykWiySwEpw@mail.gmail.com>
 <8e307595-7758-6eb5-ab2d-73ab1ac1029c@codeaurora.org>
 <CAD=FV=VzNnRdDN5uPYskJ6kQHq2bAi2ysEqt0=taagdd_qZb-g@mail.gmail.com>
 <26b17bf5-7aa0-5853-a1b5-b6f6496aea13@codeaurora.org>
 <CAD=FV=UmhdXV20Kf2TtsADs3gi7i14pH6ATmoNexkCDBMH_bhA@mail.gmail.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <eafbd990-6f5b-aa35-b176-6c3b2959916d@codeaurora.org>
Date:   Wed, 11 Mar 2020 11:10:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UmhdXV20Kf2TtsADs3gi7i14pH6ATmoNexkCDBMH_bhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/10/2020 9:16 PM, Doug Anderson wrote:
> Hi,
>
>
> On Tue, Mar 10, 2020 at 4:03 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>>
>> On 3/6/2020 3:52 AM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Thu, Mar 5, 2020 at 3:10 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>>>>> To summarize:
>>>>>
>>>>> a) If the only allowable use of "WAKE_ONLY" is to undo "SLEEP_ONLY"
>>>>> then we should re-think the API and stop letting callers to
>>>>> rpmh_write(), rpmh_write_async(), or rpmh_write_batch() ever specify
>>>>> "WAKE_ONLY".  The code should just assume that "wake_only =
>>>>> active_only if (active_only != sleep_only)".  In other words, RPMH
>>>>> should programmatically figure out the "wake" state based on the
>>>>> sleep/active state and not force callers to do this.
>>>>>
>>>>> b) If "WAKE_ONLY" is allowed to do other things (or if it's not RPMH's
>>>>> job to enforce/assume this) then we should fully skip calling
>>>>> cache_rpm_request() for RPMH_ACTIVE_ONLY_STATE.
>>>>>
>>>>>
>>>>> NOTE: this discussion also makes me wonder about the is_req_valid()
>>>>> function.  That will skip sending a sleep/wake entry if the sleep and
>>>>> wake entries are equal to each other.  ...but if sleep and wake are
>>>>> both different than "active" it'll be a problem.
>>>> Hi Doug,
>>>>
>>>> To answer above points, yes in general it’s the understanding that wake is
>>>> almost always need to be equal to active. However, there can be valid reasons
>>>> for which the callers are enforced to call them differently in the first place.
>>>>
>>>> At present caller send 3 types of request.
>>>> rpmh_write(RPMH_ACTIVE_ONLY_STATE, addr=0x10, data=0x99);
>>>> rpmh_write(RPMH_SLEEP_STATE, addr=0x10, data=0x0);
>>>> rpmh_write(RPMH_WAKE_ONLY_STATE, addr=0x10, data=0x99);
>>>>
>>>> Now, Lets assume we handle this in rpmh driver since wake=active and the caller
>>>> send only 2 type of request (lets call it active and sleep, since we have assumption
>>>> of wake=active, and we don’t want 3rd request as its handled in rpmh driver)
>>>> So callers will now invoke 2 types of request.
>>>>
>>>> rpmh_write(RPMH_ACTIVE_ONLY_STATE, addr=0x10, data=0x99);
>>>> rpmh_write(RPMH_SLEEP_STATE, addr=0x10, data=0x0);
>>>>
>>>> with first type request, it now needs to serve 2 purpose
>>>> (a)    cache ACTIVE request votes as WAKE votes
>>>> (b)    trigger it out immediately (in ACTIVE TCS) as it need to be also complete immediately.
>>>>
>>>> For SLEEP, nothing changes. Now when entering to sleep we do rpmh_flush() to program all
>>>> WAKE and SLEEP request…so far so good…
>>>>
>>>> Now consider a corner case,
>>>>
>>>> There is something called a solver mode in RSC where HW could be in autonomous mode executing
>>>> low power modes. For this it may want to “only” program WAKE and SLEEP votes and then controller
>>>> would be in solver mode entering and exiting sleep autonomously.
>>>>
>>>> There is no ACTIVE set request and hence no requirement to send it right away as ACTIVE vote.
>>>>
>>>> If we have only 2 type of request, caller again need to differentiate to tell rpmh driver that
>>>> when it invoke
>>>>
>>>> rpmh_write(RPMH_ACTIVE_ONLY_STATE, addr=0x10, data=0x99);
>>>>
>>>> with this caching it as WAKE is fine  ((a) in above) but do not trigger it ((b) in above)
>>>>
>>>> so we need to again modify this API and pass another argument saying whether to do (a + b) or only (a).
>>>> but caller can already differentiate by using RPMH_ACTIVE_ONLY_STATE or RPMH_WAKE_ONLY_STATE.
>>>>
>>>> i think at least for now, leave it as it is, unless we really see any impact by caller invoking all
>>>> 3 types of request and take in account all such corner cases before i make any such change.
>>>> we can take it separate if needed along with optimization pointed in v9 series discussions.
>>> I totally don't understand what solver mode is for and when it's used,
>>> but I'm willing to set that aside for now I guess.  From looking at
>>> what you did for v12 it looks like the way you're expecting things to
>>> function is this:
>>>
>>> * ACTIVE: set wake state and trigger active change right away.
>>>
>>> * SLEEP: set only sleep state
>>>
>>> * WAKE: set only wake state, will take effect after next sleep/wake
>>> unless changed again before that happens.
>>>
>>>
>>> ...I'll look at the code with this understanding, now.  Presumably also:
>>>
>>> * We should document this.
>> Okay, i will document above.
>>> * If we see clients that are explicitly setting _both_ active and wake
>>> to the same thing then we can change the clients.  That means the only
>>> people using "WAKE" mode would be those clients that explicitly want
>>> the deferred action (presumably those using "solver" mode).
>>>
>>> Do those seem correct?
>> Correct. but i suggest to change clients only once solver mode changes go in.
>> until then leave clients to call ACTIVE and WAKE request separately (even with same data)
> If you want to leave clients to call ACTIVE and WAKE requests
> separately for now, then please change your patch ("soc: qcom: rpmh:
> Update dirty flag only when data changes"), which (from v13) has this
> in cache_rpm_request():
>
> switch (state) {
>   case RPMH_ACTIVE_ONLY_STATE:
>   case RPMH_WAKE_ONLY_STATE:
>     req->wake_val = cmd->data;
>
> ...that bit of code is what led me to request that you document that
> setting the active-only state also sets the wake-only state, so either
> change that code or add the documentation.

yes, i will add the documentation.

>
>
>>> If that's correct, I guess one subtle corner-case bug in
>>> is_req_valid().  Specifically if it's ever valid to do this:
>>>
>>> rpmh_write(RPMH_ACTIVE_ONLY_STATE, addr=0x10, data=0x99);
>>> rpmh_write(RPMH_SLEEP_STATE, addr=0x10, data=0x0);
>>> rpmh_write(RPMH_WAKE_ONLY_STATE, addr=0x10, data=0x0);
>> This scenario will never hit in solver mode.
>> when in solver, only WAKE and SLEEP requests are allowed to go through.
> OK, I guess this stems from me not understanding solver mode.  I guess
> for now it's unlikely to cause problems given the current usage, so we
> can ignore for now.
>
>
>>> ...then it won't work.
>> will work out just fine, as said above.
>>> You'll transition between sleep/wake and stay
>>> with "data=0x99".  Since "sleep == wake" then is_req_valid() will
>>> return "false" and we won't bother programming the commands for
>>> sleep/wake.  One simple way to solve this is remove the
>>> "req->sleep_val != req->wake_val" optimization in is_req_valid().
>> This will still need to keep check.
>>
>> the clients may invoke with below example data...
>>
>> rpmh_write(RPMH_ACTIVE_ONLY_STATE, addr=0x10, data=0x99);
>> rpmh_write(RPMH_SLEEP_STATE, addr=0x10, data=0x99);
>> rpmh_write(RPMH_WAKE_ONLY_STATE, addr=0x10, data=0x99); (we assume wake=active)
>>
>> while ACTIVE is immediatly sent, and resource already came to 0x99 level.
>>
>> Now while flushing, there is no point in programming in SLEEP TCS as such when cmd triggers
>> from SLEEP TCS then it won't make any real level transition since its already brought up to
>> 0x99 level with previous ACTIVE cmd. same reason goes for not programming it in WAKE TCS.
> "Need" is perhaps too strong of a word if I understand things.  The
> example above would still work even if we didn't check "sleep == wake"
> it would just program an extra (but pointless) command.  Right?
>
> ...but I guess we can debate about it later.  For now I'm not aware of
> anyone setting WAKE to something other than ACTIVE.
>
>
> -Doug
its not just programming an extra command, neither it is pointless. its needed to keep it that way.
let me make explain effect of this command...

the resource for which this extra command will be sent is already at required level.
so below might happen in my understanding.

Resource may be in its own low power mode, when this extra command is sent, it needs to
come out of low power mode and apply the newly requested level in sleep command but it is already
at that level, so without doing any real level transition, it will again go back to sleep.
same happens for wake command. so there can be a power hit.
so this extra command need not sent.

Thanks,
Maulik

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
