Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC327A8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 14:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbfG3Mk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 08:40:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbfG3Mk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:40:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E52A0606FC; Tue, 30 Jul 2019 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564490455;
        bh=ar7m8mpJ/FJLlvZHI7vTK/I6f2Y/8sxaACpIxTv1E2o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PDDR/kLc+zGR5ldRM8Yh1ZApA2KhOUQgScSwID2mTtyir3jjXUKgYXeLTW2yLPHtW
         oxj+5kFiCffTiNJxeqNL9vUcAh6WCexRikzUydITQb4ax084J+4T4NawiUVzlMAf3Y
         LYUT9kKgU/brm88ywER4owuGfKmLraeBWTjncndY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC496601D7;
        Tue, 30 Jul 2019 12:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564490455;
        bh=ar7m8mpJ/FJLlvZHI7vTK/I6f2Y/8sxaACpIxTv1E2o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PDDR/kLc+zGR5ldRM8Yh1ZApA2KhOUQgScSwID2mTtyir3jjXUKgYXeLTW2yLPHtW
         oxj+5kFiCffTiNJxeqNL9vUcAh6WCexRikzUydITQb4ax084J+4T4NawiUVzlMAf3Y
         LYUT9kKgU/brm88ywER4owuGfKmLraeBWTjncndY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC496601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 2/2] locking/mutex: Use mutex flags macro instead of hard
 code value
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org
References: <1564397578-28423-1-git-send-email-mojha@codeaurora.org>
 <1564397578-28423-2-git-send-email-mojha@codeaurora.org>
 <20190729110727.GB31398@hirez.programming.kicks-ass.net>
 <a80972a1-8e24-33cb-0088-49ef0e680540@codeaurora.org>
 <20190730080308.GF31381@hirez.programming.kicks-ass.net>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <6b0fd5fd-b3e2-585e-286d-de8ed3c21e66@codeaurora.org>
Date:   Tue, 30 Jul 2019 18:10:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730080308.GF31381@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/30/2019 1:33 PM, Peter Zijlstra wrote:
> On Tue, Jul 30, 2019 at 01:23:13PM +0530, Mukesh Ojha wrote:
>> On 7/29/2019 4:37 PM, Peter Zijlstra wrote:
>>> On Mon, Jul 29, 2019 at 04:22:58PM +0530, Mukesh Ojha wrote:
>>>> Let's use the mutex flag macro(which got moved from mutex.c
>>>> to linux/mutex.h in the last patch) instead of hard code
>>>> value which was used in __mutex_owner().
>>>>
>>>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
>>>> ---
>>>>    include/linux/mutex.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
>>>> index 79b28be..c3833ba 100644
>>>> --- a/include/linux/mutex.h
>>>> +++ b/include/linux/mutex.h
>>>> @@ -87,7 +87,7 @@ struct mutex {
>>>>     */
>>>>    static inline struct task_struct *__mutex_owner(struct mutex *lock)
>>>>    {
>>>> -	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~0x07);
>>>> +	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
>>>>    }
>>> I would _much_ rather move __mutex_owner() out of line, you're exposing
>>> far too much stuff.
>> if i understand you correctly, you want me to move __mutex_owner() to
>> mutex.c
>> __mutex_owner() is used in mutex_is_locked() and mutex_trylock_recursive
>> inside linux/mutex.h.
>>
>> Shall i move them as well ?
> Yes, then you can make __mutex_owner() static.

To make it static , i have to export mutex_is_locked() after moving it 
inside mutex.c, so that other module can use it.

Also are we thinking of removing
static inline /* __deprecated */ __must_check enum 
mutex_trylock_recursive_enum
mutex_trylock_recursive(struct mutex *lock)

inside linux/mutex.h in future ?

As i see it is used at one or two places and there is a check inside 
checkpatch guarding its further use .

Thanks,
Mukesh


>
> Thanks!
