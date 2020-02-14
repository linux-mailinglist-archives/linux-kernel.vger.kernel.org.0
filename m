Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8A715D63E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 12:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbgBNLFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 06:05:01 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37643 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgBNLFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 06:05:00 -0500
X-Originating-IP: 90.65.102.129
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A4821E0016;
        Fri, 14 Feb 2020 11:04:58 +0000 (UTC)
Date:   Fri, 14 Feb 2020 12:04:58 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/8] PM fixes and improvements for SAM9X60
Message-ID: <20200214110458.GE3578@piout.net>
References: <1579522208-19523-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579522208-19523-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2020 14:10:00+0200, Claudiu Beznea wrote:
> Hi,
> 
> This series adds fixes and improvements for SAM9X60 as follows:
> - fix master clock register offset in pm_suspend.S
> - add support for disable/enable PLL for SAM9X60
> - minor fix in pm_suspend.S: s/sfr/sfrbu
> - move SAM9X60's macros for PLL in include/linux/clk/at91_pmc.h
> 
> Thank you,
> Claudiu Beznea
> 
> Claudiu Beznea (8):
>   ARM: at91: pm: use proper master clock register offset
>   Revert "ARM: at91: pm: do not disable/enable PLLA for ULP modes"
>   ARM: at91: pm: add macros for plla disable/enable
>   ARM: at91: pm: add pmc_version member to at91_pm_data
>   ARM: at91: pm: s/sfr/sfrbu in pm_suspend.S
>   clk: at91: move sam9x60's PLL register offsets to PMC header
>   ARM: at91: pm: add plla disable/enable support for sam9x60
>   ARM: at91: pm: add quirk for sam9x60's ulp1
> 
>  arch/arm/mach-at91/pm.c              |  35 ++++++-
>  arch/arm/mach-at91/pm.h              |   2 +
>  arch/arm/mach-at91/pm_data-offsets.c |   4 +
>  arch/arm/mach-at91/pm_suspend.S      | 189 ++++++++++++++++++++++++++++++++---
>  drivers/clk/at91/clk-sam9x60-pll.c   |  91 +++++++----------
>  include/linux/clk/at91_pmc.h         |  23 +++++
>  6 files changed, 270 insertions(+), 74 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
