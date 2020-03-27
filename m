Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C99E195496
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 10:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgC0J60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 05:58:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45177 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgC0J60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:58:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id t7so10585510wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 02:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bcArWLKO9gfS9yL0ZKsjHCpsyjSMPm/VjOI4JkSoq3E=;
        b=GpPQrDbw/IAnWIIEIIEqlGvJ5p9qqvos443bO3SjGfFlqI5ayDKJICbICXHECKygIX
         8kUA1/dtP53vDcyhoKuwd1ySYMH8Gunv3rzIz+q+3EEP9dOpoRJUknnJzSo2CgdA9OBt
         g8zW3peo9OrCsNNvmllmzqKa5jqD/O1+5OBjBV9YpSv251uZo/9Y/B1BGVs9oSmKdiXb
         Z32JnGiS6duI/3g1nXMWffY6jpbFe6q0YmwotUWYRp88OxYstP9uS3V0u+RczDTho2cg
         B1fcf27IDtmm1ZZ2ijilv89Kxl4FavPiiKtfefsMcoc00bBntzClc9svrFbckvjF6g6Z
         zYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bcArWLKO9gfS9yL0ZKsjHCpsyjSMPm/VjOI4JkSoq3E=;
        b=sxhYp09YAm9Ede2e5294V9w1aPkkZeYsqimn2/L2t5cKhc43l8eJjRNcvtYOIMratF
         1nyLOifG9x9fiOpoZieyzXHh87a5qgZ6tTpek7kiW9aUVqu5ZQbZpiJvmQOSNpHYWXnt
         BLZIyHO3b/PKME2pIgbNujHVfH5gzYuK18DLMt+Bh7796LF/0q0nc3VUQVaB2hxYsrq+
         Sbc0dKjVcdotp7wNamNM+X+FKRDFaYx3GmNcrvyYRyJcFko0cMkSQA4I6hYCrJY7p2VE
         gfTMwfr/Wvt4R1XDudJ6I9Fe+dUuZhIseuXuKmMryKWR2vaOvTYFotuSDPrlRUINMCg8
         Ec3w==
X-Gm-Message-State: ANhLgQ0EHboUNDuIuQnr3zw87K8/uYTw9S2RXuxn3HkHTz+7N3d6ycNA
        R3jUeSXygKipqm+AejHy50XQfOFY
X-Google-Smtp-Source: ADFU+vvKZfMOqNUJZ4uhISq6XNpwcMVRpDU3ieIyScDuSXDwquFHmAA9qExS6vclylLaSiMNsr4rkA==
X-Received: by 2002:adf:a55b:: with SMTP id j27mr5645578wrb.418.1585303103675;
        Fri, 27 Mar 2020 02:58:23 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i4sm7826034wrm.32.2020.03.27.02.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 02:58:23 -0700 (PDT)
To:     wens@kernel.org
Cc:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, wens@csie.org
References: <20200327030414.5903-2-wens@kernel.org>
Subject: Re: [PATCH 1/6] arm64: dts: rockchip: rk3399-roc-pc: Fix MMC
 numbering for LED triggers
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <684a08e6-7dfe-4cb1-2ae5-c1fb4128976b@gmail.com>
Date:   Fri, 27 Mar 2020 10:58:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200327030414.5903-2-wens@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu Tsai,

The led node names need some changes.
'linux,default-trigger' value does not fit.

From leds-gpio.yaml:

patternProperties:
  # The first form is preferred, but fall back to just 'led' anywhere in the
  # node name to at least catch some child nodes.
  "(^led-[0-9a-f]$|led)":
    type: object

Rename led nodenames to 'led-0' form

Also include all mail lists found with:
./scripts/get_maintainer.pl --nogit-fallback --nogit

devicetree@vger.kernel.org

If you like change the rest of dts with leds as well...

  DTC     arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dt.yaml
  CHECK   arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dt.yaml
arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dt.yaml: leds:
yellow-led:linux,default-trigger:0: 'mmc0' is not one of ['backlight',
'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dt.yaml: leds:
diy-led:linux,default-trigger:0: 'mmc1' is not one of ['backlight',
'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
  DTC     arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml
  CHECK   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml
arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml: leds:
diy-led:linux,default-trigger:0: 'mmc2' is not one of ['backlight',
'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dt.yaml: leds:
yellow-led:linux,default-trigger:0: 'mmc1' is not one of ['backlight',
'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']

make -k ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/leds/leds-gpio.yaml

> From: Chen-Yu Tsai <wens@csie.org>
> 
> With SDIO now enabled, the numbering of the existing MMC host controllers
> gets incremented by 1, as the SDIO host is the first one.
> 
> Increment the numbering of the MMC LED triggers to match.
> 
> Fixes: cf3c5397835f ("arm64: dts: rockchip: Enable sdio0 and uart0 on rk3399-roc-pc-mezzanine")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts | 8 ++++++++
>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi          | 4 ++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
> index 2acb3d500fb9..f0686fc276be 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
> @@ -38,6 +38,10 @@ vcc3v3_pcie: vcc3v3-pcie {
>  	};
>  };
>  
> +&diy_led {
> +	linux,default-trigger = "mmc2";
> +};
> +
>  &pcie_phy {
>  	status = "okay";
>  };
> @@ -91,3 +95,7 @@ &uart0 {
>  	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
>  	status = "okay";
>  };
> +
> +&yellow_led {
> +	linux,default-trigger = "mmc1";
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> index 9f225e9c3d54..bc060ac7972d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> @@ -70,14 +70,14 @@ work-led {
>  			linux,default-trigger = "heartbeat";
>  		};
>  
> -		diy-led {
> +		diy_led: diy-led {
>  			label = "red:diy";
>  			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  			linux,default-trigger = "mmc1";
>  		};
>  
> -		yellow-led {
> +		yellow_led: yellow-led {
>  			label = "yellow:yellow-led";
>  			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
> -- 
> 2.25.1

