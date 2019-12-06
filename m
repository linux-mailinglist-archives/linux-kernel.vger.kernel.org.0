Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92DBA115958
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 23:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfLFWcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 17:32:23 -0500
Received: from gloria.sntech.de ([185.11.138.130]:44886 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfLFWcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:32:23 -0500
Received: from p57b772b2.dip0.t-ipconnect.de ([87.183.114.178] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1idM90-0004jn-SN; Fri, 06 Dec 2019 23:32:14 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Schultz <d.schultz@phytec.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv1 0/8] RK3399 clean shutdown issue
Date:   Fri, 06 Dec 2019 23:32:14 +0100
Message-ID: <1765889.rfqrfT1PbY@phil>
In-Reply-To: <20191206184536.2507-1-linux.amoon@gmail.com>
References: <20191206184536.2507-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

Am Freitag, 6. Dezember 2019, 19:45:28 CET schrieb Anand Moon:
> Most of the RK3399 SBC boards do not perform clean
> shutdown and clean reboot.
> 
> These patches try to help resolve the issue with proper
> shutdown by turning off the PMIC.
> 
> For reference 
> RK805 PMCI data sheet:
> [0] http://rockchip.fr/RK805%20datasheet%20V1.3.pdf
> RK808 PMIC data sheet:
> [1] http://rockchip.fr/RK808%20datasheet%20V1.4.pdf
> RK817 PMIC data sheet:
> [2] http://rockchip.fr/RK817%20datasheet%20V1.01.pdf 
> RK818 PMIC data sheet:
> [3] http://rockchip.fr/RK818%20datasheet%20V1.0.pdf
> 
> Reboot issue:
> My guess is that we need to some proper sequence of
> setting to PMCI to perform clean.
> 
> If you have any input please share them.

The rk8xx pmics may not on all devices be responsible for powering down
the device. That is what the system-power-controller dt-property is for.

So that property is there for a reason - to indicate that the pmic is
responsible for power-off-handling.

Heiko

> Tested on SBC
> Rock960 Model A
> Odroid N1
> Rock64
> 
> -Anand Moon
> 
> Anand Moon (8):
>   mfd: rk808: Refactor shutdown functions
>   mfd: rk808: use syscore for RK805 PMIC shutdown
>   mfd: rk808: use syscore for RK808 PMIC shutdown
>   mfd: rk808: use syscore for RK818 PMIC shutdown
>   mfd: rk808: cleanup unused function pointer
>   mfd: rk808: use common syscore for all PMCI for clean shutdown
>   arm64: rockchip: drop unused field from rk8xx i2c node
>   arm: rockchip: drop unused field from rk8xx i2c node
> 
>  arch/arm/boot/dts/rk3036-kylin.dts            |   1 -
>  arch/arm/boot/dts/rk3188-px3-evb.dts          |   1 -
>  arch/arm/boot/dts/rk3288-evb-rk808.dts        |   1 -
>  arch/arm/boot/dts/rk3288-phycore-som.dtsi     |   1 -
>  arch/arm/boot/dts/rk3288-popmetal.dts         |   1 -
>  arch/arm/boot/dts/rk3288-tinker.dtsi          |   1 -
>  arch/arm/boot/dts/rk3288-veyron.dtsi          |   1 -
>  arch/arm/boot/dts/rk3288-vyasa.dts            |   1 -
>  arch/arm/boot/dts/rv1108-elgin-r1.dts         |   1 -
>  arch/arm/boot/dts/rv1108-evb.dts              |   1 -
>  arch/arm64/boot/dts/rockchip/px30-evb.dts     |   1 -
>  arch/arm64/boot/dts/rockchip/rk3328-a1.dts    |   1 -
>  arch/arm64/boot/dts/rockchip/rk3328-evb.dts   |   1 -
>  .../arm64/boot/dts/rockchip/rk3328-roc-cc.dts |   1 -
>  .../arm64/boot/dts/rockchip/rk3328-rock64.dts |   1 -
>  .../boot/dts/rockchip/rk3368-geekbox.dts      |   1 -
>  arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi |   1 -
>  .../boot/dts/rockchip/rk3368-px5-evb.dts      |   1 -
>  .../boot/dts/rockchip/rk3399-firefly.dts      |   1 -
>  .../boot/dts/rockchip/rk3399-hugsun-x99.dts   |   1 -
>  .../boot/dts/rockchip/rk3399-khadas-edge.dtsi |   1 -
>  .../boot/dts/rockchip/rk3399-leez-p710.dts    |   1 -
>  .../boot/dts/rockchip/rk3399-nanopi4.dtsi     |   1 -
>  .../boot/dts/rockchip/rk3399-orangepi.dts     |   1 -
>  arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi |   1 -
>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      |   1 -
>  .../boot/dts/rockchip/rk3399-rock-pi-4.dts    |   1 -
>  .../boot/dts/rockchip/rk3399-rock960.dtsi     |   1 -
>  .../boot/dts/rockchip/rk3399-rockpro64.dts    |   1 -
>  .../boot/dts/rockchip/rk3399-sapphire.dtsi    |   1 -
>  drivers/mfd/rk808.c                           | 144 +++++-------------
>  include/linux/mfd/rk808.h                     |   2 -
>  32 files changed, 42 insertions(+), 134 deletions(-)
> 
> 




