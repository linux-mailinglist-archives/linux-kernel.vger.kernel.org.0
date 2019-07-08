Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 486F762A70
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 22:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbfGHUgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 16:36:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38419 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbfGHUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:36:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so17593496oth.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qe5f0EDVATVL0N7NSDDI5WXAMQmNtXY4o6ydJGSb8Vs=;
        b=hK8tK7cjj5MyLXUnojRmG64LHq5JV3s0kBTMl18nCy5vHXnz/MkMV7/YebLnI1I9hm
         awpUSeSukqZXa56AI3tcSLVkPXWzFFmo9TB96mRJ5CH20qxvCbSpOHu+UAyUwOZ3N65l
         RLg7V7Fxjbkduv46ydURu2FUtXr2eUKbvuY3n8sx38C8iRppQO19TBkSFli/ZjwpfU9B
         lvyhu6dxcR9/P4QesOCunFCciWT2fM/MUc3tzjkT0g9M7UnGO3fvvyfeEzc+Lx07ZYBT
         HxD3qL+ZKae8oATC/vd14WRmtUQ1mPFRUNNMzl8gjUzVCGeIQWhVv3bp1CS/AGQft8fM
         ZOuQ==
X-Gm-Message-State: APjAAAUECU6bZLqW4O0QH/Eyqt6jGl8gkAzdGUA7k7Zbm1tUwrooaYy7
        h0MIOp2M3lyT850Dh/lOVyy1ZdNY0BO/VKYJAiY=
X-Google-Smtp-Source: APXvYqx6tI2WpnaTybSb+TCvct1+nq7729w6Hn0HlYlR5aWgq9/dN9+1X8Vt+weNtgqwX0+zQ6R1vJ4m6gUNP+v65qs=
X-Received: by 2002:a9d:5c11:: with SMTP id o17mr1403051otk.107.1562618176346;
 Mon, 08 Jul 2019 13:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190708170647.GA12313@roeck-us.net> <CAMuHMdUnSqKHA7EN1S8U7eBODs4gi-raw4P3FxnR_afhb2Zd5g@mail.gmail.com>
 <20190708194516.GA18304@roeck-us.net> <CAMuHMdVKKkx_S_mXmCzckyiw1fbLQMEZroRT+UchHv+tgF-3RA@mail.gmail.com>
 <20190708202226.GA15167@lst.de>
In-Reply-To: <20190708202226.GA15167@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Jul 2019 22:36:05 +0200
Message-ID: <CAMuHMdUUpyiRp3LdfE0M96dM6kAzse+gfXWqEQWe9ScwT9GX4A@mail.gmail.com>
Subject: Re: m68k build failures in -next: undefined reference to `arch_dma_prep_coherent'
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Jul 8, 2019 at 10:22 PM Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jul 08, 2019 at 10:19:41PM +0200, Geert Uytterhoeven wrote:
> > Yeah, it started when I queued up the DMA rework.
> > I didn't double-check when Greg said it was OK for him, as it wouldn't affect
> > Coldfire or mmu. Sorry for that.
> > And that has just been pulled by Linus... Oops...

Note that the build failure is more subtle: both m5307c3_defconfig and
m5475evb_defconfig build fine in m68k/for-linus, but fail in
next-20190708.  So it fails when combined with other changes, going
in through a different tree (the DMA tree?).

> The fix should have been in your inbox for a while..

Thanks, your patch fixes that.
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
