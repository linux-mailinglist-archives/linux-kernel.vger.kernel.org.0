Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA95EE6B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 04:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfJ1Di4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 23:38:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38630 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfJ1Diz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 23:38:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3so5911128pgt.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 20:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ji6WxCq+aHJBwM+x0esrqtTDOJDqjo2ORpOWnADNR4I=;
        b=bnTXkuH5ybsnQ2hYA9wVyBpJgD3nzhKEKX3/kqvksA4YfXyfa1Yao3wuKa+BYTVN2D
         IyNe9l8XO5Wu/h+Ey5fWmpNfyFjzONEqYsuqtPkx4WUgdCqPTkZCi5RFvS5GYh3U/ZOO
         5Pf+wqUk3aMMS2+UFPto4PK74NBmiD6e4j3WLqmbAvrtTPRh2BDXmPJO2hRE4Qao0nUH
         t6vYe1ldeUYs+/cJrgQSOuOaPHWxjGMKb0Dq/BTtYkMCVD5IF3NGX1dAR3zcszEoFDkg
         l6GU8MKV4aFdcWHd8/fyXqcrlw/SeM8UmpPtdzG82GEaZhua1F8rNXVXFyXByPa6N7l5
         Lfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ji6WxCq+aHJBwM+x0esrqtTDOJDqjo2ORpOWnADNR4I=;
        b=N2GsU0ePjg16DSNfGsWkf21MeTGMS6P8XBtpkrHB/tyGtI8Eppo6h/wusCffRRT1nq
         HzvHP50d5jgTRXU2rIBbdakG9pcRNxTrrnisGzHx8XmgKbUxOljTpRRpv3C+pnAXbQzu
         1RtC06fuXOXRD9S7981OABO3YWWZdRmLKurbGzqhS7uW8+dmFqMDQRD+ifrZDUlEpk9l
         le49N9d/XbG8AjWa24XKdrrLgtBE1OVLPT37O/jISs5AEu2KaPFgegYLKC4SW+zpnoUX
         ka40C5/h5h8d8kqi8JDaG0WP1k0eNoCLsautOH0rTuXlECl0516+guxRF1H+jL8jW/NM
         Uadg==
X-Gm-Message-State: APjAAAWq8HVa8o22rGHtbC7DBP+c5PrM+7xPYQDsboLeKKRVdre9qBfQ
        UB2uyKz/bLuAC7pmRFG8Z5sY8XD298tBWQ==
X-Google-Smtp-Source: APXvYqxMgelNPK8c849u4hq+aJ7j68v0Wo4pjrhJDJ32txEMgB7HPSEkAy3OLg5lM+Ulcd+oErqCrQ==
X-Received: by 2002:a62:6546:: with SMTP id z67mr18468263pfb.32.1572233934202;
        Sun, 27 Oct 2019 20:38:54 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id r13sm10268381pfg.3.2019.10.27.20.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 20:38:53 -0700 (PDT)
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1572189860.git.asml.silence@gmail.com>
 <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
 <5ec9bd14-d8f2-32e6-7f25-0ca7256c408a@gmail.com>
 <aac65fe2-6c51-3baf-eee7-af5a8f633bf2@kernel.dk>
 <d39a878f-9dac-1457-6bba-01afc6268a84@kernel.dk>
 <57db9960-0b31-9f40-c13b-1db6dcc88920@gmail.com>
 <02a25d12-1f44-de18-f233-b5421c608469@kernel.dk>
 <63f93f8a-4207-3ac4-a301-4907882009c9@gmail.com>
 <728dec9c-465c-2341-d7b5-929a50400e9c@kernel.dk>
 <3b8b84d0-cde2-6bb0-c903-a1d71f9b83e2@gmail.com>
 <3957148b-0dac-a621-8f12-5d2d45557e24@kernel.dk>
 <1e0ae1a6-6b8b-a78e-8ec0-fb7aa5972d00@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <02d42c75-1d48-35bd-abad-8230d2449c67@kernel.dk>
