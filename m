Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F39194BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 23:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCZWrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 18:47:17 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53248 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbgCZWrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:47:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ADD058EE178;
        Thu, 26 Mar 2020 15:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1585262836;
        bh=hRVf8NlKn3i8rNQchhttvFvJ9qlop4GBPFXG8dhOHXw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=U7md1OlTrio/h+3wMf9IviRtC/1ZPDuUWWYj42WG9GkmmJMvjMTXhGjEsNNZpfoWD
         6I6HSVSe4Em26NI/fvyDxOvhFhnkQ422guLsVB/TBg91iRnuK7bF3nN2cToS6J2YD8
         Hp7xbubUssmYBDhEgbkTLg1F+o/U63+BTMzQsj/Y=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Dep9nIyQbzLD; Thu, 26 Mar 2020 15:47:16 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0ABA18EE15F;
        Thu, 26 Mar 2020 15:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1585262836;
        bh=hRVf8NlKn3i8rNQchhttvFvJ9qlop4GBPFXG8dhOHXw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=U7md1OlTrio/h+3wMf9IviRtC/1ZPDuUWWYj42WG9GkmmJMvjMTXhGjEsNNZpfoWD
         6I6HSVSe4Em26NI/fvyDxOvhFhnkQ422guLsVB/TBg91iRnuK7bF3nN2cToS6J2YD8
         Hp7xbubUssmYBDhEgbkTLg1F+o/U63+BTMzQsj/Y=
Message-ID: <1585262834.3581.8.camel@HansenPartnership.com>
Subject: Re: [PATCH] parisc: Regenerate parisc defconfigs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Helge Deller <deller@gmx.de>, Guenter Roeck <linux@roeck-us.net>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 26 Mar 2020 15:47:14 -0700
In-Reply-To: <20200326221921.GA20495@ls3530.fritz.box>
References: <20200326202006.GA160630@roeck-us.net>
         <20200326221921.GA20495@ls3530.fritz.box>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-26 at 23:19 +0100, Helge Deller wrote:
> * Guenter Roeck <linux@roeck-us.net>:
> > On Mon, Feb 03, 2020 at 10:31:22PM +0100, Helge Deller wrote:
> > > Regenerate the 32- and 64-bit defconfigs and drop the outdated
> > > specific
> > > machine defconfigs for the 712, A500, B160, C3000 and C8000
> > > workstations.
> > > ---
> > >  arch/parisc/configs/712_defconfig           | 181 --------------
> > > -
> > >  arch/parisc/configs/a500_defconfig          | 177 --------------
> > > -
> > >  arch/parisc/configs/defconfig               | 206 --------------
> > > ---
> > 
> > Since the removal of arch/parisc/configs/defconfig, "make
> > ARCH=parisc
> > defconfig" results in an endless recursive make loop.
> 
> Can you please test the patch below?
> Helge
> 
> ----
> [PATCH] parisc: Fix defconfig selection
> 
> Fix the recursive loop when running "make ARCH=parisc defconfig".
> 
> Fixes: 84669923e1ed ("parisc: Regenerate parisc defconfigs")
> Noticed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 71034b54d74e..3801a2ef9bca 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -79,6 +79,11 @@ config MMU
>  config STACK_GROWSUP
>  	def_bool y
> 
> +config ARCH_DEFCONFIG
> +	string
> +	default "arch/parisc/configs/generic-32bit_defconfig" if
> !64BIT
> +	default "arch/parisc/configs/generic-64bit_defconfig" if
> 64BIT
> +
>  config GENERIC_LOCKBREAK
>  	bool
>  	default y
> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
> index dca8f2de8cf5..628cd8bb7ad8 100644
> --- a/arch/parisc/Makefile
> +++ b/arch/parisc/Makefile
> @@ -34,6 +34,13 @@ CC_ARCHES	= hppa hppa2.0 hppa1.1
>  LD_BFD		:= elf32-hppa-linux
>  endif
> 
> +# select defconfig based on actual architecture
> +ifeq ($(shell uname -m),parisc64)

This won't work for cross builds.  You should be able to use
$(CONFIG_64BIT) here, though.

James

