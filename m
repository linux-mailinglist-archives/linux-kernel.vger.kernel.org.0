Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A221D78F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 17:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388083AbfG2PkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 11:40:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50994 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387496AbfG2PkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:40:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so54313856wml.0;
        Mon, 29 Jul 2019 08:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CmXay1x1IIZbcae9B/nzgC2i3GQA4IAuHtEVfu4g9Tw=;
        b=UcKVtZ+GtKoGy23ls5y7hSLAMqN0maOm/n84NQv7B2QKT3CXLXVTcMzy4xYpSSxQ0Z
         7KaB0jDrm/HJNiLSSQcAgQu/6BziGAcPrQqan4fX0WrW2YSbdVmKSVQFudJC+h+Qa+09
         YillfqN8G0jMA/n4BECainDr0rp6tku2Xnhze1x2i8g/NxiAYgqnJS0JLKce6B9uD9hp
         8c57jiTUQqwf+3q1jrlbMAvWDVIfeBFmyr1pLuCda2Z+uKJyYXpD1Dji00+WATg4eSEo
         rpt3sVcB0R734uQo7iz/nsDdKeJGCpCnkuDYb+CObpFoJi/BeaJl2x4EfLsuqeMs9tTE
         YAhw==
X-Gm-Message-State: APjAAAUfY8ahv9y1SHcII8Kzr1ax78LMSZ9oPB0bcupYLejJxDK5MOOV
        f4tfCiGcucXHQiY0ie6/k9HQvonLUUcSxx4WlZI=
X-Google-Smtp-Source: APXvYqyQ3OcPxTZE79jySvwMYC8vjamWQiriNCux9/VdFtqDzRVM9Aw+s9kJqqoO9rN8rBLFEyB5tDfAGslo++GFlu8=
X-Received: by 2002:a7b:c310:: with SMTP id k16mr59906778wmj.133.1564414801859;
 Mon, 29 Jul 2019 08:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190729143007.GA8067@embeddedor>
In-Reply-To: <20190729143007.GA8067@embeddedor>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jul 2019 17:39:49 +0200
Message-ID: <CAMuHMdXEU4eUEdNyY=K2B_Tj=unJV2eSJo1BQ8vDwZ-D-2wDWg@mail.gmail.com>
Subject: Re: [PATCH] scsi: sun3_scsi: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Mon, Jul 29, 2019 at 4:32 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Mark switch cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> drivers/scsi/sun3_scsi.c: warning: this statement may fall through
> [-Wimplicit-fallthrough=]:  => 399:9, 403:9
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks!
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/scsi/sun3_scsi.c
> +++ b/drivers/scsi/sun3_scsi.c
> @@ -397,10 +397,12 @@ static int sun3scsi_dma_finish(int write_flag)
>                 case CSR_LEFT_3:
>                         *vaddr = (dregs->bpack_lo & 0xff00) >> 8;
>                         vaddr--;
> +                       /* Fall through */
>
>                 case CSR_LEFT_2:
>                         *vaddr = (dregs->bpack_hi & 0x00ff);
>                         vaddr--;
> +                       /* Fall through */
>

I think it would be clearer if you would drop the blank lines.

>                 case CSR_LEFT_1:
>                         *vaddr = (dregs->bpack_hi & 0xff00) >> 8;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
