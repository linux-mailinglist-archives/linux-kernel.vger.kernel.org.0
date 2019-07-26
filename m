Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 835DF76419
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfGZLGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 07:06:00 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:33680 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfGZLF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:05:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id A4CA4FB03;
        Fri, 26 Jul 2019 13:05:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 27ddROgQVqy3; Fri, 26 Jul 2019 13:05:55 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id CF03E46AA1; Fri, 26 Jul 2019 13:05:54 +0200 (CEST)
Date:   Fri, 26 Jul 2019 13:05:54 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>
Subject: Re: [PATCH 2/3] dt-bindings: display/bridge: Add binding for IMX NWL
 mipi dsi host controller
Message-ID: <20190726110554.GA9359@bogon.m.sigxcpu.org>
References: <cover.1563983037.git.agx@sigxcpu.org>
 <70a5c6617936a4a095e7608b96e3f9fae5ddfbb1.1563983037.git.agx@sigxcpu.org>
 <20190726092315.GA9754@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190726092315.GA9754@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,
thanks for your comments!

On Fri, Jul 26, 2019 at 11:23:15AM +0200, Sam Ravnborg wrote:
> Hi Guido.
> 
> A few comments follows.
> 
> 	Sam
> 
> On Wed, Jul 24, 2019 at 05:52:25PM +0200, Guido G�nther wrote:
> > The Northwest Logic MIPI DSI IP core can be found in NXPs i.MX8 SoCs.
> > 
> > Signed-off-by: Guido G�nther <agx@sigxcpu.org>
> > ---
> >  .../bindings/display/bridge/imx-nwl-dsi.txt   | 89 +++++++++++++++++++
> 
> New binding. Any chance we can get this in yaml format?
> This is the way forward and we have to convert the file anyway.
> 
> None of the other bridges use yaml format, but someone has to be the
> first.

I'm fine with converting this (i also forgot to squash a missing unit
name and a typo fix in the bindings, will add this for v2).

> 
> >  1 file changed, 89 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt b/Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt
> > new file mode 100644
> > index 000000000000..288fdb726d5a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt
> > @@ -0,0 +1,89 @@
> > +Northwest Logic MIPI-DSI on imx SoCs
> > +=====================================
> > +
> > +NWL MIPI-DSI host controller found on i.MX8 platforms. This is a
> > +dsi bridge for the for the NWL MIPI-DSI host.
> 
> To my best understanding a bridge is something that converts from one
> format to another format.
> Something that in the drm world are connected to an encoder.
> 
> I do not know the HW here - but from this very brif description this
> sounds more like a display controller and not a bridge?

mxsfb can drive LCD displays directly and - on newer SoCs like the i.MX8
- also feed the nwl dsi host controller. So having that as a bridge is
hopefully the right thing to do.

In order for that to work on the hardware i tested on, we'd need:

- at least the first patch from
  https://patchwork.freedesktop.org/series/62822/ for bridge support
- https://patchwork.freedesktop.org/series/64300/ to get the bus flags
- https://patchwork.freedesktop.org/series/64292/ to be able to use
  panel_bridge in this driver

I only had a reference to the first point above in the cover letter.
I'll add the other ones for v2 now that these are sent out. I'll also
address your comments in other parts of this series.

Cheers and thanks for having look!
 -- Guido

> 
> 
> > +
> > +Required properties:
> > +- compatible: 		"fsl,<chip>-nwl-dsi"
> > +	The following strings are expected:
> > +			"fsl,imx8mq-nwl-dsi"
> > +- reg: 			the register range of the MIPI-DSI controller
> > +- interrupts: 		the interrupt number for this module
> > +- clock, clock-names: 	phandles to the MIPI-DSI clocks
> > +	The following clocks are expected on all platforms:
> > +		"core"    - DSI core clock
> > +		"tx_esc"  - TX_ESC clock (used in escape mode)
> > +		"rx_esc"  - RX_ESC clock (used in escape mode)
> > +		"phy_ref" - PHY_REF clock. Clock is managed by the phy. Only
> > +                            used to read the clock rate.
> > +- assigned-clocks:	phandles to clocks that require initial configuration
> > +- assigned-clock-rates:	rates of the clocks that require initial configuration
> > +	The following clocks need to have an initial configuration:
> > +	"tx_esc" (20 MHz) and "rx_esc" (80 Mhz).
> > +- phys: 		phandle to the phy module representing the DPHY
> > +			inside the MIPI-DSI IP block
> > +- phy-names: 		should be "dphy"
> > +
> > +Optional properties:
> > +- power-domains 	phandle to the power domain
> > +- src			phandle to the system reset controller (required on
> > +			i.MX8MQ)
> Name is not very descriptive.
> Other bindings seems to use "resets" here?
> 
> > +- mux-sel		phandle to the MUX register set (required on i.MX8MQ)
> > +- assigned-clock-parents phandles to parent clocks that needs to be assigned as
> > +			parents to clocks defined in assigned-clocks
> > +
> > +Example:
> > +	mipi_dsi: mipi_dsi@30a00000 {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		compatible = "fsl,imx8mq-nwl-dsi";
> > +		reg = <0x30A00000 0x300>;
> > +		clocks = <&clk IMX8MQ_CLK_DSI_CORE>,
> > +			 <&clk IMX8MQ_CLK_DSI_AHB>,
> > +			 <&clk IMX8MQ_CLK_DSI_IPG_DIV>,
> > +			 <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> > +		clock-names = "core", "rx_esc", "tx_esc", "phy_ref";
> > +		assigned-clocks = <&clk IMX8MQ_CLK_DSI_AHB>,
> > +				  <&clk IMX8MQ_CLK_DSI_CORE>,
> > +				  <&clk IMX8MQ_CLK_DSI_IPG_DIV>;
> > +		assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>,
> > +					 <&clk IMX8MQ_SYS1_PLL_266M>;
> > +		assigned-clock-rates = <80000000>,
> > +				       <266000000>,
> > +				       <20000000>;
> > +		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> > +		power-domains = <&pgc_mipi>;
> > +		src = <&src>;
> > +		mux-sel = <&iomuxc_gpr>;
> > +		phys = <&dphy>;
> > +		phy-names = "dphy";
> > +		status = "okay";
> I recall status should not be included in examples.
> 
> > +
> > +		panel@0 {
> > +			compatible = "...";
> > +			port {
> > +			     panel_in: endpoint {
> > +				       remote-endpoint = <&mipi_dsi_out>;
> > +			     };
> > +			};
> > +		};
> > +
> > +		ports {
> > +		      #address-cells = <1>;
> > +		      #size-cells = <0>;
> > +
> > +		      port@0 {
> > +			     reg = <0>;
> > +			     mipi_dsi_in: endpoint {
> > +					  remote-endpoint = <&dcss_disp0_mipi_dsi>;
> > +			     };
> > +		      };
> > +		      port@1 {
> > +			     reg = <1>;
> > +			     mipi_dsi_out: endpoint {
> > +					   remote-endpoint = <&panel_in>;
> > +			     };
> > +		      };
> > +		};
> > +	};
> > -- 
> > 2.20.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
