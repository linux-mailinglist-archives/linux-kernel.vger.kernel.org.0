Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8779B75F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 21:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391960AbfHWTvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 15:51:35 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:36809 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387948AbfHWTvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 15:51:35 -0400
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 6EF84200006;
        Fri, 23 Aug 2019 19:51:33 +0000 (UTC)
Date:   Fri, 23 Aug 2019 21:51:33 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] MAINTAINERS: at91: remove the TC entry
Message-ID: <20190823195133.GF30479@piout.net>
References: <20190823083158.2649-1-nicolas.ferre@microchip.com>
 <20190823083158.2649-2-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823083158.2649-2-nicolas.ferre@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2019 10:31:57+0200, Nicolas Ferre wrote:
> "MICROCHIP TIMER COUNTER (TC) AND CLOCKSOURCE DRIVERS" is better
> removed because one file entry is outdated and basically, the
> maintainer's pool of Alexandre, Ludovic and myself is better suited.
> 
> drivers/misc/atmel_tclib.c file is going away in a patch to come and
> drivers/clocksource/tcb_clksrc.c file is actually named timer-atmel-tcb.c.
> This new name is catches by AT91 entry regular expression.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  MAINTAINERS | 7 -------
>  1 file changed, 7 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
