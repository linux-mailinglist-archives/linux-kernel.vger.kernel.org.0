Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9DD9E514E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 18:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409555AbfJYQcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 12:32:53 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39714 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409520AbfJYQcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:32:52 -0400
Received: by mail-il1-f195.google.com with SMTP id i12so2378752ils.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=VRu4DyxG0YyclcQqaQ2raKSDjbldbf0XZXEiP7mXYGk=;
        b=GxSMRql1v3o4jRFIDm4nTbvjBtvY9OgYR3nCOG+KJaKk1kKuv1AeyCP6MNa4ETtbzH
         ZN5meYC3xcx8365zrs+uYmvZI8qP6xM68FDoYrT3RourFhao2gzQC3uQ8KHR1+T0GZ6n
         FLq5eQlpUxFQGpMUTbKDNyobCWhpTtH+BBkhAb+fBOToMKwmpvpIPOnqjW2rKv5xtt0L
         UYNrj/NnoSklNu/QVxk3wo8U8sHfBS2XsxMl3XAVcNr3vMTaEPG6PmYBf+yyaf1b1XFw
         7VI0vi5S9AjkiSzCc2Cr89ExJmPvzdGvvNi7sex7ZP0d/pAoP/GQkFglI3dAQ5iSkNGP
         PCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VRu4DyxG0YyclcQqaQ2raKSDjbldbf0XZXEiP7mXYGk=;
        b=YGyo3gV5SWIkfhNkwYoQD6VS1kN45wXnaLQS0FnHWor66HwBCG8fgPu9fyFKq/Taan
         U/RwhCrzSOyfUiF7Zf1eFW62ITQ4D2sEVyOjZYYnTi+kiWe1pzoCckyvQ8VGrlvk5mbi
         4bUm+NbKH7nXDpF49aZq0RmXsTFcxhvsw6VTe3qNhqG3YXlVBGl7AqoPy074dD+H4B1G
         nMUbuOjtPuU95reUQIr21vgEoSK2jnX/ZMfFd94KuyjfpMfjzrO7KAR8lvU9CtuJHeEy
         Ehn8eZyqeDakR+vfyo2AxbyCVnQLlbpYG/VVkzk7f0U4n26evxFdJr2wA7wAP64OdnyD
         ZXiw==
X-Gm-Message-State: APjAAAV5UUtxY9u1/wx7oQH1iHHRbfrGWQQG9Tzw5lJl2eyU19CZyjtR
        K0nXkCKtSQiAiyGVsHMN6idM5RpOT1MF6A==
X-Google-Smtp-Source: APXvYqwF/bEdWpUoFvbraiiARXM2qNWBEjlCOgGj8rCaCQmlnXrKGV15Bznn3yzMXbmiGb8vQR4EPg==
X-Received: by 2002:a92:8f94:: with SMTP id r20mr5285130ilk.41.1572021171149;
        Fri, 25 Oct 2019 09:32:51 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p5sm366365ils.32.2019.10.25.09.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 09:32:49 -0700 (PDT)
Subject: Re: [BUG] io_uring: defer logic based on shared data
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
 <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
 <b44b0488-ba66-0187-2d9b-6949ceb613fb@gmail.com>
 <96446fe1-4f32-642b-7100-ebfa291d7127@kernel.dk>
Message-ID: <df3b9edd-86ad-5460-b61b-66707c0fb630@kernel.dk>
Date:   Fri, 25 Oct 2019 10:32:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <96446fe1-4f32-642b-7100-ebfa291d7127@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/19 10:27 AM, Jens Axboe wrote:
> On 10/25/19 10:21 AM, Pavel Begunkov wrote:
>> On 25/10/2019 19:03, Jens Axboe wrote:
>>> On 10/25/19 3:55 AM, Pavel Begunkov wrote:
>>>> I found 2 problems with __io_sequence_defer().
>>>>
>>>> 1. it uses @sq_dropped, but doesn't consider @cq_overflow
>>>> 2. @sq_dropped and @cq_overflow are write-shared with userspace, so
>>>> it can be maliciously changed.
>>>>
>>>> see sent liburing test (test/defer *_hung()), which left an unkillable
>>>> process for me
>>>
>>> OK, how about the below. I'll split this in two, as it's really two
>>> separate fixes.
>> cached_sq_dropped is good, but I was concerned about cached_cq_overflow.
>> io_cqring_fill_event() can be called in async, so shouldn't we do some
>> synchronisation then?
> 
> We should probably make it an atomic just to be on the safe side, I'll
> update the series.

Here we go, patch 1:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=f2a241f596ed9e12b7c8f960e79ccda8053ea294

patch 2:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=b7d0297d2df5bfa0d1ecf9d6c66d23676751ef6a

-- 
Jens Axboe

