Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1BD49BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 10:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfFRIV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 04:21:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59686 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRIV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:21:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5AE0D2813A9
Subject: Re: [PATCH] Revert "ARM: dts: rockchip: set PWM delay backlight
 settings for Minnie"
To:     Matthias Kaehlcke <mka@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Douglas Anderson <dianders@chromium.org>
References: <20190614224533.169881-1-mka@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <45f94c6a-5bd7-92b0-d23f-ae7e0481935f@collabora.com>
Date:   Tue, 18 Jun 2019 10:21:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190614224533.169881-1-mka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 15/6/19 0:45, Matthias Kaehlcke wrote:
> This reverts commit 288ceb85b505c19abe1895df068dda5ed20cf482.
> 
> According to the commit message the AUO B101EAN01 panel on minnie
> requires a PWM delay of 200 ms, however this is not what the
> datasheet says. The datasheet mentions a *max* delay of 200 ms
> for T2 ("delay from LCDVDD to black video generation") and T3
> ("delay from LCDVDD to HPD high"), which aren't related to the
> PWM. The backlight power sequence does not specify min/max
> constraints for T15 (time from PWM on to BL enable) or T16
> (time from BL disable to PWM off).
> 

Could you point from where the confusion comes from? I think will be helpful for
the record. B101EAN01.8 vs B101EAN01.1

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

With the above added:

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
~ Enric

> ---
> Enric, if you think I misinterpreted the datasheet please holler!
> ---
>  arch/arm/boot/dts/rk3288-veyron-minnie.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> index 468a1818545d..28cbe07f96ec 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> @@ -86,8 +86,6 @@
>  			240 241 242 243 244 245 246 247
>  			248 249 250 251 252 253 254 255>;
>  	power-supply = <&backlight_regulator>;
> -	post-pwm-on-delay-ms = <200>;
> -	pwm-off-delay-ms = <200>;
>  };
>  
>  &emmc {
> 
