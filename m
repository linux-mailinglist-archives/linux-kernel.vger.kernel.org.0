Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3F83C25C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 06:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390936AbfFKEjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 00:39:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47104 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388735AbfFKEjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:39:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 818EB6077A; Tue, 11 Jun 2019 04:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560227952;
        bh=GxvWGt9BSFpOm0HBYOLwuO1UUTw67j40yC2FZPp7lcY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dob0nTtTztsKrzbG99s2RNDLafJK+yaBUpEXQ50HfnN1Smzg9myH8GKQJ2MZoaVQj
         G5hQwVyQ6pj1OUJIYTClnu/jnu1+MXJy5foM5B8pC2yesIggzo9qY84y4cXZ7tRIsa
         ONChedqqzDeYrgyxUVbFO/uyAAU4Trs/UqGlaTNo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.204.79.142] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3DE0460261;
        Tue, 11 Jun 2019 04:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560227951;
        bh=GxvWGt9BSFpOm0HBYOLwuO1UUTw67j40yC2FZPp7lcY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fC1I4+x5OBGfNCBsYpH8gEdI1mu+JvSeL2VIuUVgwIHFBfoBqyhXRLlk8Ynaruyiv
         DVZbPNoB5Po6eIKDJG9vrTPtDHHB2v3kvXeJz5kR44kDeTFJIQg0b1HiIkPfmageka
         zvesMBiGovazHRLrl/FJLMoQiHGOnNA9IEj0zBLg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DE0460261
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, hch@lst.de, mingo@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1559161526-618-1-git-send-email-cai@lca.pw>
 <20190530080358.GG2623@hirez.programming.kicks-ass.net>
 <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
 <20190603123705.GB3419@hirez.programming.kicks-ass.net>
 <ddf9ee34-cd97-a62b-6e91-6b4511586339@kernel.dk>
 <20190607133541.GJ3436@hirez.programming.kicks-ass.net>
 <20190607142332.GF3463@hirez.programming.kicks-ass.net>
 <16419960-3703-5988-e7ea-9d3a439f8b05@codeaurora.org>
 <20190610144641.GA8127@redhat.com>
From:   Gaurav Kohli <gkohli@codeaurora.org>
Message-ID: <154008a8-9d29-2411-28a0-0284a95b4481@codeaurora.org>
Date:   Tue, 11 Jun 2019 10:09:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610144641.GA8127@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +
>>
>> Hi Peter, Jen,
>>
>> As we are not taking pi_lock here , is there possibility of same task dead
>> call comes as this point of time for current thread, bcoz of which we have
>> seen earlier issue after this commit 0619317ff8ba
>> [T114538]  do_task_dead+0xf0/0xf8
>> [T114538]  do_exit+0xd5c/0x10fc
>> [T114538]  do_group_exit+0xf4/0x110
>> [T114538]  get_signal+0x280/0xdd8
>> [T114538]  do_notify_resume+0x720/0x968
>> [T114538]  work_pending+0x8/0x10
>>
>> Is there a chance of TASK_DEAD set at this point of time?
> 
> In this case try_to_wake_up(current, TASK_NORMAL) will do nothing, see the
> if (!(p->state & state)) above.
> 
> See also the comment about set_special_state() above. It disables irqs and
> this is enough to ensure that try_to_wake_up(current) from irq can't race
> with set_special_state(TASK_DEAD).

Thanks Oleg,

I missed that part(both thread and interrupt is in same core only), So 
that situation would never come.
> 
> Oleg.
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
