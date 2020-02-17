Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B90BE160CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 09:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgBQIUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 03:20:52 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41755 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbgBQIUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:20:52 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1j3be4-0003zu-Ea; Mon, 17 Feb 2020 09:20:48 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1j3be3-00025k-IT; Mon, 17 Feb 2020 09:20:47 +0100
Date:   Mon, 17 Feb 2020 09:20:47 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Alifer Moraes <alifer.wsdm@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, peng.fan@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, leonard.crestez@nxp.com,
        festevam@gmail.com
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios for fec1
Message-ID: <20200217082047.nzxxo7mpejq5yj65@pengutronix.de>
References: <20200214192750.20845-1-alifer.wsdm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214192750.20845-1-alifer.wsdm@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:19:43 up 93 days, 23:38, 104 users,  load average: 0.30, 0.22,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-02-14 16:27, Alifer Moraes wrote:
> imx8mm-evk has a GPIO connected to AR8031 Ethernet PHY's reset pin.
> 
> Describe it in the device tree, following phy's datasheet reset duration of 10ms.
> 
> Tested booting via NFS.
> 
> Signed-off-by: Alifer Moraes <alifer.wsdm@gmail.com>
> ---
> 
> Originally sent by Peng Fan <peng.fan@nxp.com>
> 
> Back then CONFIG_AT803X_PHY was set as "m" in defconfig so the boot process hung
> at nfs boot, now that CONFIG_AT803X_PHY is set as "y" by default, the patch works
> correctly.
> 
> Peng's original patch missed to pass the phy-reset-duration, according to the AR8031
> datasheet the reset GPIO needs to stay low for 10ms.
> 
> Original thread: https://lkml.org/lkml/2019/10/21/347
> 
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> index 28ab17a277bb..11903ca86f0e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> @@ -82,6 +82,8 @@
>  	pinctrl-0 = <&pinctrl_fec1>;
>  	phy-mode = "rgmii-id";
>  	phy-handle = <&ethphy0>;
> +	phy-reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;

Where is this gpio muxed?

Regards,
  Marco

> +	phy-reset-duration = <10>;
>  	fsl,magic-packet;
>  	status = "okay";
>  
> -- 
> 2.17.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
