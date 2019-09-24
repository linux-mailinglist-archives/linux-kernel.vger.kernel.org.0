Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 370C0BC578
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 12:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440710AbfIXKLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 06:11:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36205 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438579AbfIXKLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:11:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so1062548pfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 03:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zFj+W21UBEqh8XHsvLd6EQrEC8J1XYOJHhKVopUNcRg=;
        b=ph0fHye07aJm1FGweBetkYVsbQUiB0tpJyiAO2rPMjnyVDrKN1V9JuylbOJJh+Uiq6
         ERZAssw97/WpZXs4cdaPKHzf9oVPvx3lZq9+zwjKc9fJXtHvMIGO8mSZevacuz3CEI2G
         HwDAGHD8AuJy+yE+YT1cct+oAg9qWOu/i6fEKHRlrf5MhZJk1tfKFd9IZyEgNwcKgRJU
         3F1cLIR46AKWefArQYOgqOPc5P0qBhH4PCWZaUYYcaueDp4Fc7HX7ICkYnbENrEcABH1
         z0isubH0xJDKGfjUGmhAz2d4Gcy+wBw+rYQwtEui9QEIvHcn30BzJP4QU/hr7uH5zv++
         380A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zFj+W21UBEqh8XHsvLd6EQrEC8J1XYOJHhKVopUNcRg=;
        b=crajQPqdq7ivuSh1QY+ajT+JCypgRPJUY1vmWTvCBG7H3ojaXqXf/PcYuGQhLwisMB
         rhVa/V2D6X1gaUsFc2eDItTEIYno43XZgb06YF4TPqCNDPoTP/Ii5KPPO65ufgWBfTjm
         sx9HyD7rxRfHOmMeSF0GTvU71hgOLOMuo1TIcuUagnPnicQKwDY4AjI36arIlq2qcsNR
         nBi8xH6Gp6XOWoldGq0wHziWd4mTao0ijf1z4iyl0H17ku9LMj0c3UDzgRZrQM1bLdfR
         e5/Qu54Mw5GrTU8ZutrzxQt2sHSAesgL87o/AGBT305ka/226UMMuVFEh+hCVRAho9vk
         xu1Q==
X-Gm-Message-State: APjAAAWluToPGgpzUAOdlK9nOki4XOG9Nj5nQph/efHICtfboq6h6oPW
        Hc6vgygJKaYZJBVpp4AhSz9G2g6wSDDi0zL/
X-Google-Smtp-Source: APXvYqx1RXW1RWcdH95KHMQFZU/aJNhyZZqCImx1y43LoC1hEiEikDXF2Coary3axGa9YA/Hsx+mcg==
X-Received: by 2002:a63:2a87:: with SMTP id q129mr2374326pgq.101.1569319911155;
        Tue, 24 Sep 2019 03:11:51 -0700 (PDT)
Received: from ?IPv6:2600:380:8419:743e:6023:99b1:fa9f:a39c? ([2600:380:8419:743e:6023:99b1:fa9f:a39c])
        by smtp.gmail.com with ESMTPSA id n29sm4277137pgm.4.2019.09.24.03.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 03:11:50 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
 <0fec66fb-4534-59f8-cd88-d8d2297779aa@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d931c8ff-1736-e4f8-8937-51cccfbd827f@kernel.dk>
Date:   Tue, 24 Sep 2019 12:11:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0fec66fb-4534-59f8-cd88-d8d2297779aa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/19 3:33 AM, Pavel Begunkov wrote:
> 
> 
> On 24/09/2019 11:36, Jens Axboe wrote:
>> On 9/24/19 2:27 AM, Jens Axboe wrote:
>>> On 9/24/19 2:02 AM, Jens Axboe wrote:
>>>> On 9/24/19 1:06 AM, Pavel Begunkov wrote:
>>>>> On 24/09/2019 02:00, Jens Axboe wrote:
>>>>>>> I think we can do the same thing, just wrapping the waitqueue in a
>>>>>>> structure with a count in it, on the stack. Got some flight time
>>>>>>> coming up later today, let me try and cook up a patch.
>>>>>>
>>>>>> Totally untested, and sent out 5 min before departure... But something
>>>>>> like this.
>>>>> Hmm, reminds me my first version. Basically that's the same thing but
>>>>> with macroses inlined. I wanted to make it reusable and self-contained,
>>>>> though.
>>>>>
>>>>> If you don't think it could be useful in other places, sure, we could do
>>>>> something like that. Is that so?
>>>>
>>>> I totally agree it could be useful in other places. Maybe formalized and
>>>> used with wake_up_nr() instead of adding a new primitive? Haven't looked
>>>> into that, I may be talking nonsense.
>>>>
>>>> In any case, I did get a chance to test it and it works for me. Here's
>>>> the "finished" version, slightly cleaned up and with a comment added
>>>> for good measure.
>>>
>>> Notes:
>>>
>>> This version gets the ordering right, you need exclusive waits to get
>>> fifo ordering on the waitqueue.
>>>
>>> Both versions (yours and mine) suffer from the problem of potentially
>>> waking too many. I don't think this is a real issue, as generally we
>>> don't do threaded access to the io_urings. But if you had the following
>>> tasks wait on the cqring:
>>>
>>> [min_events = 32], [min_events = 8], [min_events = 8]
>>>
>>> and we reach the io_cqring_events() == threshold, we'll wake all three.
>>> I don't see a good solution to this, so I suspect we just live with
>>> until proven an issue. Both versions are much better than what we have
>>> now.
>>
>> Forgot an issue around signal handling, version below adds the
>> right check for that too.
> 
> It seems to be a good reason to not keep reimplementing
> "prepare_to_wait*() + wait loop" every time, but keep it in sched :)

I think if we do the ->private cleanup that Peter mentioned, then
there's not much left in terms of consolidation. Not convinced the case
is interesting enough to warrant a special helper. If others show up,
it's easy enough to consolidate the use cases and unify them.

If you look at wake_up_nr(), I would have thought that would be more
widespread. But it really isn't.

>> Curious what your test case was for this?
> You mean a performance test case? It's briefly described in a comment
> for the second patch. That's just rewritten io_uring-bench, with
> 1. a thread generating 1 request per call in a loop
> 2. and the second thread waiting for ~128 events.
> Both are pinned to the same core.

Gotcha, thanks.

-- 
Jens Axboe

