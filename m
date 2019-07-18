Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBCA6C910
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 08:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbfGRGE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 02:04:58 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:56708 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfGRGE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:04:58 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x6I64nA0006135
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 15:04:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x6I64nA0006135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563429890;
        bh=9Cn27QIZQfB3/PlsDEzrhs3gsGNmfjgopl2Ueaqh2co=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DZ3QsT76aj6vYbKEXrr2j5egWye+7CzEUgQsrfOWOKHmx7JvShI+lArzlcW+AOyvW
         wSnANMWV0XV6vrhCS54i04y7kxYcznx4J77KcLz+b+yAgJBWXHPYsfxZAUbkGlbIEg
         Wpy1jycQ9ihqjwaQ6+dRgXMvQVOVCKDbuVVeu8pezwhgRb0iPhW2HMmEJrXpN0Hwca
         Z9XpiacJPM0Xn6AZVGCdUw/RQ291pjY+J6nJm2TER9rzOusSlfNAz4EE6IWstB5/c9
         sipLWjExYxEma8+YyZTycddtWzAD1pkERquktIODyC0IbIeXj8FJ0WaNnwVYx3yTzq
         EiYfwG04kugtw==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id f68so5537116vkf.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 23:04:50 -0700 (PDT)
X-Gm-Message-State: APjAAAUOhvcAhQUzMcpKEK6TLVTwszn9+7kCKavMIIIU7ra4y+c/RW1u
        CEKz7A/Eans3K4ixiX1caSkGsov8uaO0swpVhHo=
X-Google-Smtp-Source: APXvYqzXwpNJxPAL3xak/xnvOG1FGRThsufi0IBo8anhshmeGUb3O1ZZmDqs4cK2QAroVJNrjr7kw7opeFsKmiXQ9mA=
X-Received: by 2002:a1f:a34c:: with SMTP id m73mr4593622vke.74.1563429888906;
 Wed, 17 Jul 2019 23:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190710051320.8738-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190710051320.8738-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 18 Jul 2019 15:04:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQFPLcVrF4PiirqTy3PjPh_BTWNMzdMiNFaen6g1ew+Mw@mail.gmail.com>
Message-ID: <CAK7LNAQFPLcVrF4PiirqTy3PjPh_BTWNMzdMiNFaen6g1ew+Mw@mail.gmail.com>
Subject: Re: [PATCH] ARM: stm32: use "depends on" instead of "if" after prompt
To:     arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, Alexandre Torgue <alexandre.torgue@st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,



On Wed, Jul 10, 2019 at 2:15 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> This appeared after the global fixups by commit e32465429490 ("ARM: use
> "depends on" for SoC configs instead of "if" after prompt"). Fix it now.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


I think probably this is too late,
but I am afraid you silently added a wrong Fixes tag.




commit 7e8a0f10899075ac2665c78c4e49dbaf32bf3346
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed Jul 10 14:13:20 2019 +0900

    ARM: stm32: use "depends on" instead of "if" after prompt

    This appeared after the global fixups by commit e32465429490 ("ARM: use
    "depends on" for SoC configs instead of "if" after prompt"). Fix it now.

    Link: https://lore.kernel.org/r/20190710051320.8738-1-yamada.masahiro@socionext.com
    Fixes: e32465429490 ("ARM: use "depends on" for SoC configs
instead of "if" after prompt")
    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
    Signed-off-by: Olof Johansson <olof@lixom.net>





Commit e32465429490 converted all instances at that time.
This is absolutely fine.


Later, in 2018, commit 3ed71f8ad98a added a new instance.

So, if this Fixes is wanted, it should have been
Fixes: 3ed71f8ad98a ("ARM: stm32: prepare stm32 family to welcome
armv7 architecture")


This would confuse the stable kernel maintainers.



>  arch/arm/mach-stm32/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
> index 05d6b5aada80..57699bd8f107 100644
> --- a/arch/arm/mach-stm32/Kconfig
> +++ b/arch/arm/mach-stm32/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menuconfig ARCH_STM32
> -       bool "STMicroelectronics STM32 family" if ARM_SINGLE_ARMV7M || ARCH_MULTI_V7
> +       bool "STMicroelectronics STM32 family"
> +       depends on ARM_SINGLE_ARMV7M || ARCH_MULTI_V7
>         select ARMV7M_SYSTICK if ARM_SINGLE_ARMV7M
>         select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
>         select ARM_GIC if ARCH_MULTI_V7
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
