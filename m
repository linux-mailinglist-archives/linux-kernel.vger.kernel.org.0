Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 143A9A5D1F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 22:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfIBUbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 16:31:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49121 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfIBUbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 16:31:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6836A82130; Mon,  2 Sep 2019 22:31:31 +0200 (CEST)
Date:   Mon, 2 Sep 2019 22:31:44 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mn-ddr4-evk: Enable GPIO LED
Message-ID: <20190902203144.GA4787@bug>
References: <1567457138-3002-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567457138-3002-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-09-02 16:45:38, Anson Huang wrote:
> i.MX8MN DDR4 EVK board has a GPIO LED to indicate status,
> add support for it.

LED maintainers want to be on the cc list...

> @@ -15,6 +15,18 @@
>  		stdout-path = &uart2;
>  	};
>  
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_led>;
> +
> +		status {
> +			label = "status";
> +			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +		};

And we should really standardize labels for user-controlled status LEDs. Mentioning
color would be nice, for a start.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
