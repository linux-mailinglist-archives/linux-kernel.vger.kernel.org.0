Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5538430916
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 08:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEaG7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 02:59:39 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43223 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaG7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:59:38 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0DDFCE0005;
        Fri, 31 May 2019 06:59:28 +0000 (UTC)
Date:   Fri, 31 May 2019 08:59:28 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com,
        Sergey Suloev <ssuloev@orpaltech.com>,
        Ryan Pannell <ryan@osukl.com>, bshah@mykolab.com
Subject: Re: [PATCH v9 1/9] dt-bindings: sun6i-dsi: Add A64 MIPI-DSI
 compatible
Message-ID: <20190531065928.4wfr3kjngefy4q2b@flea>
References: <20190529105615.14027-1-jagan@amarulasolutions.com>
 <20190529105615.14027-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529105615.14027-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 04:26:07PM +0530, Jagan Teki wrote:
> The MIPI DSI controller in Allwinner A64 is similar to A33.
>
> But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
> to with separate compatible for A64 on the same driver.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> index 1cc40663b7a2..9877398be69a 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> @@ -12,6 +12,7 @@ The DSI Encoder generates the DSI signal from the TCON's.
>  Required properties:
>    - compatible: value must be one of:
>      * allwinner,sun6i-a31-mipi-dsi
> +    * allwinner,sun50i-a64-mipi-dsi
>    - reg: base address and size of memory-mapped region
>    - interrupts: interrupt associated to this IP
>    - clocks: phandles to the clocks feeding the DSI encoder

We've switch to YAML now, and the compatible should be expressed that
way now:

compatible:
  enum:
    - allwinner,sun6i-a31-mipi-dsi
    - allwinner,sun50i-a64-mipi-dsi

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
