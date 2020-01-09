Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3A2135415
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 09:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgAIIGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 03:06:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbgAIIGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:06:12 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AD092072E;
        Thu,  9 Jan 2020 08:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578557171;
        bh=frNZUoA+Js9y3eU3kSR8bgFjwgkS8/kuonlvihAjvSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xBzTtAbqVqwWdnLfufSeO/2oD0lXsmooGNSAkKrGGsuS9kgdh7wr5AtP4gvTt3wfS
         jHRPs2tIVoDk3dn73pXnetxFjVD+BZ+I4rkE/d7JRC/hJ3g6BXcNRB10m5Oyv97k2k
         An0CEXzsb6W8Xv02Uvn/qPtBhvTSFB1tKHzCaDBE=
Date:   Thu, 9 Jan 2020 16:06:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/5] ARM: dts: imx6qdl-sabresd: Remove incorrect power
 supply assignment
Message-ID: <20200109080600.GH4456@T480>
References: <1577670071-1322-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577670071-1322-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 09:41:07AM +0800, Anson Huang wrote:
> The vdd3p0's input should be from external USB VBUS directly, NOT

Shouldn't USB VBUS usually be 5V?  It doesn't seem to match 3.0V which
is suggested by vdd3p0 name.

> PMIC's sw2, so remove the power supply assignment for vdd3p0.
> 
> Fixes: 93385546ba36 ("ARM: dts: imx6qdl-sabresd: Assign corresponding power supply for LDOs")

Is it only a description correcting or is it fixing a real problem?  I'm
trying to understand it is a 5.5-rc material or can be applied for 5.6.

Shawn

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 71ca76a..fe59dde 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -749,10 +749,6 @@
>  	vin-supply = <&vgen5_reg>;
>  };
>  
> -&reg_vdd3p0 {
> -	vin-supply = <&sw2_reg>;
> -};
> -
>  &reg_vdd2p5 {
>  	vin-supply = <&vgen5_reg>;
>  };
> -- 
> 2.7.4
> 
