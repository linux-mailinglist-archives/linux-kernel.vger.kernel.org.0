Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF7DE4FF16
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 04:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfFXCId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 22:08:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbfFXCId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:08:33 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DECD20679;
        Mon, 24 Jun 2019 02:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561342112;
        bh=44wBvcD8d69VIm5qFHtpW6IT0vLvVy7DqP9Th9ykY9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8Bl+LZLlB6Bvs6e6KOlFb3THQrGsEArVY0SKfD3f+p/3aA373sukqDA8FXWzVrLS
         ooDICgBZUVxLPXctTGZEUuuij1HvCn908C7v/KbENJoggsF7mkoV8sg+CbjtE6BMVG
         liMdFIxdgPE5Gid21A2sYsB6FyaFfzu3bbIC4dQ0=
Date:   Mon, 24 Jun 2019 10:08:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: fsl: librem5: Limit the USB to 5V
Message-ID: <20190624020815.GK3800@dragon>
References: <20190620170439.18762-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620170439.18762-1-angus@akkea.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 11:04:39AM -0600, Angus Ainslie (Purism) wrote:
> The charge controller can handle 14V but the PTC on the devkit can only
> handle 6V so limit the negotiated voltage to 5V.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Prefix 'arm64: dts: librem5: ...' should be fine, so I changed it and
applied the patch.

Shawn

> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index 3f4736fd3cea..ec85ada77955 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -353,7 +353,7 @@
>  			sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM |
>  				PDO_FIXED_DUAL_ROLE |
>  				PDO_FIXED_DATA_SWAP )
> -			     PDO_VAR(5000, 12000, 2000)>;
> +			     PDO_VAR(5000, 3000, 3000)>;
>  			op-sink-microwatt = <10000000>;
>  
>  			ports {
> -- 
> 2.17.1
> 
