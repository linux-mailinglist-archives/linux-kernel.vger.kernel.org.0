Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A521516AD3A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 18:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgBXRXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 12:23:33 -0500
Received: from vps.xff.cz ([195.181.215.36]:60214 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbgBXRXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582565008; bh=bd4Uuy+8NdF8pyhX5zAyIND0GOYY5+tfdsLIGI0STkY=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=h1RRqRCRYXFCxoDJO6jPP6II2ps9oswey4T2PFiwvq2vrZbVBQg2rrJiJzV7Xyk4r
         kNPRhzIQeeePwaujC76aAlQCVufqcsuTc9SYASpY8Uj1FJxVnoc3Aim4E1c8LyGl97
         GLzrudZoPO8yo1w/G52Ig9+sYovPq+/rJoTbsdrA=
Date:   Mon, 24 Feb 2020 18:23:28 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: dts: sun8i-a83t: Add thermal trip points/cooling
 maps
Message-ID: <20200224172328.yauwfgov664ayrd6@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200224165417.334617-1-megous@megous.com>
 <2e4213a6-2aaf-641c-f741-9503f3ffd5fe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e4213a6-2aaf-641c-f741-9503f3ffd5fe@linaro.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On Mon, Feb 24, 2020 at 06:06:20PM +0100, Daniel Lezcano wrote:
> On 24/02/2020 17:54, Ondrej Jirman wrote:
> > This enables passive cooling by down-regulating CPU voltage
> >  			clocks = <&ccu CLK_C1CPUX>;
> > @@ -1188,12 +1188,60 @@ cpu0_thermal: cpu0-thermal {
> >  			polling-delay-passive = <0>;
> >  			polling-delay = <0>;
> >  			thermal-sensors = <&ths 0>;
> > +
> > +			trips {
> > +				cpu0_hot: cpu-hot {
> > +					temperature = <80000>;
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> > +
> > +				cpu0_very_hot: cpu-very-hot {
> > +					temperature = <100000>;
> > +					hysteresis = <0>;
> > +					type = "critical";
> > +				};
> > +			};
> > +
> > +			cooling-maps {
> > +				cpu-hot-limit {
> > +					trip = <&cpu0_hot>;
> > +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +				};
> > +			};
> >  		};
> >  
> >  		cpu1_thermal: cpu1-thermal {
> >  			polling-delay-passive = <0>;
> 
> No polling to mitigate?

Polling to mitigate what?

The driver is using interrupts whenever new reading is available, and
notifies tz of the change. I don't have a reason to believe any new
values are available from thermal sensor outside of the interrupt
period.

> >  			polling-delay = <0>;
> >  			thermal-sensors = <&ths 1>;
> > +
> > +			trips {
> > +				cpu1_hot: cpu-hot {
> > +					temperature = <80000>;
> > +					hysteresis = <2000>;
> > +					type = "passive";
> 
> I'm curious, can you really reach this temperature with a cortex-a7
> running at 1.2GHz max?

That depends on ambient temperature. I'd say easily. My A83T is running
iniside enclosed space with no cooling other than dissipating heat to
the board.

Anyway, I'm running my A83T boards at 1.8GHz. And A83T can run up to 2GHz
at the best SoC bin.

I'll probably submit updated cpufreq table at some point too, once I fix
it up to use the SoC bin information.

https://megous.com/git/linux/commit/?h=ths-5.6&id=171b7c3c3db98b5939d28d0c96b384edda95cec3

regards,
	o.

> > +				};
> > +
> > +				cpu1_very_hot: cpu-very-hot {
> > +					temperature = <100000>;
> > +					hysteresis = <0>;
> > +					type = "critical";
> > +				};
> > +			};
> > +
> > +			cooling-maps {
> > +				cpu-hot-limit {
> > +					trip = <&cpu1_hot>;
> > +					cooling-device = <&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +							 <&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +							 <&cpu102 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +							 <&cpu103 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +				};
> > +			};
> >  		};
> >  
> >  		gpu_thermal: gpu-thermal {
> > 
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
