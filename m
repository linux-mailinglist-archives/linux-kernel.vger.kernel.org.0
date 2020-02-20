Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFD5165F40
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 14:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgBTNy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 08:54:27 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:54520 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgBTNy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:54:26 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B11C0E7C;
        Thu, 20 Feb 2020 14:54:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1582206864;
        bh=F8M+8/bvGBDpaLEWtPUpT7cWpYWV2PjhtbCfde8TQkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aAV/sQ1S2bRXdyxMQKd7Xhnopq2eBnDtfKKEtJdIOi36sLNMAE3Fhwu39bR3mmUk4
         BjhuJMhjgWLnFvquPxL3LUjnwhoYBRBt0RmNWwuzmOE1Q3B7Wd+ppXh/4r0CF8FocO
         l/nmTzyX4UGYsatpFc+I7ihQLnsgctPexKiNdl6c=
Date:   Thu, 20 Feb 2020 15:54:06 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, Torsten Duwe <duwe@suse.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] dt-bindings: display: simple: Add NewEast
 Optoelectronics WJFH116008A compatible
Message-ID: <20200220135406.GD4998@pendragon.ideasonboard.com>
References: <20200220083508.792071-1-anarsoul@gmail.com>
 <20200220083508.792071-5-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200220083508.792071-5-anarsoul@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:35:06AM -0800, Vasily Khoruzhick wrote:
> This commit adds compatible for NewEast Optoelectronics WJFH116008A panel
> to panel-simple binding
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 8fe60ee2531c..721de94cc80a 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -43,6 +43,8 @@ properties:
>        - satoz,sat050at40h12r2
>          # Sharp LS020B1DD01D 2.0" HQVGA TFT LCD panel
>        - sharp,ls020b1dd01d
> +        # NewEast Optoelectronics CO., LTD WJFH116008A eDP TFT LCD panel
> +      - neweast,wjfh116008a

Please keep the entries alphabetically sorted. With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
>    backlight: true
>    enable-gpios: true

-- 
Regards,

Laurent Pinchart
