Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C73158A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 07:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgBKGz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 01:55:29 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46630 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgBKGz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 01:55:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id g64so9022817otb.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 22:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qsBaYW+8tB375NH6OQOHYpSP00PTX/24760IzgBPWM=;
        b=g0PIYJaWAWx7ZYpbMTj/h5I8yC9Of7h+6G71MOTcoKwG1sXqIRCtHnj2A1Bog8F0D6
         gRegnL9DOFPHP3NfmRiQphE7IsOBTlUM31AvacH3fpoDnqGnK2q8LqWAH2RR0/Q/7WzI
         duP1KOPfAuTlULiUAgHq6CLpSbUiTV1SO95ePO4rsRoWpQ0JplY3NS7yClKK7Cu6bwl8
         pVzpg5r5EZTiEqSZ4ZQxHUcDTdJ4FA67PpBHgKvI1GDq69mKuFWRGxvx3K0fTf7J98+/
         IQsiov/bIeai8YzlLGeROG8O9fZ7Fq2Ld7LVDxIjP47KB+IR1/ZBFkCo7JBoQGKe+ew2
         yJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qsBaYW+8tB375NH6OQOHYpSP00PTX/24760IzgBPWM=;
        b=atfv1n017Hkxu1fVMFWOfCgSLoL7oBEu2bjhJ6clxfYpMIOKxgQnGK+af2PZ5X6OZq
         LEEEMCQUNOyTGcDJ6rAe15L0P2iovigoY8JvK9K06hSR/7Aq6lAScsxsJPbCgKub3rpM
         v5A+1gklzVH0MsGU8lhKaqiSAOYI8bqwjQQn7SDmoX/jTRfmm+Y3WRfGtlLRTZH8Frhq
         hTu7huyQdI0/il/B/x4ZJxUbvdFpnyEQ3derPSxb83feq8uQCWoNLThjGa1BA/l0XxJg
         NAHPtIx7on04L6lEUkeyvh1eVyqiGmL10haALEP7OnvlSc+b/h2zF3on3IVU/O8RxID7
         6pvA==
X-Gm-Message-State: APjAAAVGtBFiNSaFJtJP/UElSY0JUU5rt0E8uYkfYR2MwW7zMxNN08Pr
        Oyg0wWXyqLNoL4ivYje8eaFx6kYvZZt9nLLJsjmfGUnh
X-Google-Smtp-Source: APXvYqxfpeNlSBi1DWWxelEmsr9hbXLc0MmgqyHPY0wwLkSBHpl+jlRuYrJEeQNRvkKIlN3ori5EnDnw9W4L7XWKMI0=
X-Received: by 2002:a9d:3e43:: with SMTP id h3mr3925618otg.84.1581404128257;
 Mon, 10 Feb 2020 22:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20200208084022.193231-1-gch981213@gmail.com> <1581323455.2213.6.camel@mtksdaap41>
In-Reply-To: <1581323455.2213.6.camel@mtksdaap41>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Tue, 11 Feb 2020 14:55:17 +0800
Message-ID: <CAJsYDVLzwWfT24NGDJMJShwoG0Qrq06mLqamHbH0xedmMLdrAQ@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: mtk-quadspi: add support for DMA reading
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     linux-mtd@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, Feb 10, 2020 at 4:31 PM Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
> > DMA busy checking is implemented with readl_poll_timeout because
> > I don't have access to IRQ-related docs. The speed increment comes
> > from those saved cmd+addr+dummy clocks.
>
> Hi Chuanhong,
>
> Thanks for your patch, I'm checking with Guochun to see if we could
> release IRQ related information to you.

Thanks for the info.
I'd like to keep using polling mode in this patch for easier reviewing.
It's already a pretty lengthy patch now. I may implement IRQ support
in future patches.

>
> > This controller requires that DMA source/destination address and
> > reading length should be 16-byte aligned. We use a bounce buffer if
> > one of them is not aligned, read more than what we need, and copy
> > data from corresponding buffer offset.
>
> I've checked with our HW guys. The limitation is on DRAM only.
> So for read we should check buffer and length to make sure it is
> aligned, but don't need to check from.

My previous test on mt7629 shows that from address also needs to
be aligned. e.g. If I perform a DMA read from 0x2 I actually got data
starting from 0x0 instead.

Regards,
Chuanhong Guo
