Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2615F71CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 11:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfKKKX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 05:23:56 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:51923 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726768AbfKKKXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:23:55 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iU6rO-0007yi-Or; Mon, 11 Nov 2019 11:23:50 +0100
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v7 0/2] Add support for Layerscape external interrupt  lines
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Nov 2019 11:33:11 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>
In-Reply-To: <20191107122115.6244-1-linux@rasmusvillemoes.dk>
References: <20191107122115.6244-1-linux@rasmusvillemoes.dk>
Message-ID: <ea802f081d1f1d4c5359707ff4553004@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linux@rasmusvillemoes.dk, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kurt@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-07 13:30, Rasmus Villemoes wrote:
> In v7, I've tried to change from a custom binding to use
> interrupt-map, modelled on the recent addition of the
> renesas,rza1-irqc (commits a644ccb819bc and 5e27a314a11f). It's
> possible that the interrupt-map parsing code can be factored to a
> common helper, but it's a bit hard to generalize from two examples to
> know what a good interface would look like.
>
> The interrupt-map-mask is a bit arbitrary. 0xff would likely work 
> just
> as well (but I think the ls2088a has 32 external lines, so it has to
> be a least 0x1f).
>
> Also, this drops the fsl,bit-reverse property and instead reads the
> SCFGREVCR register to determine if bit-reversing is needed.
>
> The dt/bindings patch now comes first in accordance with
> Documentation/devicetree/bindings/submitting-patches.txt.
>
> Earlier versions can be found here:
>
> v6: 
> https://lore.kernel.org/lkml/20190923101513.32719-1-kurt@linutronix.de/
> v5:
> 
> https://lore.kernel.org/lkml/20180223210901.23480-1-rasmus.villemoes@prevas.dk/
>
> Rasmus Villemoes (2):
>   dt/bindings: Add bindings for Layerscape external irqs
>   irqchip: add support for Layerscape external interrupt lines
>
>  .../interrupt-controller/fsl,ls-extirq.txt    |  49 +++++
>  drivers/irqchip/Kconfig                       |   4 +
>  drivers/irqchip/Makefile                      |   1 +
>  drivers/irqchip/irq-ls-extirq.c               | 197 
> ++++++++++++++++++
>  4 files changed, 251 insertions(+)
>  create mode 100644
> 
> Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
>  create mode 100644 drivers/irqchip/irq-ls-extirq.c

Applied to irqchip-next.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
