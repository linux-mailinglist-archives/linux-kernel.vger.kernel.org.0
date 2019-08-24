Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475CD9BFBA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 21:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfHXTJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 15:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbfHXTJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 15:09:16 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B3062146E;
        Sat, 24 Aug 2019 19:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566673755;
        bh=GqVf24z8FxhvMhEfTsWDTwhTbtkDygR3jTkJ+Klid5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdcECoyPaKDSaTdLtZBsxyHlR6m24VsZiObIMIq7WDlGLL7vLqN8E40yIp/P+u/cy
         2Z6tShiR84e4Jkt2NAodJjVx7JCTMfOErMfsegRgmL8x08HqXrwsvtPxoez+Iv/tn8
         aMhJotZAGSZp4wVZhrPjXusQ46KnSNbFDZOFSiR0=
Date:   Sat, 24 Aug 2019 21:09:04 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: vf610-zii-scu4-aib: Drop "rs485-rts-delay"
 property
Message-ID: <20190824190903.GC16308@X250.getinternet.no>
References: <20190820031301.11172-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820031301.11172-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 08:13:01PM -0700, Andrey Smirnov wrote:
> LPUART driver does not support specifying "rs485-rts-delay"
> property. Drop it.

If so, we need to fix bindings/serial/fsl-lpuart.txt in the meantime?

Shawn

> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> index 666ec27a73e3..d8c38ef6a98a 100644
> --- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> +++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> @@ -685,7 +685,6 @@
>  	linux,rs485-enabled-at-boot-time;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> -	rs485-rts-delay = <0 200>;
>  	status = "okay";
>  };
>  
> @@ -693,7 +692,6 @@
>  	linux,rs485-enabled-at-boot-time;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart2>;
> -	rs485-rts-delay = <0 200>;
>  	status = "okay";
>  };
>  
> -- 
> 2.21.0
> 
