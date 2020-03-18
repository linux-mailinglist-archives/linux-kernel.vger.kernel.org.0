Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36B74189EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 16:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgCRPFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 11:05:08 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46128 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgCRPFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:05:07 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B831FF9;
        Wed, 18 Mar 2020 16:05:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1584543905;
        bh=4XeE4TEsnH5MYOX96WeQj61o+elhBI7bp3OtoVjeJgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agETx32Y3rQ/mCj8O63i2CwrNmnxqYTx9vYR48w+UMxhVyGx9Fav95ZgeA1HYb/BA
         84KzQ0nPck5ouJ8rh5/usYno1MaH0UAQ8yxTQbNm5XRmFyk9ivC3O6FJ8X+zMq7SCs
         d8Mai5VkjVHsAuFAmskPkvEvEOrWwd4hdgsIMMsQ=
Date:   Wed, 18 Mar 2020 17:05:00 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: phy: Add DT bindings for Xilinx
 ZynqMP PSGTR PHY
Message-ID: <20200318150500.GO4733@pendragon.ideasonboard.com>
References: <20200311103252.17514-1-laurent.pinchart@ideasonboard.com>
 <20200311103252.17514-2-laurent.pinchart@ideasonboard.com>
 <57072adb-9967-f5d1-7a3d-af713e8c35cd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57072adb-9967-f5d1-7a3d-af713e8c35cd@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On Fri, Mar 13, 2020 at 04:44:04PM +0530, Kishon Vijay Abraham I wrote:
> +Rob

Any comment regarding patch 2/3 ? :-) You mentioned in your review of v5
that the exported symbols were a no-go, and that is now fixed. The
driver uses the PHY .configure() API to configure DisplayPort
parameters, .power_on() now waits for the PHY PLL to lock, and the
USB-specific exported symbols were removed with reset support being
moved to the PHY consumers (there's no reason for the PHY driver to
reset the PHY consumers, that's a layering violation).

> On 11/03/20 4:02 pm, Laurent Pinchart wrote:
> > From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > 
> > Add DT bindings for the Xilinx ZynqMP PHY. ZynqMP SoCs have a High Speed
> > Processing System Gigabit Transceiver which provides PHY capabilities to
> > USB, SATA, PCIE, Display Port and Ehernet SGMII controllers.
> > 
> > Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > Changes since v5:
> > 
> > - Document clocks and clock-names properties
> > - Document resets and reset-names properties
> > - Replace subnodes with an additional entry in the PHY cells
> > - Drop lane frequency PHY cell, replaced by reference clock phandle
> > - Convert bindings to YAML
> > - Reword the subject line
> > - Drop Rob's R-b as the bindings have significantly changed
> > - Drop resets and reset-names properties
> > ---
> >  .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 104 ++++++++++++++++++
> >  include/dt-bindings/phy/phy.h                 |   1 +
> >  2 files changed, 105 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> > new file mode 100644
> > index 000000000000..9948e4a60e45
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> > @@ -0,0 +1,104 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/xlnx,zynqmp-psgtr.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Xilinx ZynqMP Gigabit Transceiver PHY Device Tree Bindings
> > +
> > +maintainers:
> > +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > +
> > +description: |
> > +  This binding describes the Xilinx ZynqMP Gigabit Transceiver (GTR) PHY. The
> > +  GTR provides four lanes and is used by USB, SATA, PCIE, Display port and
> > +  Ethernet SGMII controllers.
> > +
> > +properties:
> > +  "#phy-cells":
> > +    const: 4
> > +    description: |
> > +      The cells contain the following arguments.
> > +
> > +      - description: The GTR lane
> > +        minimum: 0
> > +        maximum: 3
> > +      - description: The PHY type
> > +        enum:
> > +          - PHY_TYPE_DP
> > +          - PHY_TYPE_PCIE
> > +          - PHY_TYPE_SATA
> > +          - PHY_TYPE_SGMII
> > +          - PHY_TYPE_USB
> > +      - description: The PHY instance
> > +        minimum: 0
> > +        maximum: 1 # for DP, SATA or USB
> > +        maximum: 3 # for PCIE or SGMII
> > +      - description: The reference clock number
> > +        minimum: 0
> > +        maximum: 3
> > +
> > +  compatible:
> > +    enum:
> > +      - xlnx,zynqmp-psgtr-v1.1
> > +      - xlnx,zynqmp-psgtr
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 4
> > +    description: |
> > +      Clock for each PS_MGTREFCLK[0-3] reference clock input. Unconnected
> > +      inputs shall not have an entry.
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 4
> > +    items:
> > +      pattern: "^ref[0-3]$"
> > +
> > +  reg:
> > +    items:
> > +      - description: SERDES registers block
> > +      - description: SIOU registers block
> > +
> > +  reg-names:
> > +    items:
> > +      - const: serdes
> > +      - const: siou
> > +
> > +required:
> > +  - "#phy-cells"
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      const: xlnx,zynqmp-psgtr
> > +
> > +then:
> > +  properties:
> > +    xlnx,tx-termination-fix:
> > +      description: |
> > +        Include this for fixing functional issue with the TX termination
> > +        resistance in GT, which can be out of spec for the XCZU9EG silicon
> > +        version.
> > +      type: boolean
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    phy: phy@fd400000 {
> > +      compatible = "xlnx,zynqmp-psgtr-v1.1";
> > +      reg = <0x0 0xfd400000 0x0 0x40000>,
> > +            <0x0 0xfd3d0000 0x0 0x1000>;
> > +      reg-names = "serdes", "siou";
> > +      clocks = <&refclks 3>, <&refclks 2>, <&refclks 0>;
> > +      clock-names = "ref1", "ref2", "ref3";
> > +      #phy-cells = <4>;
> > +      status = "okay";
> > +    };
> > +
> > +...
> > diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
> > index 1f3f866fae7b..f6bc83b66ae9 100644
> > --- a/include/dt-bindings/phy/phy.h
> > +++ b/include/dt-bindings/phy/phy.h
> > @@ -17,5 +17,6 @@
> >  #define PHY_TYPE_USB3		4
> >  #define PHY_TYPE_UFS		5
> >  #define PHY_TYPE_DP		6
> > +#define PHY_TYPE_SGMII		7
> >  
> >  #endif /* _DT_BINDINGS_PHY */
> > 

-- 
Regards,

Laurent Pinchart
