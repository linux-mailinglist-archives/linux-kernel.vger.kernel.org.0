Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8488C0409
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 13:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfI0LWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 07:22:22 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:50764 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbfI0LWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 07:22:22 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iDoKF-00076R-Dm; Fri, 27 Sep 2019 13:22:15 +0200
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] ARM: dts: stm32: Enable high resolution timer
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Sep 2019 12:22:13 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     <alexandre.torgue@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20190927084819.645-1-benjamin.gaignard@st.com>
References: <20190927084819.645-1-benjamin.gaignard@st.com>
Message-ID: <da48ce9633441cd0186518fa7ce1d528@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: benjamin.gaignard@st.com, alexandre.torgue@st.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-27 09:48, Benjamin Gaignard wrote:
> Adding always-on makes arm arch_timer claim to be an high resolution 
> timer.
> That is possible because power mode won't stop clocking the timer.

The "always-on" is not about the clock. It is about the comparator.
The clock itself is *guaranteed* to always tick. If it didn't, that'd 
be
an integration bug, and a pretty bad one.

What you're claiming here is that your CPU never enters a low-power 
mode?
Ever? I find this very hard to believe.

Furthermore, claiming that always-on is the way to force the arch-timer
to be an hrtimer is factually wrong. This is what happens *if* this is
the only timer in the system. The only case this is true is for virtual
machines. Anything else has a global timer somewhere that will allow
the arch timers to be used as an hrtimer.

I'm pretty sure you too have a global timer somewhere in your system.
Enable it, and enjoy hrtimers without having to lie about the 
properties
of your system! ;-)

         M.

>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  arch/arm/boot/dts/stm32mp157c.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi
> b/arch/arm/boot/dts/stm32mp157c.dtsi
> index 9b11654a0a39..74f64745d60d 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -50,6 +50,7 @@
>  			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>  		interrupt-parent = <&intc>;
> +		always-on;
>  	};
>
>  	clocks {

-- 
Jazz is not dead. It just smells funny...
