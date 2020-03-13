Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F234B184910
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 15:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgCMORT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 10:17:19 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49282 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgCMORT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:17:19 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 548C75F;
        Fri, 13 Mar 2020 15:17:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1584109036;
        bh=cNWnjF6VI23jiFmMB2Z9kPjXU1GPF9FYUM8c0rkqsfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sq4XHVmjlbnnW+wogjp1YdiXGbDHSx42KHhulBqivBzTCxtqFKJ8mFo0dlzHTI9ar
         9Cn1ADG+fwz17GazAhlgeNdfuDglKJiKysVreka8tsoddZZ9lLKGEhEGt5OkqwC8RU
         bPX/VD6oJDBoujSTb8b7SL+xL1BOwc//jiVaDlRg=
Date:   Fri, 13 Mar 2020 16:17:13 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Phong LE <ple@baylibre.com>, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, a.hajda@samsung.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, sam@ravnborg.org,
        mripard@kernel.org, heiko.stuebner@theobroma-systems.com,
        linus.walleij@linaro.org, stephan@gerhold.net, icenowy@aosc.io,
        broonie@kernel.org, mchehab+samsung@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: display: bridge: add it66121 bindings
Message-ID: <20200313141713.GG4751@pendragon.ideasonboard.com>
References: <20200311125135.30832-1-ple@baylibre.com>
 <20200311125135.30832-3-ple@baylibre.com>
 <20200313134013.GC4751@pendragon.ideasonboard.com>
 <03d5bb7f-db1b-79df-bd46-3ac0f3b4feb1@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03d5bb7f-db1b-79df-bd46-3ac0f3b4feb1@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Mar 13, 2020 at 03:12:13PM +0100, Neil Armstrong wrote:
> On 13/03/2020 14:40, Laurent Pinchart wrote:
> > On Wed, Mar 11, 2020 at 01:51:33PM +0100, Phong LE wrote:
> >> Add the ITE bridge HDMI it66121 bindings.
> >>
> >> Signed-off-by: Phong LE <ple@baylibre.com>
> >> ---
> >>  .../bindings/display/bridge/ite,it66121.yaml  | 98 +++++++++++++++++++
> >>  1 file changed, 98 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> >> new file mode 100644
> >> index 000000000000..1717e880d130
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
> >> @@ -0,0 +1,98 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/display/bridge/ite,it66121.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: ITE it66121 HDMI bridge Device Tree Bindings
> >> +
> >> +maintainers:
> >> +  - Phong LE <ple@baylibre.com>
> >> +  - Neil Armstrong <narmstrong@baylibre.com>
> >> +
> >> +description: |
> >> +  The IT66121 is a high-performance and low-power single channel HDMI
> >> +  transmitter, fully compliant with HDMI 1.3a, HDCP 1.2 and backward compatible
> >> +  to DVI 1.0 specifications.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: ite,it66121
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +    description: base I2C address of the device
> >> +
> >> +  reset-gpios:
> >> +    maxItems: 1
> >> +    description: GPIO connected to active low reset
> >> +
> >> +  vrf12-supply:
> >> +    maxItems: 1
> >> +    description: Regulator for 1.2V analog core power.
> >> +
> >> +  vcn33-supply:
> >> +    maxItems: 1
> >> +    description: Regulator for 3.3V digital core power.
> >> +
> >> +  vcn18-supply:
> >> +    maxItems: 1
> >> +    description: Regulator for 1.8V IO core power.
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +
> >> +  pclk-dual-edge:
> >> +    maxItems: 1
> >> +    description: enable pclk dual edge mode.
> > 
> > I'm having a bit of trouble understanding how this operates. Looking at
> > the driver code the property is only taken into account to calculate the
> > maximum allowed frequency. How is the IT66121 configured for single vs.
> > dual pixel clock edge mode ?
> 
> Dual edge mode is Dual-Data-Rate mode, the normal mode is MEDIA_BUS_FMT_RGB888_1X24 and dual edge is
> MEDIA_BUS_FMT_RGB888_2X12_LE (or MEDIA_BUS_FMT_RGB888_2X12_BE, not sure) on a single clock period.
> 
> This should be negociated at runtime, but the bus width should be specified somewhere to select
> one of the modes.

How about replacing this property by bus-width to report the connected
bus width ? It should then become an endpoint property.

> >> +
> >> +  port:
> >> +    type: object
> >> +
> >> +    properties:
> >> +      endpoint:
> >> +        type: object
> >> +        description: |
> >> +          Input endpoints of the bridge.
> >> +
> >> +    required:
> >> +      - endpoint
> > 
> > You should have two ports, one for the bridge input, and one for the
> > bridge output.
> > 
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - reset-gpios
> >> +  - vrf12-supply
> >> +  - vcn33-supply
> >> +  - vcn18-supply
> >> +  - interrupts
> >> +  - port
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    i2c6 {
> >> +      #address-cells = <1>;
> >> +      #size-cells = <0>;
> >> +
> >> +      it66121hdmitx: it66121hdmitx@4c {
> >> +        compatible = "ite,it66121";
> >> +        pinctrl-names = "default";
> >> +        pinctrl-0 = <&ite_pins_default>;
> >> +        vcn33-supply = <&mt6358_vcn33_wifi_reg>;
> >> +        vcn18-supply = <&mt6358_vcn18_reg>;
> >> +        vrf12-supply = <&mt6358_vrf12_reg>;
> >> +        reset-gpios = <&pio 160 1 /* GPIO_ACTIVE_LOW */>;
> >> +        interrupt-parent = <&pio>;
> >> +        interrupts = <4 8 /* IRQ_TYPE_LEVEL_LOW */>;
> >> +        reg = <0x4c>;
> >> +        pclk-dual-edge;
> >> +
> >> +        port {
> >> +          it66121_in: endpoint {
> >> +            remote-endpoint = <&display_out>;
> >> +          };
> >> +        };
> >> +      };
> >> +    };

-- 
Regards,

Laurent Pinchart
