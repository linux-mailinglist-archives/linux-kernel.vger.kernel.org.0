Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC4DDADA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 05:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfD2Dpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Apr 2019 23:45:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53075 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfD2Dpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 23:45:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44srCd1L0jz9s6w;
        Mon, 29 Apr 2019 13:45:32 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Enrico Weigelt\, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 037/114] arch: powerpc: Kconfig: pedantic formatting
In-Reply-To: <1552310346-7629-38-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net> <1552310346-7629-38-git-send-email-info@metux.net>
Date:   Mon, 29 Apr 2019 13:45:30 +1000
Message-ID: <87d0l5a2zp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Enrico Weigelt, metux IT consult" <info@metux.net> writes:
> Formatting of Kconfig files doesn't look so pretty, so let the
> Great White Handkerchief come around and clean it up.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  arch/powerpc/Kconfig                   | 28 ++++++++++++++--------------
>  arch/powerpc/kvm/Kconfig               |  6 +++---
>  arch/powerpc/platforms/40x/Kconfig     |  7 +++----
>  arch/powerpc/platforms/44x/Kconfig     | 10 +++++-----
>  arch/powerpc/platforms/85xx/Kconfig    |  8 ++++----
>  arch/powerpc/platforms/86xx/Kconfig    |  6 +++---
>  arch/powerpc/platforms/maple/Kconfig   |  2 +-
>  arch/powerpc/platforms/pseries/Kconfig | 18 +++++++++---------
>  arch/powerpc/sysdev/xics/Kconfig       | 13 ++++++-------
>  9 files changed, 48 insertions(+), 50 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2d0be82..ea29d94 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -430,13 +430,13 @@ config MATH_EMULATION_HW_UNIMPLEMENTED
>  endchoice
>  
>  config PPC_TRANSACTIONAL_MEM
> -       bool "Transactional Memory support for POWERPC"
> -       depends on PPC_BOOK3S_64
> -       depends on SMP
> -       select ALTIVEC
> -       select VSX
> -       ---help---
> -         Support user-mode Transactional Memory on POWERPC.
> +	bool "Transactional Memory support for POWERPC"
> +	depends on PPC_BOOK3S_64
> +	depends on SMP
> +	select ALTIVEC
> +	select VSX
> +	---help---
> +	  Support user-mode Transactional Memory on POWERPC.

If you're going to do this can you also convert all the "---help---"
instances to just "help"? Thanks.

cheers
