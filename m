Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181961326E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 14:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgAGNAk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Jan 2020 08:00:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44165 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgAGNAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:00:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so73703820otj.11;
        Tue, 07 Jan 2020 05:00:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/tDonRgiYbrY37yCv1vErvadfPleOAtUFh1U/IUmHLA=;
        b=EdvocXaep5mpt3xPW8YRIw0QJue1/QkkuYzXgjyxYuBZhU/nTQ4pjsEtj0T9T+o0vA
         48Pv3QVX11+36hxalkmf+wzOaD/DPSkqeJ4EqhUDFeJ/1Pa2zta8/lqYr6xhAtV8a0hx
         7AChiTTqC1nzxqWwhrySsxqRMKYiCxcHg0XpIto7fFvABQmX0q+QrrMkPUHK3cEkBqzj
         XLN6OGGCQNyqHydHAKe7X6Pdq4mDaxz8rwhQJyc+VLpJ4h7WhJRxfRrzbaYRp2NBa5Tv
         huWdcDRPG8LtztPLnLDNtLTL3Aqk5EjdBonajFef0OKgBWcehc+NWjE4CimNVly8jIA+
         hnVw==
X-Gm-Message-State: APjAAAV/QxmXNJ5Bw8igqMy9T30NjORwComiR+qqsRBQgiYJiLPlWGnI
        8mRssl5lmp6ZEjiHDVYDr6S9+r2HOjY+msLsVs28HIst
X-Google-Smtp-Source: APXvYqwVEiZdtAx1URV7kxIlRfyWNFcbIl7T1Bf0xYRY+qICQQ3zwn9Zra7eC1drnbfK6J46aIOgcm6GkBlg6MFAFmE=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr124208561otm.297.1578402039812;
 Tue, 07 Jan 2020 05:00:39 -0800 (PST)
MIME-Version: 1.0
References: <1578399963-2229-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1578399963-2229-1-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Jan 2020 14:00:28 +0100
Message-ID: <CAMuHMdULcBE1inRzTRFJeRDToT1wW+nrMEfiUs7DxMLR0tqb3w@mail.gmail.com>
Subject: Re: [PATCH] sh: clk: Fix discarding const qualifier warning
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Jan 7, 2020 at 1:26 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> ioreadX() accepts pointer to non-const memory.  This fixes warnings
> like:
>
>     drivers/sh/clk/cpg.c: In function ‘r8’:
>     drivers/sh/clk/cpg.c:41:17: warning: passing argument 1 of ‘ioread8’
>         discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for your patch!

> --- a/drivers/sh/clk/cpg.c
> +++ b/drivers/sh/clk/cpg.c
> @@ -36,17 +36,17 @@ static void sh_clk_write(int value, struct clk *clk)
>                 iowrite32(value, clk->mapped_reg);
>  }
>
> -static unsigned int r8(const void __iomem *addr)
> +static unsigned int r8(void __iomem *addr)
>  {
>         return ioread8(addr);
>  }

Isn't the real issue that some implementations of ioreadX() take const,
while others don't?

Even the generic ones disagree:

    include/asm-generic/io.h:static inline u8 ioread8(const volatile
void __iomem *addr)
    include/asm-generic/iomap.h:extern unsigned int ioread8(void __iomem *);

IMHO they all should take "const volatile void __iomem *".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
