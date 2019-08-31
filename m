Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80100A4311
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 09:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfHaH3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 03:29:19 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:47090 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfHaH3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 03:29:19 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id D186225AEC1;
        Sat, 31 Aug 2019 17:29:16 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id AC331E218F0; Sat, 31 Aug 2019 09:29:14 +0200 (CEST)
Date:   Sat, 31 Aug 2019 09:29:14 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: ARM_ERRATA_775420: Spelling s/date/data/
Message-ID: <20190831072914.54vy2mvkk2iuovsg@verge.net.au>
References: <20190828133151.20585-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828133151.20585-1-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 03:31:51PM +0200, Geert Uytterhoeven wrote:
> Caching dates is never a good idea ;-)
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index dcf46f0e45c24a5f..eb18279a63027c08 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1040,7 +1040,7 @@ config ARM_ERRATA_775420
>         depends on CPU_V7
>         help
>  	 This option enables the workaround for the 775420 Cortex-A9 (r2p2,
> -	 r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
> +	 r2p6,r2p8,r2p10,r3p0) erratum. In case a data cache maintenance
>  	 operation aborts with MMU exception, it might cause the processor
>  	 to deadlock. This workaround puts DSB before executing ISB if
>  	 an abort may occur on cache maintenance.
> -- 
> 2.17.1
> 
