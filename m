Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F599BFBE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 21:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfHXTMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 15:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfHXTMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 15:12:01 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C2F62146E;
        Sat, 24 Aug 2019 19:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566673920;
        bh=ezRY8yYFMypgLFWgx+5OQQJxcoy3QEXmesB47+8ufzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6v4/aZ+ImZd7NTE9+8wGYp6+Ps1oERNv9g0DBYUKSmqeyANYjh+q8GYRn9VmWxRI
         WamiIPkAYvjySRwulOd3fFY7ApE64dmacMO/3cbtc4MvteMINBl7J5JH1ipjaYTqi7
         SZvTgcwwaItZ1R2EgJMubnmX7ddWXBQI+du0YsPg=
Date:   Sat, 24 Aug 2019 21:11:49 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: vf610-zii-dev-rev-b: Drop redundant I2C
 properties
Message-ID: <20190824191148.GD16308@X250.getinternet.no>
References: <20190820031952.14804-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820031952.14804-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 08:19:52PM -0700, Andrey Smirnov wrote:
> Drop redundant I2C properties that are already specified in
> vf610-zii-dev.dtsi
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> index 48086c5e8549..e500911ce0a5 100644
> --- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> +++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
> @@ -323,11 +323,6 @@
>  };
>  
>  &i2c0 {
> -	clock-frequency = <100000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_i2c0>;

pinctrl for i2c0 is not same as what vf610-zii-dev.dtsi has.

Shawn

> -	status = "okay";
> -
>  	gpio5: io-expander@20 {
>  		compatible = "nxp,pca9554";
>  		reg = <0x20>;
> @@ -350,11 +345,6 @@
>  };
>  
>  &i2c2 {
> -	clock-frequency = <100000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_i2c2>;
> -	status = "okay";
> -
>  	tca9548@70 {
>  		compatible = "nxp,pca9548";
>  		pinctrl-0 = <&pinctrl_i2c_mux_reset>;
> -- 
> 2.21.0
> 
