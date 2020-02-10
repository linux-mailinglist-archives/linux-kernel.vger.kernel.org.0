Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E24158042
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 17:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgBJQ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 11:56:16 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33317 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgBJQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:56:16 -0500
X-Originating-IP: 90.65.102.129
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 306F6E0024;
        Mon, 10 Feb 2020 16:56:14 +0000 (UTC)
Date:   Mon, 10 Feb 2020 17:56:13 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 05/20] ARM: at91: Drop unneeded select of COMMON_CLK
Message-ID: <20200210165613.GE3878@piout.net>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
 <20200121103722.1781-5-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121103722.1781-5-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2020 11:37:07+0100, Geert Uytterhoeven wrote:
> Support for AT91/Microchip SoCs depends on ARCH_MULTIPLATFORM or
> ARM_SINGLE_ARMV7M, which both select COMMON_CLK.
> Hence there is no need for COMMON_CLK_AT91 to select COMMON_CLK.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
> All patches in this series are independent of each other.
> Cover letter at https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
