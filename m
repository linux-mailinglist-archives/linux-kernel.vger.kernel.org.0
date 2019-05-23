Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0541228CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 23:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbfEWVw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 17:52:58 -0400
Received: from node.akkea.ca ([192.155.83.177]:49564 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387709AbfEWVw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:52:57 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id EE1D44E204B; Thu, 23 May 2019 21:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558648376; bh=EEx6+r+EW8Gn9LAjThkYPyrhI3Zs+zGHNmTtqinmKv4=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=lydjv4HV77oK6COWSrTB1aH1fzxQCpWZn3f9c5YJdUPbwSs9j4jrs+wewljakLQ7n
         SuVyaPb07lQ5iHRWYIVaoMcXhR2PcSdEsn9Gj4eL9enTjgl4octPYeaEFmGc7eJJ+x
         uVBAjCgayvFpSuhgomr0JoIhmwvSb+a0fFBEHF90=
To:     Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v13 2/4] arm64: dts: fsl: librem5: Add a device tree for  the Librem5 devkit
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 23 May 2019 14:52:56 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
In-Reply-To: <20190523191922.GA3803@xo-6d-61-c0.localdomain>
References: <20190520142330.3556-1-angus@akkea.ca>
 <20190520142330.3556-3-angus@akkea.ca>
 <20190523191922.GA3803@xo-6d-61-c0.localdomain>
Message-ID: <9626cd324eaaab2b49c37cf3c824aa5e@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,


On 2019-05-23 12:19, Pavel Machek wrote:
> Hi!
> 
>> This is for the development kit board for the Librem 5. The current 
>> level
>> of support yields a working console and is able to boot userspace from
>> the network or eMMC.
>> 
>> Additional subsystems that are active :
> 
>> - haptic motor
> 
> Haptic motor is not a LED. It should be controlled by input subsystem.
> 
>> +	pwmleds {
>> +		compatible = "pwm-leds";
>> +
>> +		haptic {
>> +			label = "librem5::haptic";
>> +			pwms = <&pwm2 0 200000>;
>> +			active-low;
>> +			max-brightness = <255>;
>> +			power-supply = <&reg_3v3_p>;
>> +		};
>> +	};
> 
> You can take a look at N900, that has reasonable interface.
> 

I wanted to control the haptic with the pwm-vibra driver but 
"fsl,imx27-pwm" doesn't seem to respect the PWM_POLARITY_INVERTED flag 
so when I start the system the vibrator is full on.

I could use gpio-vibrator but that seemed like a waste when the device 
is connected to pwm.

I figured the using the pwm-leds interface was a reasonable compromise 
until I had an opportunity to make changes the the imx27-pwm driver.

Thanks
Angus


> Thanks,
> 										Pavel

