Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254CA1166E1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 07:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfLIGYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 01:24:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfLIGYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:24:53 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB27C206D3;
        Mon,  9 Dec 2019 06:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575872693;
        bh=NvleXuUnPknYKUhTVZzMMKvbLBOUqsyyrdsMf7qmcsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBW1x5yG8jYDoDPIRBN/OWZV1Y616bQ2ge84/I4SZA1MT5dD/LkqCrpWb6+r3YqVS
         X7uvQlQGiMSa0xtCmmRn3jcm3kG3w3mGSo3bJSdg2Vs0bbrJIfkJxvodbwkEogTq0x
         eVjzuPHoyqAblOE3sWjuo6J33uY2L8uNHYy+1QaU=
Date:   Mon, 9 Dec 2019 14:24:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>, Yuantian Tang <andy.tang@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/4] arm64: dts: ls1028a: fix typo in TMU calibration data
Message-ID: <20191209062436.GB3365@dragon>
References: <20191123201317.25861-1-michael@walle.cc>
 <20191123201317.25861-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191123201317.25861-2-michael@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Yuantian Tang, who is the author of existing code.

On Sat, Nov 23, 2019 at 09:13:14PM +0100, Michael Walle wrote:
> This was tested on a custom board.

Can you add more info about why this is an error and how it is being
identified?

Shawn

> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index dc75534a4754..f2e71fd57b20 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -573,7 +573,7 @@
>  					       0x00010004 0x0000003d
>  					       0x00010005 0x00000045
>  					       0x00010006 0x0000004d
> -					       0x00010007 0x00000045
> +					       0x00010007 0x00000055
>  					       0x00010008 0x0000005e
>  					       0x00010009 0x00000066
>  					       0x0001000a 0x0000006e
> -- 
> 2.20.1
> 
