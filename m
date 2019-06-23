Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E48BB4FC03
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2019 16:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfFWOOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 10:14:22 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:45903 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWOOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 10:14:22 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x5NEEGLB028061
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 23:14:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x5NEEGLB028061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561299257;
        bh=NuvwZgU5VzQ83P+ghCASox//DwIgbA0bWMR3kZMvN4o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xEJOfUUocWnyWNl48IDIhe4EXWlkJf0yxActmOaDbNwmDYHC38bdx9uoElM1M9GqP
         wD9SDiEqGd/3UCYZLrc+jwWhth6UE8juCnnWu1/wEN6459/JH9X++LrDalzmcNuPHT
         nnpTbqp6p3MoshQMxaSMDyeF12tolaoj2GSEeSwtrcfmAURvhFv8eEfoVnhRt8t2L7
         8QuWCBadcXNOzogzd2qOKWTzNNBlZxqpSCb26WZ3q7tHcTzYRSAcOnIHgxW+tCDf92
         dmasqnHgHVoYyduApfF06aVNiqQOHuBImU9hkC4bwyE0eTCC2zVBLu8bjyArVzR4Dk
         rTvxQD4aj5aSA==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id u124so6914640vsu.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 07:14:17 -0700 (PDT)
X-Gm-Message-State: APjAAAUKGo3cyG6137qZVpXvDaF9hlNjTMyjNa1lCfUzRyjdr3v7pvGf
        M5ZH6Vp0xdTIQSAXtY/kUIK3NDgIZTFXch//DmQ=
X-Google-Smtp-Source: APXvYqwie7xjtXMjHUN+TIIxSMQan1QJFChMNteSA1Qakl5NCxQ1GZtJ35sWLOosqjnrSwhu4vf+3bw8E0evMuHRsOk=
X-Received: by 2002:a67:f495:: with SMTP id o21mr65723335vsn.54.1561299256313;
 Sun, 23 Jun 2019 07:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <1557666733-19527-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1557666733-19527-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 23 Jun 2019 23:13:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNATViOYXJVLuJ8VnCruyMAPbYOkTc_0ZuW+gqi5H9x9-cA@mail.gmail.com>
Message-ID: <CAK7LNATViOYXJVLuJ8VnCruyMAPbYOkTc_0ZuW+gqi5H9x9-cA@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove pointless second entry for CONFIG_TRACE_IRQFLAGS_SUPPORT
To:     Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 10:16 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Strangely enough, NIOS2 defines TRACE_IRQFLAGS_SUPPORT twice
> with different values, which is pointless and confusing.
>
> [1] arch/nios2/Kconfig
>
>   config TRACE_IRQFLAGS_SUPPORT
>           def_bool n
>
> [2] arch/nios2/Kconfig.debug
>
>   config TRACE_IRQFLAGS_SUPPORT
>           def_bool y
>
> [1] is included before [2]. In the Kconfig syntax, the first one
> is effective. So, TRACE_IRQFLAGS_SUPPORT is always 'n'.
>
> The second define in arch/nios2/Kconfig.debug is dead code.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Ping.


>  arch/nios2/Kconfig.debug | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug
> index f1da8a7..a8bc06e 100644
> --- a/arch/nios2/Kconfig.debug
> +++ b/arch/nios2/Kconfig.debug
> @@ -1,8 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -config TRACE_IRQFLAGS_SUPPORT
> -       def_bool y
> -
>  config EARLY_PRINTK
>         bool "Activate early kernel debugging"
>         default y
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
