Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC201185A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 11:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfLJK5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 05:57:30 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:52553 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfLJK5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:57:30 -0500
Received: from localhost (136.112.broadband15.iol.cz [90.182.112.136])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id EF415100016;
        Tue, 10 Dec 2019 10:57:21 +0000 (UTC)
Date:   Tue, 10 Dec 2019 11:57:19 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ingo van Lil <inguin@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: Reenable UART TX pull-ups
Message-ID: <20191210105719.GF1463890@piout.net>
References: <20191203142147.875227-1-inguin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203142147.875227-1-inguin@gmx.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2019 15:21:47+0100, Ingo van Lil wrote:
> Pull-ups for SAM9 UART/USART TX lines were disabled in a previous
> commit. However, several chips in the SAM9 family require pull-ups to
> prevent the TX lines from falling (and causing an endless break
> condition) when the transceiver is disabled.
> 
> From the SAM9G20 datasheet, 32.5.1: "To prevent the TXD line from
> falling when the USART is disabled, the use of an internal pull up
> is mandatory.". This commit reenables the pull-ups for all chips having
> that sentence in their datasheets.
> 
> Fixes: 5e04822f7db5 ("ARM: dts: at91: fixes uart pinctrl, set pullup on rx, clear pullup on tx")
> Signed-off-by: Ingo van Lil <inguin@gmx.de>
> Cc: Peter Rosin <peda@axentia.se>
> ---
>  arch/arm/boot/dts/at91sam9260.dtsi | 12 ++++++------
>  arch/arm/boot/dts/at91sam9261.dtsi |  6 +++---
>  arch/arm/boot/dts/at91sam9263.dtsi |  6 +++---
>  arch/arm/boot/dts/at91sam9g45.dtsi |  8 ++++----
>  arch/arm/boot/dts/at91sam9rl.dtsi  |  8 ++++----
>  5 files changed, 20 insertions(+), 20 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
