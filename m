Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03622FC884
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 15:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfKNOMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 09:12:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36130 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfKNOMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:12:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id x22so1037315lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 06:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EmOEKPkWsDxJa2wDMuLQCZmoxOFNjV+aIVNikHtlQFg=;
        b=OZAvCUkinGNJMi0yfM5j380tLkdf3Nvf9dXfwD53dRIWfqgy9w1GQ5ZtYSasJ7qEZq
         HTE+5qbBejQYkgBWdCQhKLgoL+7O2wunQlgX+mJaWL7AN8ebe+2tv2ORKqj4ibYB3Hmg
         Qrnc1CNXFv/7qAPW/KW95kqh2eZ/cUaSZZUzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EmOEKPkWsDxJa2wDMuLQCZmoxOFNjV+aIVNikHtlQFg=;
        b=ZpwlP5OgP93pTefiDExBhjZElRz3gUg+Yf9mn2MnWncsw7s34uE/XpxqT1qy1CsLR2
         9Eebv1p8iILbu7sK4VtUDyDr9PfTXhulIC/0NOi959dJAT+qPvQdMjNUQTzo+GoAPiqc
         ZVF/mUAHKxu8szMYAH7ZX52SE1KZaxbMFMPmerScIxKEnw0bRmMboX58e6YRuMwF3pNU
         heAT7OTnWreIHeao2nBFhuj6mwwNmJfJ0eygtJ5aG7KdDU6a2UjOcMvgvcxkvcYEpVGy
         +VtRmAPzqFfmaRfUfpy3Ab/MIk5PP+sAjML2jX/Dmek+wpYLKeyQXcv6tl512nDDsvC2
         SVQg==
X-Gm-Message-State: APjAAAUxF8QHJ9ifA9YtSZzUpNPfK9JCdNRhNdxSxrMidrWM/JJ+jBOD
        TbmBLF0LhqqpgrJB34NLSoqV5A==
X-Google-Smtp-Source: APXvYqwxuf2Qn4SVRaNeTz1TqaUUZWOYLdFBOkRFoPorfnqZB0bn32yxhdQM6hE0Q3CW2gfKsMGZUQ==
X-Received: by 2002:ac2:4c2b:: with SMTP id u11mr6961692lfq.171.1573740755398;
        Thu, 14 Nov 2019 06:12:35 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g21sm2437151ljh.2.2019.11.14.06.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 06:12:34 -0800 (PST)
Subject: Re: [PATCH RFC] io_uring: make signalfd work with io_uring (and aio)
 POLL
To:     Jann Horn <jannh@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <58059c9c-adf9-1683-99f5-7e45280aea87@kernel.dk>
 <58246851-fa45-a72d-2c42-7e56461ec04e@kernel.dk>
 <ec3526fb-948a-70c0-4a7b-866d6cd6a788@rasmusvillemoes.dk>
 <CAG48ez3dpphoQGy8G1-QgZpkMBA2oDjNcttQKJtw5pD62QYwhw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ea7a428d-a5bd-b48e-9680-82a26710ec83@rasmusvillemoes.dk>
Date:   Thu, 14 Nov 2019 15:12:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3dpphoQGy8G1-QgZpkMBA2oDjNcttQKJtw5pD62QYwhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2019 14.46, Jann Horn wrote:
> On Thu, Nov 14, 2019 at 10:20 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>> On 14/11/2019 05.49, Jens Axboe wrote:
>>> On 11/13/19 9:31 PM, Jens Axboe wrote:
>>>> This is a case of "I don't really know what I'm doing, but this works
>>>> for me". Caveat emptor, but I'd love some input on this.
>>>>
>>>> I got a bug report that using the poll command with signalfd doesn't
>>>> work for io_uring. The reporter also noted that it doesn't work with the
>>>> aio poll implementation either. So I took a look at it.
>>>>
>>>> What happens is that the original task issues the poll request, we call
>>>> ->poll() (which ends up with signalfd for this fd), and find that
>>>> nothing is pending. Then we wait, and the poll is passed to async
>>>> context. When the requested signal comes in, that worker is woken up,
>>>> and proceeds to call ->poll() again, and signalfd unsurprisingly finds
>>>> no signals pending, since it's the async worker calling it.
>>>>
>>>> That's obviously no good. The below allows you to pass in the task in
>>>> the poll_table, and it does the right thing for me, signal is delivered
>>>> and the correct mask is checked in signalfd_poll().
>>>>
>>>> Similar patch for aio would be trivial, of course.
>>>
>>> From the probably-less-nasty category, Jann Horn helpfully pointed out
>>> that it'd be easier if signalfd just looked at the task that originally
>>> created the fd instead. That looks like the below, and works equally
>>> well for the test case at hand.
>>
>> Eh, how should that work? If I create a signalfd() and fork(), the
>> child's signalfd should only be concerned with signals sent to the
>> child. Not to mention what happens after the parent dies and the child
>> polls its fd.
>>
>> Or am I completely confused?
> 
> I think the child should not be getting signals for the child when
> it's reading from the parent's signalfd. read() and write() aren't
> supposed to look at properties of `current`.

That may be, but this has always been the semantics of signalfd(), quite
clearly documented in 'man signalfd'.

> Of course, if someone does rely on the current (silly) semantics, this
> might break stuff.

That, and Jens' patch only seemed to change the poll callback, so the
child (or whoever else got a hand on that signalfd) would wait for the
parent to get a signal, but then a subsequent read would attempt to
dequeue from the child itself.

So, I can't really think of anybody that might be relying on inheriting
a signalfd instead of just setting it up in the child, but changing the
semantics of it now seems rather dangerous. Also, I _can_ imagine
threads in a process sharing a signalfd (initial thread sets it up and
blocks the signals, all threads subsequently use that same fd), and for
that case it would be wrong for one thread to dequeue signals directed
at the initial thread. Plus the lifetime problems.

Rasmus