Date:   Sun, 27 Oct 2019 21:38:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1e0ae1a6-6b8b-a78e-8ec0-fb7aa5972d00@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/19 1:59 PM, Pavel Begunkov wrote:
> On 27/10/2019 22:51, Jens Axboe wrote:
>> On 10/27/19 1:17 PM, Pavel Begunkov wrote:
>>> On 27/10/2019 22:02, Jens Axboe wrote:
>>>> On 10/27/19 12:56 PM, Pavel Begunkov wrote:
>>>>> On 27/10/2019 20:26, Jens Axboe wrote:
>>>>>> On 10/27/19 11:19 AM, Pavel Begunkov wrote:
>>>>>>> On 27/10/2019 19:56, Jens Axboe wrote:
>>>>>>>> On 10/27/19 10:49 AM, Jens Axboe wrote:
>>>>>>>>> On 10/27/19 10:44 AM, Pavel Begunkov wrote:
>>>>>>>>>> On 27/10/2019 19:32, Jens Axboe wrote:
>>>>>>>>>>> On 10/27/19 9:35 AM, Pavel Begunkov wrote:
>>>>>>>>>>>> A small cleanup of very similar but diverged io_submit_sqes() and
>>>>>>>>>>>> io_ring_submit()
>>>>>>>>>>>>
>>>>>>>>>>>> Pavel Begunkov (2):
>>>>>>>>>>>>          io_uring: handle mm_fault outside of submission
>>>>>>>>>>>>          io_uring: merge io_submit_sqes and io_ring_submit
>>>>>>>>>>>>
>>>>>>>>>>>>         fs/io_uring.c | 116 ++++++++++++++------------------------------------
>>>>>>>>>>>>         1 file changed, 33 insertions(+), 83 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> I like the cleanups here, but one thing that seems off is the
>>>>>>>>>>> assumption that io_sq_thread() always needs to grab the mm. If
>>>>>>>>>>> the sqes processed are just READ/WRITE_FIXED, then it never needs
>>>>>>>>>>> to grab the mm.
>>>>>>>>>>> Yeah, we removed it to fix bugs. Personally, I think it would be
>>>>>>>>>> clearer to do lazy grabbing conditionally, rather than have two
>>>>>>>>>> functions. And in this case it's easier to do after merging.
>>>>>>>>>>
>>>>>>>>>> Do you prefer to return it back first?
>>>>>>>>>
>>>>>>>>> Ah I see, no I don't care about that.
>>>>>>>>
>>>>>>>> OK, looked at the post-patches state. It's still not correct. You are
>>>>>>>> grabbing the mm from io_sq_thread() unconditionally. We should not do
>>>>>>>> that, only if the sqes we need to submit need mm context.
>>>>>>>>
>>>>>>> That's what my question to the fix was about :)
>>>>>>> 1. Then, what the case it could fail?
>>>>>>> 2. Is it ok to hold it while polling? It could keep it for quite
>>>>>>> a long time if host is swift, e.g. submit->poll->submit->poll-> ...
>>>>>>>
>>>>>>> Anyway, I will add it back and resend the patchset.
>>>>>>
>>>>>> If possible in a simple way, I'd prefer if we do it as a prep patch and
>>>>>> then queue that up for 5.4 since we now lost that optimization.  Then
>>>>>> layer the other 2 on top of that, since I'll just rebase the 5.5 stuff
>>>>>> on top of that.
>>>>>>
>>>>>> If not trivially possible for 5.4, then we'll just have to leave with it
>>>>>> in that release. For that case, you can fold the change in with these
>>>>>> two patches.
>>>>>>
>>>>> Hmm, what's the semantics? I think we should fail only those who need
>>>>> mm, but can't get it. The alternative is to fail all subsequent after
>>>>> the first mm_fault.
>>>>
>>>> For the sqthread setup, there's no notion of "do this many". It just
>>>> grabs whatever it can and issues it. This means that the mm assign
>>>> is really per-sqe. What we did before, with the batching, just optimized
>>>> it so we'd only grab it for one batch IFF at least one sqe in that batch
>>>> needed the mm.
>>>>
>>>> Since you've killed the batching, I think the logic should be something
>>>> ala:
>>>>
>>>> if (io_sqe_needs_user(sqe) && !cur_mm)) {
>>>> 	if (already_attempted_mmget_and_failed_ {
>>>> 		-EFAULT end sqe
>>>> 	} else {
>>>> 		do mm_get and mmuse dance
>>>> 	}
>>>> }
>>>>
>>>> Hence if the sqe doesn't need the mm, doesn't matter if we previously
>>>> failed. If we need the mm and previously failed, -EFAULT.
>>>>
>>> That makes sense, but a bit hard to implement honoring links and drains
>>
>> If it becomes too complicated or convoluted, just drop it. It's not
>> worth spending that much time on.
>>
> I've already done it more or less elegantly, just prefer to test commits
> before sending.

That's always appreciated!

It struck me that while I've added quite a few regression tests, we don't
have any that just do basic read/write using the variety of settings we
have for that. So I added that to liburing.

-- 
Jens Axboe

