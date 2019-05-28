Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44CBC2C730
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 15:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfE1NAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 09:00:20 -0400
Received: from node.akkea.ca ([192.155.83.177]:43840 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbfE1NAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:00:20 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id C5BEC4E204B; Tue, 28 May 2019 13:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1559048419; bh=DuNG9eraJBekzRo7JMy/lt3azKRg+Ejt3Pynd/LUpQw=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=Gcq2zKVu0wYuEKx1clJT+CFI/Qm8Qg193Gq70Ah2BlMkn2oz/I6TTnc0xhDdkNjT2
         oVS0ni69EfFkHZcePiIwstfo+zNZOlrY23KjNmj0tM5GctNlBJKiLCFEZVHRwwS7pb
         2Bh+KPihajSNbxME+mHygXhqiDjAT7m7klszc4Sk=
To:     Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: fsl: imx8mq: enable the svns power key
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 28 May 2019 06:00:19 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1559047905.4039.15.camel@pengutronix.de>
References: <20190528124406.29730-1-angus@akkea.ca>
 <1559047905.4039.15.camel@pengutronix.de>
Message-ID: <9a2361a08a0b8a1be1e2f5921026661f@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

On 2019-05-28 05:51, Lucas Stach wrote:
> Hi Angus,
> 
> Am Dienstag, den 28.05.2019, 05:44 -0700 schrieb Angus Ainslie 
> (Purism):
>> Add the snvs power key.
>> 
>> > Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi 
>> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> index 45d10d8efd14..5f93fd9662ae 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> @@ -8,6 +8,7 @@
>>  #include <dt-bindings/power/imx8mq-power.h>
>>  #include <dt-bindings/reset/imx8mq-reset.h>
>>  #include <dt-bindings/gpio/gpio.h>
>> +#include "dt-bindings/input/input.h"
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/thermal/thermal.h>
>>  #include "imx8mq-pinfunc.h"
>> @@ -463,6 +464,14 @@
>> >  					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
>> >  						<GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
>> >  				};
>> +
>> > +				snvs_pwrkey: snvs-powerkey {
>> > +					compatible = "fsl,sec-v4.0-pwrkey";
>> > +					regmap = <&snvs>;
>> > +					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>> > +					linux,keycode = <KEY_POWER>;
>> +					wakeup-source;
> 
> Not all i.MX8MQ systems will have this functionality wired up at the
> board level, so this node needs to be disabled by default. The existing
>  i.MX6 and i.MX7 DTs seem to get this wrong.
> 

Ok I'll fix that for the next rev.

Thanks
Angus

> Regards,
> Lucas
> 
>> +				};
>> >  			};
>>  
>> > >  			clk: clock-controller@30380000 {

