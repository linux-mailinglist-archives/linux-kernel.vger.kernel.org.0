Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D0656589
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 11:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfFZJPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 05:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFZJPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:15:32 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72F4C20645;
        Wed, 26 Jun 2019 09:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561540531;
        bh=xBnCRh/F9bl6/gAL0HvFg53BgxFLrpsTqE33GFGpnm0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VVq8wBfVS5xintLI48TW9kBhV9VZXd7wsC7XTHDvGz+45ZHMzLEshd0cc40XV1AlW
         cEHClsFnzaiXP6MueZieKdyXFv/krzT8tynqDCnEMduVjrOK9IfrMIk7QtIEhnQY5y
         6o0OCnAp256XmDddmef6KdghJEFfdbm2kT3RNHlM=
Received: by mail-lf1-f46.google.com with SMTP id a25so1069734lfg.2;
        Wed, 26 Jun 2019 02:15:31 -0700 (PDT)
X-Gm-Message-State: APjAAAXcfRpRfvjrCn1C+w6KnEaMW24Ptr5vhtO3WS+bDvHhut+pB+n7
        PRq+m7CAuVf9O+lNLlZ1WqZfMby0jBgFr/3zfOM=
X-Google-Smtp-Source: APXvYqzd8GB5R50ZJNdOxfdPEXjKaYgCH773OG1ZTg+eqJ9KRgvJXOGEjgcSVC5XUphD0RI4i6IPGHaaFxJMs/VSFY0=
X-Received: by 2002:a19:3804:: with SMTP id f4mr2023177lfa.69.1561540529761;
 Wed, 26 Jun 2019 02:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190625193451.7696-1-krzk@kernel.org> <20190625193451.7696-4-krzk@kernel.org>
In-Reply-To: <20190625193451.7696-4-krzk@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 26 Jun 2019 11:15:18 +0200
X-Gmail-Original-Message-ID: <CAJKOXPejHBKp1fnhqaKwx2vby1_XmP916TyA9Nw8usU5QNadbA@mail.gmail.com>
Message-ID: <CAJKOXPejHBKp1fnhqaKwx2vby1_XmP916TyA9Nw8usU5QNadbA@mail.gmail.com>
Subject: Re: [GIT PULL 4/4] ARM: exynos: Mach for v5.3
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019 at 21:35, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
>
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.3
>
> for you to fetch changes up to a55e040c6f21f55f81c53c56e1d8095df35e1d02:
>
>   ARM: exynos: Cleanup cppcheck shifting warning (2019-06-25 20:45:09 +0200)
>
> ----------------------------------------------------------------
> Samsung mach/soc changes for v5.3
>
> Only cleanups and minor fixes.
>
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       ARM: exynos: Only build MCPM support if used

Hi,

I forgot to mention possible merge conflict (although Stephen Cc-ed
you on mails). Resolution is to accept both sides:

diff --cc arch/arm/mach-exynos/Makefile
index 5ccf9d7e58d4,5abf3db23912..0fd3fcf8bfb0
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@@ -14,5 -14,9 +14,5 @@@ obj-$(CONFIG_PM_SLEEP)                += suspend.

  obj-$(CONFIG_SMP)             += platsmp.o headsmp.o

- obj-$(CONFIG_MCPM)            += mcpm-exynos.o
 -plus_sec := $(call as-instr,.arch_extension sec,+sec)
 -AFLAGS_exynos-smc.o           :=-Wa,-march=armv7-a$(plus_sec)
 -AFLAGS_sleep.o                        :=-Wa,-march=armv7-a$(plus_sec)
 -
+ obj-$(CONFIG_EXYNOS_MCPM)     += mcpm-exynos.o

Best regards,
Krzysztof
