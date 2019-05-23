Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0076128774
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 21:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389854AbfEWTTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 15:19:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42063 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388671AbfEWTTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:19:33 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6A162803D0; Thu, 23 May 2019 21:19:21 +0200 (CEST)
Date:   Thu, 23 May 2019 21:19:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 2/4] arm64: dts: fsl: librem5: Add a device tree for
 the Librem5 devkit
Message-ID: <20190523191922.GA3803@xo-6d-61-c0.localdomain>
References: <20190520142330.3556-1-angus@akkea.ca>
 <20190520142330.3556-3-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520142330.3556-3-angus@akkea.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is for the development kit board for the Librem 5. The current level
> of support yields a working console and is able to boot userspace from
> the network or eMMC.
> 
> Additional subsystems that are active :

> - haptic motor

Haptic motor is not a LED. It should be controlled by input subsystem.

> +	pwmleds {
> +		compatible = "pwm-leds";
> +
> +		haptic {
> +			label = "librem5::haptic";
> +			pwms = <&pwm2 0 200000>;
> +			active-low;
> +			max-brightness = <255>;
> +			power-supply = <&reg_3v3_p>;
> +		};
> +	};

You can take a look at N900, that has reasonable interface.

Thanks,
										Pavel
