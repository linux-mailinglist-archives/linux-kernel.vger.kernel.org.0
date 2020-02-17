Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50003160974
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 05:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBQEIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 23:08:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgBQEIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 23:08:11 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13B3E20717;
        Mon, 17 Feb 2020 04:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581912491;
        bh=/Mqu27AqpB+4XNsWQu4dQ/bmhKfjD2lKSZW9AtQdLNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0X1NwE765Ub3qnrKRRSMBdMh6b+IrmisUUjmapkAPtZ0fKmIpwoxdlwfjAd78nyAx
         3tGluL3tCh7z5j5q34VymWTX1y2PhlzNRTMb8beorMlewFHdlRBpcET0W2ocPm2qP7
         6iRGZ3ohRwpEEaNzD+3Eou4+QRdsV2GFyPWAkx7U=
Date:   Mon, 17 Feb 2020 12:08:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, devicetree@vger.kernel.org, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: Re: [PATCH v1 07/12] arm64: dts: librem5-devkit: add the regulators
 for DVFS
Message-ID: <20200217040801.GF5395@dragon>
References: <20200205143003.28408-1-martin.kepplinger@puri.sm>
 <20200205143003.28408-8-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205143003.28408-8-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 03:29:58PM +0100, Martin Kepplinger wrote:
> From: "Angus Ainslie (Purism)" <angus@akkea.ca>
> 
> Specify which regulator is used for cpufreq DVFS.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  .../dts/freescale/imx8mq-librem5-devkit.dts   | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index ac0145839a69..6a8f6cee96cf 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -223,6 +223,26 @@
>  	};
>  };
>  
> +&A53_0 {
> +	operating-points-v2 = <&a53_opp_table>;

The property has already been set in imx8mq.dtsi.

Shawn

> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&A53_1 {
> +	operating-points-v2 = <&a53_opp_table>;
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&A53_2 {
> +	operating-points-v2 = <&a53_opp_table>;
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&A53_3 {
> +	operating-points-v2 = <&a53_opp_table>;
> +	cpu-supply = <&buck2_reg>;
> +};
> +
>  &clk {
>  	assigned-clocks = <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_PLL2>;
>  	assigned-clock-rates = <786432000>, <722534400>;
> -- 
> 2.20.1
> 
