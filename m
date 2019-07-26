Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9928766A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfGZMyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 08:54:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38172 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfGZMyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:54:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so54346462wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 05:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zM09sw2mge+SQJ/dkUCgGryrhGvD/50/pwMZAHGvtdE=;
        b=HP04bG7UUn/40T8KeRZpcMYv0bVm/9wExt2hbTo7ft2WDYx1LIV1oi1nM77t7flwKG
         OIXyF2pOt66IX7pAna70XlXHjoWOWZc1aON2H7Vn+7JaHgKb5mDjAvIvDBCuh32Uh27e
         aBZIkQEXhSyDWRsY4rJODFtHY6uR+7LuFHdF4OBId6uu9ya2jgPG21j2DmFPOsBuBP2R
         sYQKfjj3cY2eEg1tkmcfTOOXTAZaB/tFSL8Mem6mdLDJrByVODcYJuA/GTPfr4nSMHLb
         LN1S2lC0G/9CXlaXc1tR9YgmQhgPiQAU0d3D9gJrfzKLr16kWeQ4tVAMESwsYVBc4l4O
         fFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zM09sw2mge+SQJ/dkUCgGryrhGvD/50/pwMZAHGvtdE=;
        b=qJ+qU8cr19Cxnd+wIk98+nCRHNGGo634qGLuD5uSgYrEmP1UOtljHoF4RkuLIbnUEO
         zGAhWnzQAkXGyo7DRtIH88t5S25RdDsIGJcpf4P+9+8PjxkICqzzJIauVvtdlwJwyEu/
         YEbKEYG0L7rzbvuOGcxHOL8xoNJqer/Jv9LPhpBni7rueBv1gI6sFPka4PyPjX2PeAtc
         UWt4x02d00Isq6v0u28xEiE177JaflC4IL3ou24LJcf/MtpavizZuk9/7rtOd37nKg8/
         YECOOidFWZqfxkyP5m3cusaaQ3ntVU3rf5tTXOGUu9xyy/gc60+EN3ewZ6A/sUUWtyHb
         hR9A==
X-Gm-Message-State: APjAAAWppHoQ82l87h+nvyQSPsg8r41pLOi6p6lMe1DhzrZtWW0688z3
        YB0MbUG48ksD99nKe28rRh/5Og==
X-Google-Smtp-Source: APXvYqyLQwQihi2zuCw1a4dIGsqBppyZjq70RkBd4dJPH1h1Qb4gYh91igcpNqGd3ffnC7Jp9bBcQQ==
X-Received: by 2002:a05:6000:1186:: with SMTP id g6mr91773053wrx.17.1564145667866;
        Fri, 26 Jul 2019 05:54:27 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id n14sm96819304wra.75.2019.07.26.05.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 05:54:27 -0700 (PDT)
Date:   Fri, 26 Jul 2019 14:54:24 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     baylibre-upstreaming@groups.io
Cc:     Rob Herring <robh+dt@kernel.org>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kevin Hilman <khilman@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: crypto: Add DT bindings documentation
 for amlogic-crypto
Message-ID: <20190726125424.GA20366@Red>
References: <1564083776-20540-1-git-send-email-clabbe@baylibre.com>
 <1564083776-20540-2-git-send-email-clabbe@baylibre.com>
 <CAL_JsqLbYwRpNWHGkYbomWLMpum_DXW4OjNNRrwTRM=w86dONw@mail.gmail.com>
 <15B4F061F360B2F0.8182@groups.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15B4F061F360B2F0.8182@groups.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 01:07:47PM +0200, Corentin Labbe via Groups.Io wrote:
