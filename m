Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF09D112CB5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 14:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfLDNgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 08:36:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbfLDNgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:36:05 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1CA220803;
        Wed,  4 Dec 2019 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575466564;
        bh=hhS3x/nQokGlDFdYclj2m2H/jf3hjjXulqb9PxxX57Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VM3bKeJVv1dMN6BeNojFvP27GvGyoglch+wwSXnXDFY/s5xnZYluPEgtqHP1pLHBI
         prruJCVl6wz31+G2JpEHajZiBcCrji9q39He3EbAsK9BXkpwSrx5p+SQ1JDEwO4TWm
         sgG9X/iJN40+bL1pbEAPl8nAtd7FykAUiOZeYSMg=
Date:   Wed, 4 Dec 2019 14:36:00 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v12 1/7] dt-bindings: sun6i-dsi: Document A64 MIPI-DSI
 controller
Message-ID: <20191204133600.gnv6dnhk6upe7xod@gilmour.lan>
References: <20191203134816.5319-1-jagan@amarulasolutions.com>
 <20191203134816.5319-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yzyy5rpvlreslc45"
Content-Disposition: inline
In-Reply-To: <20191203134816.5319-2-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yzyy5rpvlreslc45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2019 at 07:18:10PM +0530, Jagan Teki wrote:
> The MIPI DSI controller in Allwinner A64 is similar to A33.
>
> But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
> to have separate compatible for A64 on the same driver.
>
> DSI_SCLK uses mod clock-names on dt-bindings, so the same
> is not required for A64.
>
> On that note
> - A64 require minimum of 1 clock like the bus clock
> - A33 require minimum of 2 clocks like both bus, mod clocks
>
> So, update dt-bindings so-that it can document both A33,
> A64 bindings requirements.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v12:
> - Use 'enum' instead of oneOf+const
>
>  .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> index dafc0980c4fa..b91446475f35 100644
> --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> @@ -15,7 +15,9 @@ properties:
>    "#size-cells": true
>
>    compatible:
> -    const: allwinner,sun6i-a31-mipi-dsi
> +    enum:
> +      - allwinner,sun6i-a31-mipi-dsi
> +      - allwinner,sun50i-a64-mipi-dsi
>
>    reg:
>      maxItems: 1
> @@ -24,6 +26,8 @@ properties:
>      maxItems: 1
>
>    clocks:
> +    minItems: 1
> +    maxItems: 2
>      items:
>        - description: Bus Clock
>        - description: Module Clock
> @@ -63,13 +67,25 @@ required:
>    - reg
>    - interrupts
>    - clocks
> -  - clock-names
>    - phys
>    - phy-names
>    - resets
>    - vcc-dsi-supply
>    - port
>
> +allOf:
> +  - if:
> +      properties:
> +         compatible:
> +           contains:
> +             const: allwinner,sun6i-a31-mipi-dsi
> +      then:
> +        properties:
> +          clocks:
> +            minItems: 2
> +        required:
> +          - clock-names
> +

Your else condition should check that the number of clocks items is 1
on the A64

Maxime

--yzyy5rpvlreslc45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXee2QAAKCRDj7w1vZxhR
xRIbAPsHrDR0oltRHkGKak8qtw0Ade9i9chYBdVFnWgbieqG2gEAt+EUUqKul0A7
TU9F3HI8vSkhOj8LTLq1pThpUu6Hcgo=
=6XAi
-----END PGP SIGNATURE-----

--yzyy5rpvlreslc45--
