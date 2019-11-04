Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE939EE1F3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 15:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfKDOOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 09:14:37 -0500
Received: from gloria.sntech.de ([185.11.138.130]:51446 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbfKDOOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:14:36 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iRd7j-0001gt-I1; Mon, 04 Nov 2019 15:14:27 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Split rk3399-roc-pc for with and without mezzanine board.
Date:   Mon, 04 Nov 2019 15:14:26 +0100
Message-ID: <7600269.ktiZa05prH@diego>
In-Reply-To: <17c7c736-46a2-fee6-9bf3-f351a7871e20@fivetechno.de>
References: <17c7c736-46a2-fee6-9bf3-f351a7871e20@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Am Montag, 4. November 2019, 15:08:55 CET schrieb Markus Reichl:
> For rk3399-roc-pc is a mezzanine board available that carries M.2 and
> POE interfaces. Use it with a separate dts.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
> v2: Add new compatible string for roc-pc with mezzanine board.
> ---
>  .../devicetree/bindings/arm/rockchip.yaml     |   7 +-
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3399-roc-pc-mezz.dts  |  72 ++
>  .../arm64/boot/dts/rockchip/rk3399-roc-pc.dts | 757 +----------------
>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 770 ++++++++++++++++++
>  5 files changed, 850 insertions(+), 757 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezz.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index bf86e8237363..e46af071a5fe 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -87,11 +87,16 @@ properties:
>            - const: firefly,roc-rk3328-cc
>            - const: rockchip,rk3328
>  
> -      - description: Firefly ROC-RK3399-PC
> +      - description: Firefly ROC-RK3399-PC standalone
>          items:
>            - const: firefly,roc-rk3399-pc
>            - const: rockchip,rk3399
>  
> +      - description: Firefly ROC-RK3399-PC with mezzanine
> +        items:
> +          - const: firefly,roc-rk3399-pc-mezz
> +          - const: rockchip,rk3399
> +

Please do this similar to like the NanoPC boards, so like

      - description: Firefly ROC-RK3399-PC
         items:
          - enum:
              - firefly,roc-rk3399-pc
              - firefly,roc-rk3399-pc-mezzanine
           - const: rockchip,rk3399

including using the full name (-mezzanine) here and in the
actual dts filename+compatible.

Thanks
Heiko


