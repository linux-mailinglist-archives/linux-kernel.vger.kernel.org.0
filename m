Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7AE64CB12
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 11:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfFTJjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 05:39:16 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:51913 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfFTJjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:39:16 -0400
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B7EAA200003;
        Thu, 20 Jun 2019 09:39:13 +0000 (UTC)
Date:   Thu, 20 Jun 2019 11:39:12 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Philippe Mazenauer <philippe.mazenauer@outlook.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/Microchip (AT91) SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: add missing include platform-data/atmel.h
Message-ID: <20190620093912.GX23549@piout.net>
References: <VI1PR07MB443209D29ADFA139B9735D89FD000@VI1PR07MB4432.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR07MB443209D29ADFA139B9735D89FD000@VI1PR07MB4432.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/05/2019 09:36:57+0000, Philippe Mazenauer wrote:
> Include corresponding headerfile <linux/platform-data/atmel.h> for
> function at91_suspend_entering_slow_clock().
> 
> ../arch/arm/mach-at91/pm.c:279:5: warning: no previous prototype for ‘at91_suspend_entering_slow_clock’ [-Wmissing-prototypes]
>  int at91_suspend_entering_slow_clock(void)
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Philippe Mazenauer <philippe.mazenauer@outlook.de>
> ---
>  arch/arm/mach-at91/pm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
