Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9F9154DA1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 21:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgBFU64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 15:58:56 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42074 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgBFU6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:58:55 -0500
Received: by mail-io1-f65.google.com with SMTP id s6so7810535iol.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 12:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AdYB/qVsQCfjtK6YLT21IXUFdwDIjEDegRvK53B7PwA=;
        b=B/G+VDjDJpCN2ldsbpWbT42RDlAK1aKN/ANvJL9g9zPgjF8DL2GfhXzXLB8uc1UwiS
         eA2UEaT/9e5qEZXmrGe66LyBxqxfD5LafMnuCVJTeuQHanGIibi8Oy68+8tkrYhlBVV/
         ADl5wWfjdOEqS6VLF5go16dYq32duVQVNrjHoF9oyXxPBAoMTgaNDCfbYpPadozI0lpe
         33gOOkXws19I84A02ZRwcJ8eI/XUE8yBQg0z4KjUGqWCIItQKeOysELLKTQc+lJwpwNs
         NSqVv/uizyC/WXnUR+E+boLOwSM+GEE36sPTEXHN1FXyUZx97SJYTUTkIWopUKwFsKh3
         CuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AdYB/qVsQCfjtK6YLT21IXUFdwDIjEDegRvK53B7PwA=;
        b=bddUB/Tzrr9R/YXgbvKsFegsfrTeSTOBDC6aVetE49Hu3jRXjzNVPB9h8n/zov7qdC
         F1Wj80deR8TctCee8qF/wd4Nat5bS1+2xULy4UcTZPR1TKLp6DB1vPMGX2QHx2m3ByrT
         S/Uij+eSaLT5jKaOV3Lc1G5Yt1/ioU0vgdR2vYsPBOWabenfB5xShOIUIDTVvtsdS1fJ
         v2uBSqOMyGqwm9KRwnPF+2EHTOU5oq5AeH0pkR80+JgzhZrjIH/VPNvT3a1yHMTjekcs
         EOpv8uP/sQa93OsMoek2qJFsh5wtFgFz9dBxG1xokM054EWuUjJyw9Sz/iL4wsekR7Xu
         Pv4A==
X-Gm-Message-State: APjAAAVeo+gPtSkIhWPjqAKEn9pcxiG4lVJHWQh3sUejh7HKub1LTvpO
        JPW48JqGFgUQMtxV/zcnPzgQVlTo9d0=
X-Google-Smtp-Source: APXvYqx6GqYXoq9y83++pyl2zcO3nfQ0K9n4lzEkbOCZZnD5TUxbNMS+BXy0qLcL8dl5/3QGqS8RzQ==
X-Received: by 2002:a6b:5109:: with SMTP id f9mr126416iob.86.1581022733488;
        Thu, 06 Feb 2020 12:58:53 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e16sm210235iog.62.2020.02.06.12.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 12:58:52 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix deferred req iovec leak
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <e143e45a34dce9d271fc4a3b32f7620c5a7377c1.1581007844.git.asml.silence@gmail.com>
 <d8486857-ccd3-41bd-2ef7-5ac4781dbd5f@gmail.com>
 <f6a1d5aa-f84d-168e-4fdf-6fb895fc09df@gmail.com>
 <6e7207b6-95c4-4287-5872-fb05abf60e88@kernel.dk>
 <4f7f61d3-b3f9-43db-ad32-ee502dc06c8b@gmail.com>
 <28cacc0c-68e4-a9d1-bb5e-03dbeff8a586@kernel.dk>
 <37dc06c1-e7ee-a185-43a7-98883709f5b0@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2095dbc7-88fb-9d4f-78a5-8577dda09a92@kernel.dk>
Date:   Thu, 6 Feb 2020 13:58:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <37dc06c1-e7ee-a185-43a7-98883709f5b0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/20 1:39 PM, Pavel Begunkov wrote:
> On 06/02/2020 23:16, Jens Axboe wrote:
>> On 2/6/20 1:00 PM, Pavel Begunkov wrote:
>>> On 06/02/2020 22:56, Jens Axboe wrote:
>>>> On 2/6/20 10:16 AM, Pavel Begunkov wrote:
>>>>> On 06/02/2020 20:04, Pavel Begunkov wrote:
>>>>>> On 06/02/2020 19:51, Pavel Begunkov wrote:
>>>>>>> After defer, a request will be prepared, that includes allocating iovec
>>>>>>> if needed, and then submitted through io_wq_submit_work() but not custom
>>>>>>> handler (e.g. io_rw_async()/io_sendrecv_async()). However, it'll leak
>>>>>>> iovec, as it's in io-wq and the code goes as follows:
>>>>>>>
>>>>>>> io_read() {
>>>>>>> 	if (!io_wq_current_is_worker())
>>>>>>> 		kfree(iovec);
>>>>>>> }
>>>>>>>
>>>>>>> Put all deallocation logic in io_{read,write,send,recv}(), which will
>>>>>>> leave the memory, if going async with -EAGAIN.
>>>>>>>
>>>>>> Interestingly, this will fail badly if it returns -EAGAIN from io-wq context.
>>>>>> Apparently, I need to do v2.
>>>>>>
>>>>> Or not...
>>>>> Jens, can you please explain what's with the -EAGAIN handling in
>>>>> io_wq_submit_work()? Checking the code, it seems neither of
>>>>> read/write/recv/send can return -EAGAIN from async context (i.e.
>>>>> force_nonblock=false). Are there other ops that can do it?
>>>>
>>>> Nobody should return -EAGAIN with force_nonblock=false, they should
>>>> end the io_kiocb inline for that.
>>>>
>>>
>>> If so for those 4, then the patch should work well.
>>
>> Maybe I'm dense, but I'm not seeing the leak? We have two cases here:
>>
> 
> There is an example:
> 
> 1. submit a read, which need defer.
> 
> 2. io_req_defer() allocates ->io and goes io_req_defer_prep() -> io_read_prep().
> Let #vecs > UIO_FASTIOV, so the prep() in the presence of ->io will allocate iovec.
> Note: that work.func is left io_wq_submit_work
> 
> 3. At some point @io_wq calls io_wq_submit_work() -> io_issue_sqe() -> io_read(),
> 
> 4. actual reading succeeds, and it's coming to finalisation and the following
> code in particular.
> 
> if (!io_wq_current_is_worker())
> 	kfree(iovec);
> 
> 5. Because we're in io_wq, the cleanup will not be performed, even though we're
> returning with success. And that's a leak.
> 
> Do you see anything wrong with it?

That's my bad, I didn't read the subject fully, this is specific to
a deferred request. Patch looks good to me, and it cleans it up too
which is always a nice win!

-- 
Jens Axboe

