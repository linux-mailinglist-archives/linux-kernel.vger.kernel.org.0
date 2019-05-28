Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 809F52C806
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 15:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfE1Nnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 09:43:46 -0400
Received: from plaes.org ([188.166.43.21]:54830 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbfE1Nnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:43:45 -0400
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id C71B5402DD;
        Tue, 28 May 2019 13:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1559051023; bh=f16GXwO0bccw+CqyxghYo/6IH2hKOaqFoaXAUl2gBYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsFTjcKaRiqZx+PCgmpPV4uZ/cM9FBuepy2A96v2cnNvGBmmSQLg7/hAyTqSWCbIb
         XnTU75k8LsJlRz+Kmx6Ry+gKKR3lBa6ZCm80MNo8WlPBbf0cux4PwMlvoqHlBIyRPZ
         4XC/sNs+shNbpEATraIYAAT2UGxSvrKGxcAw3fPjUgcA2nOFsvP4nLJNkg+rZTE1XO
         nKgXg8HWyQk1ERo7LO3sHRrqb9nPZQFu2biMrYy5JYUzCf14XoX6OeyOXBLQf0M3Jl
         jO9GlPYr/8XKFdrmUZx0LXfL0XTxBiMoFdTeZAVXSfYg7u68J8oijIh8CS0O916rZV
         D/Jp3Frlo70pg==
Date:   Tue, 28 May 2019 13:43:42 +0000
From:   Priit Laes <plaes@plaes.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [RESEND PATCH] ARM: dts: sun7i: olimex-lime2:
 Enable ac and power supplies
Message-ID: <20190528134342.25fep6kpmrr4p7vw@plaes.org>
References: <20190528063544.17408-1-plaes@plaes.org>
 <2b671c1f0734177a6283407f753403473b70f5bc.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b671c1f0734177a6283407f753403473b70f5bc.camel@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 02:58:57PM +0200, Paul Kocialkowski wrote:
> Hi,
> 
> On Tue, 2019-05-28 at 09:35 +0300, Priit Laes wrote:
> > Lime2 has battery connector so enable these supplies.
> 
> Out of curiosity, what is reported to userspace when no battery is
> attached?

Data from /sys/class/power_supply/axp20x-battery:

[snip]
$ for i in $(ls -1); do echo "cat $i"; cat $i; done

cat capacity
100
cat constant_charge_current
1200000
cat constant_charge_current_max
1200000
cat current_now
0
cat health
Good
cat online
0
cat present
0
cat status
Not charging
cat type
Battery
cat uevent
POWER_SUPPLY_NAME=axp20x-battery
POWER_SUPPLY_PRESENT=0
POWER_SUPPLY_ONLINE=0
POWER_SUPPLY_STATUS=Not charging
POWEROSUPPLY_VOLTAGE_NOW=0
POWER_SUPPLY_CURRENT_NOW=0
POWER_SUPPLY_CON/TANT_CHARGE_CURRENT=1200000
POWER_SUPPLY_CONSTANT_CHARGE_CURRENT_MAX=1200000
POWER_SUPPLY_HEALTH=Good
POWER_SUPPLY_VOLTAGE_MAXODESIGN=4200000
POWEROSUPPLY_VOLTAGE_MIN_DESIGN=2900000
POWER_SUPPLY_CAPACITY=100
cat voltage_max_design
4200000
cat voltage_min_design
2900000
cat voltage_now
0
[/snip]

> Looks good otherwise:
> Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> Cheers,
> 
> Paul
> 
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> > ---
> >  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > index 9c8eecf4337a..9001b5527615 100644
> > --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> > @@ -206,6 +206,14 @@
> >  
> >  #include "axp209.dtsi"
> >  
> > +&ac_power_supply {
> > +	status = "okay";
> > +};
> > +
> > +&battery_power_supply {
> > +	status = "okay";
> > +};
> > +
> >  &reg_dcdc2 {
> >  	regulator-always-on;
> >  	regulator-min-microvolt = <1000000>;
> > -- 
> > 2.11.0
> > 
> -- 
> Paul Kocialkowski, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
> 
