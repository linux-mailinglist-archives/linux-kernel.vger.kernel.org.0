Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8763612A8A6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Dec 2019 18:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLYRZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Dec 2019 12:25:08 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:53253 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLYRZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 12:25:08 -0500
Received: from localhost (unknown [94.238.217.212])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 47887100002;
        Wed, 25 Dec 2019 17:25:04 +0000 (UTC)
Date:   Wed, 25 Dec 2019 18:25:04 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: at91: pm: use of_device_id array to find the
 proper shdwc node
Message-ID: <20191225172504.GC1111840@piout.net>
References: <1576062248-18514-1-git-send-email-claudiu.beznea@microchip.com>
 <1576062248-18514-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576062248-18514-3-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2019 13:04:08+0200, Claudiu Beznea wrote:
> Use of_device_id array to find the proper shdwc compatibile node.
> SAM9X60's shdwc changes were not integrated when
> commit eaedc0d379da ("ARM: at91: pm: add ULP1 support for SAM9X60")
> was integrated.
> 
> Fixes: eaedc0d379da ("ARM: at91: pm: add ULP1 support for SAM9X60")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/mach-at91/pm.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