> On Thu, Jul 25, 2019 at 04:55:30PM -0600, Rob Herring wrote:
> > On Thu, Jul 25, 2019 at 1:43 PM Corentin Labbe <clabbe@baylibre.com> wrote:
> > >
> > > This patch adds documentation for Device-Tree bindings for the
> > > Amlogic GXL cryptographic offloader driver.
> > >
> > > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > > ---
> > >  .../bindings/crypto/amlogic-gxl-crypto.yaml   | 45 +++++++++++++++++++
> > 
> > Follow the compatible string for the filename: amlogic,gxl-crypto.yaml
> > 
> > >  1 file changed, 45 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/crypto/amlogic-gxl-crypto.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/crypto/amlogic-gxl-crypto.yaml b/Documentation/devicetree/bindings/crypto/amlogic-gxl-crypto.yaml
> > > new file mode 100644
> > > index 000000000000..41265e57c00b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/crypto/amlogic-gxl-crypto.yaml
> > > @@ -0,0 +1,45 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > 
> > Dual (GPL-2.0 OR BSD-2-Clause) is preferred for new bindings. Not a
> > requirement though.
> > 
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/crypto/amlogic-gxl-crypto.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Amlogic GXL Cryptographic Offloader
> > > +
> > > +maintainers:
> > > +  - Corentin Labbe <clabbe@baylibre.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > 
> > Don't need 'oneOf' when there is only 1.
> > 
> > > +      - const: amlogic,gxl-crypto
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  clock-names:
> > > +    const: blkmv
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - clocks
> > > +  - clock-names
> > > +
> > > +examples:
> > > +  - |
> > > +    crypto: crypto@c883e000 {
> > > +        compatible = "amlogic,gxl-crypto";
> > > +        reg = <0x0 0xc883e000 0x0 0x36>;
> > 
> > This should throw errors because the default size on examples are 1
> > cell. But validating the examples with the schema only just landed in
> > 5.3-rc1.
> > 
> > > +        interrupts = <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>,
> > > +            <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
> > 
> > This doesn't match the schema.
> > 
> > > +        clocks = <&clkc CLKID_BLKMV>;
> > > +        clock-names = "blkmv";
> > > +    };
> > > --
> > > 2.21.0
> > >
> 
> Hello
> 
> I will fix all your remarks.
> I have tried to valide them but fail to do it:
> make ARCH=arm64 CROSS_COMPILE=aarch64-unknown-linux-gnu- KBUILD_OUTPUT=~/crossbuild/next/arm64/default/defconfig/ dt_binding_check
> make[1]�: on entre dans le r�pertoire ��/usr/src/crossbuild/next/arm64/default/defconfig��
> arch/arm64/Makefile:56: CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built
>   GEN     Makefile
> scripts/kconfig/conf  --syncconfig Kconfig
> arch/arm64/Makefile:56: CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
> /linux-next/Documentation/devicetree/bindings/arm/atmel-at91.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> /linux-next/Documentation/devicetree/bindings/arm/axxia.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/axxia.yaml
> /linux-next/Documentation/devicetree/bindings/arm/amlogic.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/amlogic.yaml
> /linux-next/Documentation/devicetree/bindings/arm/renesas.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/renesas.yaml
> /linux-next/Documentation/devicetree/bindings/arm/sirf.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/sirf.yaml
> /linux-next/Documentation/devicetree/bindings/arm/spear.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/spear.yaml
> /linux-next/Documentation/devicetree/bindings/arm/qcom.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/qcom.yaml
> /linux-next/Documentation/devicetree/bindings/arm/pmu.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/pmu.yaml
> /linux-next/Documentation/devicetree/bindings/arm/digicolor.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/digicolor.yaml
> /linux-next/Documentation/devicetree/bindings/arm/sunxi.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/sunxi.yaml
> /linux-next/Documentation/devicetree/bindings/arm/zte.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/zte.yaml
> /linux-next/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
> /linux-next/Documentation/devicetree/bindings/arm/cpus.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/cpus.yaml
> /linux-next/Documentation/devicetree/bindings/arm/rda.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/rda.yaml
> /linux-next/Documentation/devicetree/bindings/arm/psci.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/psci.yaml
> /linux-next/Documentation/devicetree/bindings/arm/calxeda.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/calxeda.yaml
> /linux-next/Documentation/devicetree/bindings/arm/ti/nspire.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/ti/nspire.yaml
> /linux-next/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
> /linux-next/Documentation/devicetree/bindings/arm/fsl.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/fsl.yaml
> /linux-next/Documentation/devicetree/bindings/arm/xilinx.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/xilinx.yaml
> /linux-next/Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/intel-ixp4xx.yaml
> /linux-next/Documentation/devicetree/bindings/arm/altera.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/altera.yaml
> /linux-next/Documentation/devicetree/bindings/arm/rockchip.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/rockchip.yaml
> /linux-next/Documentation/devicetree/bindings/arm/mediatek.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/mediatek.yaml
> /linux-next/Documentation/devicetree/bindings/arm/vt8500.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/vt8500.yaml
> /linux-next/Documentation/devicetree/bindings/arm/al,alpine.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/al,alpine.yaml
> /linux-next/Documentation/devicetree/bindings/arm/l2c2x0.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/l2c2x0.yaml
> /linux-next/Documentation/devicetree/bindings/arm/moxart.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/moxart.yaml
> /linux-next/Documentation/devicetree/bindings/arm/sti.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/sti.yaml
> /linux-next/Documentation/devicetree/bindings/arm/primecell.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/primecell.yaml
> /linux-next/Documentation/devicetree/bindings/arm/bitmain.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/bitmain.yaml
> /linux-next/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
> /linux-next/Documentation/devicetree/bindings/arm/stm32/stm32.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> /linux-next/Documentation/devicetree/bindings/arm/nxp/lpc32xx.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/nxp/lpc32xx.yaml
> /linux-next/Documentation/devicetree/bindings/arm/tegra.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/arm/tegra.yaml
> /linux-next/Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml
> /linux-next/Documentation/devicetree/bindings/bus/allwinner,sun50i-a64-de2.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/bus/allwinner,sun50i-a64-de2.yaml
> /linux-next/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/clock/milbeaut-clock.yaml
> /linux-next/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
> /linux-next/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
> /linux-next/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
> /linux-next/Documentation/devicetree/bindings/clock/fixed-clock.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> /linux-next/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> /linux-next/Documentation/devicetree/bindings/crypto/allwinner,sun4i-a10-crypto.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/crypto/allwinner,sun4i-a10-crypto.yaml
> /linux-next/Documentation/devicetree/bindings/display/simple-framebuffer.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> /linux-next/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> /linux-next/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.yaml
> /linux-next/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.yaml
> /linux-next/Documentation/devicetree/bindings/display/panel/lvds.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/panel/lvds.yaml
> /linux-next/Documentation/devicetree/bindings/display/panel/panel-common.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/panel/panel-common.yaml
> /linux-next/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.yaml
> /linux-next/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
> /linux-next/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
> /linux-next/Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml
> /linux-next/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.yaml
> /linux-next/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml
> /linux-next/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml
> /linux-next/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
> /linux-next/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/panel/raspberrypi,7inch-touchscreen.yaml
> /linux-next/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml
> /linux-next/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml
> /linux-next/Documentation/devicetree/bindings/example-schema.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/example-schema.yaml
> /linux-next/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
> /linux-next/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/gpio/pl061-gpio.yaml
> /linux-next/Documentation/devicetree/bindings/i2c/allwinner,sun6i-a31-p2wi.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/i2c/allwinner,sun6i-a31-p2wi.yaml
> /linux-next/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
> /linux-next/Documentation/devicetree/bindings/i2c/i2c-gpio.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/i2c/i2c-gpio.yaml
> /linux-next/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> /linux-next/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> /linux-next/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> /linux-next/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> /linux-next/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> /linux-next/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> /linux-next/Documentation/devicetree/bindings/iio/light/tsl2583.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/iio/light/tsl2583.yaml
> /linux-next/Documentation/devicetree/bindings/iio/light/isl29018.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/iio/light/isl29018.yaml
> /linux-next/Documentation/devicetree/bindings/iio/light/tsl2772.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
> /linux-next/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
> /linux-next/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> /linux-next/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> /linux-next/Documentation/devicetree/bindings/input/gpio-vibrator.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
> /linux-next/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
> /linux-next/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
> /linux-next/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> /linux-next/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
> /linux-next/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> /linux-next/Documentation/devicetree/bindings/misc/intel,ixp4xx-queue-manager.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/misc/intel,ixp4xx-queue-manager.yaml
> /linux-next/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> /linux-next/Documentation/devicetree/bindings/mmc/mmc-controller.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> /linux-next/Documentation/devicetree/bindings/mtd/nand-controller.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> /linux-next/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
> /linux-next/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
> /linux-next/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-emac.yaml
> /linux-next/Documentation/devicetree/bindings/net/snps,dwmac.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> /linux-next/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/net/allwinner,sun7i-a20-gmac.yaml
> /linux-next/Documentation/devicetree/bindings/net/ethernet-phy.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> /linux-next/Documentation/devicetree/bindings/net/mdio.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/net/mdio.yaml
> /linux-next/Documentation/devicetree/bindings/net/ethernet-controller.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> /linux-next/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-mdio.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/net/allwinner,sun4i-a10-mdio.yaml
> /linux-next/Documentation/devicetree/bindings/nvmem/nvmem.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> /linux-next/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> /linux-next/Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
> /linux-next/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
> /linux-next/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
> /linux-next/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
> /linux-next/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
> /linux-next/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> /linux-next/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
> /linux-next/Documentation/devicetree/bindings/regulator/max8660.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/regulator/max8660.yaml
> /linux-next/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
> /linux-next/Documentation/devicetree/bindings/regulator/regulator.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/regulator/regulator.yaml
> /linux-next/Documentation/devicetree/bindings/riscv/cpus.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/riscv/cpus.yaml
> /linux-next/Documentation/devicetree/bindings/riscv/sifive.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/riscv/sifive.yaml
> /linux-next/Documentation/devicetree/bindings/rtc/rtc.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/rtc/rtc.yaml
> /linux-next/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
> /linux-next/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
> /linux-next/Documentation/devicetree/bindings/rtc/allwinner,sun4i-a10-rtc.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/rtc/allwinner,sun4i-a10-rtc.yaml
> /linux-next/Documentation/devicetree/bindings/serial/pl011.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/serial/pl011.yaml
> /linux-next/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> /linux-next/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
> /linux-next/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
> /linux-next/Documentation/devicetree/bindings/spi/spi-pl022.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> /linux-next/Documentation/devicetree/bindings/spi/spi-controller.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/spi/spi-controller.yaml
> /linux-next/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
> /linux-next/Documentation/devicetree/bindings/spi/spi-gpio.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/spi/spi-gpio.yaml
> /linux-next/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> /linux-next/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
> /linux-next/Documentation/devicetree/bindings/timer/arm,global_timer.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/timer/arm,global_timer.yaml
> /linux-next/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> /linux-next/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
> /linux-next/Documentation/devicetree/bindings/trivial-devices.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/trivial-devices.yaml
> /linux-next/Documentation/devicetree/bindings/usb/generic-ohci.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> /linux-next/Documentation/devicetree/bindings/usb/usb-hcd.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> /linux-next/Documentation/devicetree/bindings/usb/generic-ehci.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> /linux-next/Documentation/devicetree/bindings/vendor-prefixes.yaml: ignoring, error parsing file
> warning: no schema found in file: /linux-next/Documentation/devicetree/bindings/vendor-prefixes.yaml
> /usr/lib64/python3.6/site-packages/dtschema/schemas/serial.yaml: ignoring, error parsing file
> Traceback (most recent call last):
>   File "/usr/lib64/python3.6/site-packages/jsonschema/validators.py", line 739, in resolve_from_url
>     document = self.store[url]
>   File "/usr/lib64/python3.6/site-packages/jsonschema/_utils.py", line 23, in __getitem__
>     return self.store[self.normalize(uri)]
> KeyError: 'http://devicetree.org/meta-schemas/base.yaml'
> 
> During handling of the above exception, another exception occurred:
> 
> Traceback (most recent call last):
>   File "/usr/lib64/python3.6/site-packages/jsonschema/validators.py", line 742, in resolve_from_url
>     document = self.resolve_remote(url)
>   File "/usr/lib64/python3.6/site-packages/jsonschema/validators.py", line 821, in resolve_remote
>     result = self.handlers[scheme](uri)
>   File "/usr/lib64/python3.6/site-packages/dtschema/lib.py", line 523, in http_handler
>     return load_schema(uri.replace(schema_base_url, ''))
>   File "/usr/lib64/python3.6/site-packages/dtschema/lib.py", line 102, in load_schema
>     return yaml.load(f.read())
>   File "/usr/lib64/python3.6/site-packages/ruamel/yaml/main.py", line 266, in load
>     return constructor.get_single_data()
>   File "/usr/lib64/python3.6/site-packages/ruamel/yaml/constructor.py", line 102, in get_single_data
>     node = self.composer.get_single_node()
>   File "_ruamel_yaml.pyx", line 703, in _ruamel_yaml.CParser.get_single_node (ext/_ruamel_yaml.c:9583)
>   File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event (ext/_ruamel_yaml.c:12818)
> ruamel.yaml.parser.ParserError: found incompatible YAML document
>   in "<unicode string>", line 4, column 1
> 
> During handling of the above exception, another exception occurred:
> 
> Traceback (most recent call last):
>   File "/usr/lib/python-exec/python3.6/dt-mk-schema", line 32, in <module>
>     schemas = dtschema.process_schemas(args.schemas, core_schema=(not args.useronly))
>   File "/usr/lib64/python3.6/site-packages/dtschema/lib.py", line 487, in process_schemas
>     sch = process_schema(os.path.abspath(filename))
>   File "/usr/lib64/python3.6/site-packages/dtschema/lib.py", line 428, in process_schema
>     DTValidator.check_schema(schema)
>   File "/usr/lib64/python3.6/site-packages/dtschema/lib.py", line 572, in check_schema
>     meta_schema = cls.resolver.resolve_from_url(schema['$schema'])
>   File "/usr/lib64/python3.6/site-packages/jsonschema/validators.py", line 744, in resolve_from_url
>     raise exceptions.RefResolutionError(exc)
> jsonschema.exceptions.RefResolutionError: found incompatible YAML document
>   in "<unicode string>", line 4, column 1
> make[2]: *** [/linux-next/Documentation/devicetree/bindings/Makefile:31: Documentation/devicetree/bindings/processed-schema.yaml] Error 1
> make[1]: *** [/linux-next/Makefile:1278: dt_binding_check] Error 2
> make[1]�: on quitte le r�pertoire ��/usr/src/crossbuild/next/arm64/default/defconfig��
> make: *** [Makefile:179: sub-make] Error 2
> 
> Do you know what happens ?
> 

Just found the problem

Sorry for the noise.

Regards
