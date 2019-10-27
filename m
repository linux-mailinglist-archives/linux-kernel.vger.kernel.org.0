Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36F3E6483
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 18:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfJ0R0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 13:26:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45940 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbfJ0R0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 13:26:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so4869154pgj.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1KLOeVEvTtR0f1rHpquwg/Ww3yRnFlSLRfxSjo6tHKc=;
        b=zZDC7WHuhnnJieQIYq5/mjAnCZSTuwR5A0+dX/dvNFR+8cYXSBtIcKw8ZbYA31EZJj
         JFEkI63iJ56EdYw0y7+ZFujdN7kVtnSJJDxjEKjDiSQ0CGQ+xa6PPsC+ERO5bJ3pks1z
         LCi5tGzrvl8PTNLIBoyeKz/a9GrOYip0sa1yE7L8kgBtPS9+IrKw9wXYnITmiXpn4trs
         QRDRpPOo1ZErjlo+xmJabbyV5y15cFEK1CwcGqcpERBEYr/fvzRodT9Rh7JPa0QmFjlq
         z9IxImkN+7vG4lIRtOEs6Pahm//2aHqRsiJWnyLSXB7/qA6I62U3nT+Ohw2wlNJC5oy7
         IR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1KLOeVEvTtR0f1rHpquwg/Ww3yRnFlSLRfxSjo6tHKc=;
        b=QIIJtt9TFAgAeODx0WXaRNOFxZlBcPmJo01ijzMmoAqTzGGg2irguRQ/iPYoOTh1R3
         yN090vOtmDINLiB3Hf9VM6GnZSV9Hq/FBQ1rnjhn6EdJGsiVM/nL9fWAgjf2TpRB3lQG
         x+v0r4qiSNBkUvKJ6u5FVn341pQWdVAq+SZh1uMc6oggOsGeTAswt5cgL0dxLekcNi1I
         xGf7rszolODPEl/F00Kj8JzOiaWgUXxi+aybqJoCk+JGK/tn7jXdT6QUz2cM13or779D
         eiuuoSJaBnRuVx0bnu9fsmvvYttT7xsHKEMFCXPH222ro886XqWWFLReiPHzZdNABOyE
         9oNQ==
X-Gm-Message-State: APjAAAVt03aJOqgg620eNxs6qUhRzb2anYhTNgH43bgLcnqABOCUlwZD
        m2rJHx9QSkNzx2wWfB5LS/BCEzSSGoOyig==
X-Google-Smtp-Source: APXvYqyazN/rahQJmz+HOkzL1Qm7UmmxY6zb+8ew+g6iN3mr/KoijqEIJzbyeleIg/MW4u8VtlOWlg==
X-Received: by 2002:a63:aa4e:: with SMTP id x14mr3991928pgo.393.1572197172885;
        Sun, 27 Oct 2019 10:26:12 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id p2sm6167349pfn.140.2019.10.27.10.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 10:26:11 -0700 (PDT)
Subject: Re: [PATCH 0/2][for-next] cleanup submission path
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1572189860.git.asml.silence@gmail.com>
 <666ed447-ba8f-29e7-237f-de8044aa63ea@kernel.dk>
 <5ec9bd14-d8f2-32e6-7f25-0ca7256c408a@gmail.com>
 <aac65fe2-6c51-3baf-eee7-af5a8f633bf2@kernel.dk>
 <d39a878f-9dac-1457-6bba-01afc6268a84@kernel.dk>
 <57db9960-0b31-9f40-c13b-1db6dcc88920@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <02a25d12-1f44-de18-f233-b5421c608469@kernel.dk>
Date:   Sun, 27 Oct 2019 11:26:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <57db9960-0b31-9f40-c13b-1db6dcc88920@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/19 11:19 AM, Pavel Begunkov wrote:
> On 27/10/2019 19:56, Jens Axboe wrote:
>> On 10/27/19 10:49 AM, Jens Axboe wrote:
>>> On 10/27/19 10:44 AM, Pavel Begunkov wrote:
>>>> On 27/10/2019 19:32, Jens Axboe wrote:
>>>>> On 10/27/19 9:35 AM, Pavel Begunkov wrote:
>>>>>> A small cleanup of very similar but diverged io_submit_sqes() and
>>>>>> io_ring_submit()
>>>>>>
>>>>>> Pavel Begunkov (2):
>>>>>>       io_uring: handle mm_fault outside of submission
>>>>>>       io_uring: merge io_submit_sqes and io_ring_submit
>>>>>>
>>>>>>      fs/io_uring.c | 116 ++++++++++++++------------------------------------
>>>>>>      1 file changed, 33 insertions(+), 83 deletions(-)
>>>>>
>>>>> I like the cleanups here, but one thing that seems off is the
>>>>> assumption that io_sq_thread() always needs to grab the mm. If
>>>>> the sqes processed are just READ/WRITE_FIXED, then it never needs
>>>>> to grab the mm.
>>>>> Yeah, we removed it to fix bugs. Personally, I think it would be
>>>> clearer to do lazy grabbing conditionally, rather than have two
>>>> functions. And in this case it's easier to do after merging.
>>>>
>>>> Do you prefer to return it back first?
>>>
>>> Ah I see, no I don't care about that.
>>
>> OK, looked at the post-patches state. It's still not correct. You are
>> grabbing the mm from io_sq_thread() unconditionally. We should not do
>> that, only if the sqes we need to submit need mm context.
>>
> That's what my question to the fix was about :)
> 1. Then, what the case it could fail?
> 2. Is it ok to hold it while polling? It could keep it for quite
> a long time if host is swift, e.g. submit->poll->submit->poll-> ...
> 
> Anyway, I will add it back and resend the patchset.

If possible in a simple way, I'd prefer if we do it as a prep patch and
then queue that up for 5.4 since we now lost that optimization.  Then
layer the other 2 on top of that, since I'll just rebase the 5.5 stuff
on top of that.

If not trivially possible for 5.4, then we'll just have to leave with it
in that release. For that case, you can fold the change in with these
two patches.

-- 
Jens Axboe

