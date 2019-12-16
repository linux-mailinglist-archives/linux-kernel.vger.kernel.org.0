Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA29120F66
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 17:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfLPQ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 11:27:27 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:43148 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLPQ11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:27:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 4D5C5FB03;
        Mon, 16 Dec 2019 17:27:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sZtjjrcIejdo; Mon, 16 Dec 2019 17:27:24 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 92F69498AE; Mon, 16 Dec 2019 17:27:23 +0100 (CET)
Date:   Mon, 16 Dec 2019 17:27:23 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        kernel@puri.sm, linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: imx8mq-librem5-devkit: add accelerometer and
 gyro sensor
Message-ID: <20191216162723.GA23173@bogon.m.sigxcpu.org>
References: <20191203130336.18763-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191203130336.18763-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Dec 03, 2019 at 02:03:36PM +0100, Martin Kepplinger wrote:
> Now that there is driver support, describe the accel and gyro sensor parts
> of the LSM9DS1 IMU.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index 683a11035643..7a92704c53ec 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -415,6 +415,13 @@
>  	pinctrl-0 = <&pinctrl_i2c3>;
>  	status = "okay";
>  
> +	accel_gyro@6a {
> +		compatible = "st,lsm9ds1-imu";
> +		reg = <0x6a>;
> +		vdd-supply = <&reg_3v3_p>;
> +		vddio-supply = <&reg_3v3_p>;
> +	};
> +

Reviewed-by: Guido G�nther <agx@sigxcpu.org>
 -- Guido

>  	magnetometer@1e	{
>  		compatible = "st,lsm9ds1-magn";
>  		reg = <0x1e>;
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
