Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A1018507E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 21:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgCMUpP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Mar 2020 16:45:15 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:46855 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgCMUpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:45:15 -0400
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id EB12B200004;
        Fri, 13 Mar 2020 20:45:05 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] arm: mach-dove: Mark dove_io_desc as __maybe_unused
In-Reply-To: <20200306125638.8285-1-vincenzo.frascino@arm.com>
References: <20200306125638.8285-1-vincenzo.frascino@arm.com>
Date:   Fri, 13 Mar 2020 21:45:04 +0100
Message-ID: <87mu8kx9v3.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincenzo Frascino <vincenzo.frascino@arm.com> writes:

> Without this, we get the warnings below when CONFIG_MMU is disabled:
>
> linux/arch/arm/mach-dove/common.c:51:24: warning: ‘dove_io_desc’ defined
> but not used [-Wunused-variable]
> static struct map_desc dove_io_desc[] __initdata = {
>                        ^~~~~~~~~~~~
>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Applied on mvebu/arm

Thanks,

Gregory
> ---
>  arch/arm/mach-dove/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> index 01b830afcea9..dbe970e37895 100644
> --- a/arch/arm/mach-dove/common.c
> +++ b/arch/arm/mach-dove/common.c
> @@ -48,7 +48,7 @@
>  /*****************************************************************************
>   * I/O Address Mapping
>   ****************************************************************************/
> -static struct map_desc dove_io_desc[] __initdata = {
> +static struct map_desc __maybe_unused dove_io_desc[] __initdata = {
>  	{
>  		.virtual	= (unsigned long) DOVE_SB_REGS_VIRT_BASE,
>  		.pfn		= __phys_to_pfn(DOVE_SB_REGS_PHYS_BASE),
> -- 
> 2.25.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
