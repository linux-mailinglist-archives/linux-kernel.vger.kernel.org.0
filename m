Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293BE888EA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 08:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfHJGyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 02:54:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37663 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfHJGyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 02:54:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id f17so5859741otq.4;
        Fri, 09 Aug 2019 23:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOMFEQULG4ETNfmsGWkYizG85VQ8dOBtOOsPpC+4IwY=;
        b=L5CFCCJphaLGy3vIdj8h5tSRWryp3pwAlfCE/gK6iIsemDIoSfauqYe4zzpqAob9JI
         Vu6OKizu7JSdv4FulOzDoyR7OrVofMkQzHaLCi3l9AQDclv99Y+SjVyThweQ+3ZX6BeC
         vRywy9HgytCWXeIlMAyUco+r6Jgs7gcijh19sIWFsLPNF68BPXnjCNv7yGyBmrQ8Bndc
         9Gsv+6g3KfJwx+982Faku4wPRLydl9iIg720l4zXnnTYkbEhCbMcoN+XD/I+loHwaA+x
         JOAIzc7d9v+fai9bnSOmkxllK2+3vzAUf3Y+meJQhL/ECE+StzukjD/Ke/WFxCbGvMuB
         Uu7g==
X-Gm-Message-State: APjAAAWpcAoVCTMmrxu9nLWU90ohpG/hKGrB6xqVTxM6DaRvSuYiXXIy
        aQX5JvxBI+aUczRrnWxhXATTCCW9nn4KL915VE0=
X-Google-Smtp-Source: APXvYqzx/6FRCr7+yJQuE/vV4iW79D32w2ZddbygPHnzwQk6mt6bW5QSWrxyu66D6u1qWeaVyzMGijid1pHQPAzCr+M=
X-Received: by 2002:a9d:459d:: with SMTP id x29mr6988532ote.39.1565420039948;
 Fri, 09 Aug 2019 23:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190810045944.GA13815@embeddedor>
In-Reply-To: <20190810045944.GA13815@embeddedor>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 10 Aug 2019 08:53:48 +0200
Message-ID: <CAMuHMdVF8qoqR2EkCe8ND-SDMRf8tiEDdbZ0fJCL+eziiXBKBg@mail.gmail.com>
Subject: Re: [PATCH] sh: kernel: hw_breakpoint: Fix missing break in switch statement
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 6:59 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Add missing break statement in order to prevent the code from
> erroneously falling through to case SH_BREAKPOINT_WRITE.
>
> Fixes: 09a072947791 ("sh: hw-breakpoints: Add preliminary support for SH-4A UBC.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
