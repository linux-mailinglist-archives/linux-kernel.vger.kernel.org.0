Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F28F9DB8B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 22:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440994AbfJQU6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 16:58:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42367 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437004AbfJQU6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 16:58:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so3862493wrw.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 13:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bwyoXQ4jJ4Q5almIdl345BmuxoSl8eF1qmSvscrD0n0=;
        b=IVTXzhWtbuaLfp8YXz+L8gLII5lGU1ebkqAd/xq4aWHP7GLdwF3jh8hD75ka45BcYR
         rMlTQmTIYEORbZKcfGUU0zRRfOhV/1Ych2oGyZQYB3wTcIuNaCMcK7gtLCw51zOewVDi
         ZNbpv0SXBn6FlgHTtfDp1kqeGPlilmqew5qKv1KWSyknezR9kbPQX0hj+knIhu66dcAF
         IoMGc0cU07u/AZ9fl5fX3dlKUhOZw1tdXjRu/KbPXEzvoy/4gviKn1aWohsq84E0Idhg
         op6109z7y4WdcTVtIZbbk70O8gufTDYPo04gLFpqRnpRkt3uteetCciSl6heWBVHrDca
         Coyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwyoXQ4jJ4Q5almIdl345BmuxoSl8eF1qmSvscrD0n0=;
        b=M4uRhxOC7Bb2l/QFZTIbjtfkpIp43fxysNNDLhzxcrQkiYKo8Y0FdOepHeRzCUGoGs
         4XLt1ep5aS0CKGeQALRYD4VcJK9SVu2XYhpdH/1IAKPsmE70ZNjoxl4HwyyBIOV3BJkt
         NEW5EEudQ4YT4aU9IypTi9FnyiGjKqMa2qIQd9XbZcFWb2UUZIu9VWQr1af0LkIS5STq
         KXGmh3CzbXGkVZ1h5AsOpd6DdXPiNBL/RYRawAwOkM4iMT53pewROM+mAyhuTyC4nmsQ
         0AK/T8lluC9Of2ME1yvg/i0rZc72CCccyv/7iqI5ApTdMZeVp1HPX9yDv77yTrJ6anas
         GRMw==
X-Gm-Message-State: APjAAAX4ZFrqjNZ8M5FCF0K9gL4bf4VFmamlThqf2Log+/QWrmRUK633
        z+N2hB///GDpH1d1hApwppnPQA0a+e1a08Itb8xskg==
X-Google-Smtp-Source: APXvYqxk1Vk38cij+hG08v9miH0CcUvMZrabHnfYeHSE3g3zvLP1lq8tbCLWWPfKrCnK3BUl+XaMDXrmNdKLu8CH8S8=
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr4527964wrt.36.1571345877272;
 Thu, 17 Oct 2019 13:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <CAO_48GFHx4uK6cWwJ4oGdJ8HNZNZYDzdD=yR3VK0EXQ86ya9-g@mail.gmail.com>
 <20190924162217.GA12974@arm.com> <20191009173742.GA2682@arm.com>
 <f4fb09a5-999b-e676-0403-cc0de41be440@ti.com> <20191014090729.lwusl5zxa32a7uua@DESKTOP-E1NTVVP.localdomain>
 <a213760f-1f41-c4a3-7e38-8619898adecd@ti.com> <CALAqxLV6EBHKPEaEkyfhEYyw0TXayTeY_4AWXfuASLLyxZh5+Q@mail.gmail.com>
 <a3c66479-7433-ec29-fbec-81aef60cb063@ti.com>
In-Reply-To: <a3c66479-7433-ec29-fbec-81aef60cb063@ti.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 17 Oct 2019 13:57:45 -0700
Message-ID: <CALAqxLWrsXG0XysL7RmhApbuZukDdG5VhdHOTS5odkG9f1ezwA@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        Pratik Patel <pratikp@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 12:29 PM Andrew F. Davis <afd@ti.com> wrote:
> On 10/17/19 3:14 PM, John Stultz wrote:
> > But if the objection stands, do you have a proposal for an alternative
> > way to enumerate a subset of CMA heaps?
> >
> When in staging ION had to reach into the CMA framework as the other
> direction would not be allowed, so cma_for_each_area() was added. If
> DMA-BUF heaps is not in staging then we can do the opposite, and have
> the CMA framework register heaps itself using our framework. That way
> the CMA system could decide what areas to export or not (maybe based on
> a DT property or similar).

Ok. Though the CMA core doesn't have much sense of DT details either,
so it would probably have to be done in the reserved_mem logic, which
doesn't feel right to me.

I'd probably guess we should have some sort of dt binding to describe
a dmabuf cma heap and from that node link to a CMA node via a
memory-region phandle. Along with maybe the default heap as well? Not
eager to get into another binding review cycle, and I'm not sure what
non-DT systems will do yet, but I'll take a shot at it and iterate.

> The end result is the same so we can make this change later (it has to
> come after DMA-BUF heaps is in anyway).

Well, I'm hesitant to merge code that exposes all the CMA heaps and
then add patches that becomes more selective, should anyone depend on
the initial behavior. :/

So, <sigh>, I'll start on the rework for the CMA bits.

That said, I'm definitely wanting to make some progress on this patch
series, so maybe we can still merge the core/helpers/system heap and
just hold the cma heap for a rework on the enumeration bits. That way
we can at least get other folks working on switching their vendor
heaps from ION.

Sumit: Does that sound ok? Assuming no other objections, can you take
the v11 set minus the CMA heap patch?

thanks
-john
