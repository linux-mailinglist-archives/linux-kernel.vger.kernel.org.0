Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 589DB18D591
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 18:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgCTRSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 13:18:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39029 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCTRSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:18:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id d25so3593214pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j+3NiBvl2a3wWDm0zyp2jY9H8e489TocevGvrI9+UkA=;
        b=R3CgiM9+cjth7NV8DlMsD4eWaO9HxY2zUQetBq6kbBlTfiKf2XRvDeZrabGxIK7XhK
         DpFXwUvVoMDD1SIQLAxMDDJ2ahjIE0ayQNqOhJKNcCsinws8/pmX+Ik+bDj4bWZDvx02
         zONz6ea23pZAC5yagYaUCajnT6X9vQoCDU8LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j+3NiBvl2a3wWDm0zyp2jY9H8e489TocevGvrI9+UkA=;
        b=mfrjp2rkJW6bnsvxQS96low2tRX/v/t6ihI2gU0bElT0c4f8AHdfgr0XPR0gjldIUH
         czOiZ9ni5AZxdIhMWMi+OStH0xw3thGwnqgjCAQLbdvNKFxAIhC3/OxQSWBGP2iGAgAK
         td1anPEGTNN2LrC9cfb6VjBQ6nQoqkq4pqOKZuzoTzu2+Houyh+xg2uyiTl1lQqlz/3T
         zRb7k6+u6rGwmVJPkV3Bn2MZuLQS7q9m1nCvGi4vjzwOb+LMJQb5c5fJUL1V2YU6dx1h
         QDRb3vsEAvRzhU8uo66VT4gPeKzCfU2g4nsmgdibg30Pki3HU+OQm6e5MvHefoef9coa
         Fo9g==
X-Gm-Message-State: ANhLgQ0X33XypXHeJeCYLYoppFm79zbSAFdB5RJBeQ5omOhdfXqnwOrC
        fN+E1n2GDeQ6RIxABvPWTeL3WA==
X-Google-Smtp-Source: ADFU+vsCE7N/v3n8ragv/ocLtaLBtRuSCa+VrD2EOvAy1i5UWITw7NQLdcRgvJ0Obz7o6qVuJ/OKEg==
X-Received: by 2002:a62:18cf:: with SMTP id 198mr10983261pfy.277.1584724723952;
        Fri, 20 Mar 2020 10:18:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id gv7sm5380940pjb.16.2020.03.20.10.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 10:18:42 -0700 (PDT)
Date:   Fri, 20 Mar 2020 10:18:41 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: phy: qcom,qmp: Convert QMP PHY
 bindings to yaml
Message-ID: <20200320171841.GB204494@google.com>
References: <1583928252-21246-1-git-send-email-sanm@codeaurora.org>
 <1583928252-21246-2-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1583928252-21246-2-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeep,

I fear this needs yet another re-spin since the PHY tree now has commit
0347f0dcbd2f0e ("phy: qcom-qmp: Add MSM8996 UFS QMP support").

On Wed, Mar 11, 2020 at 05:34:09PM +0530, Sandeep Maheswaram wrote:
> Convert QMP PHY bindings to DT schema format using json-schema.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  .../devicetree/bindings/phy/qcom,qmp-phy.yaml      | 311 +++++++++++++++++++++
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 237 ----------------
>  2 files changed, 311 insertions(+), 237 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> new file mode 100644
> index 0000000..39ec3f24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -0,0 +1,311 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/qcom,qmp-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm QMP PHY controller
> +
> +maintainers:
> +  - Manu Gautam <mgautam@codeaurora.org>
> +
> +description:
> +  QMP phy controller supports physical layer functionality for a number of
> +  controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq8074-qmp-pcie-phy
> +      - qcom,msm8996-qmp-pcie-phy
> +      - qcom,msm8996-qmp-usb3-phy
> +      - qcom,msm8998-qmp-pcie-phy
> +      - qcom,msm8998-qmp-ufs-phy
> +      - qcom,msm8998-qmp-usb3-phy
> +      - qcom,sdm845-qhp-pcie-phy
> +      - qcom,sdm845-qmp-pcie-phy
> +      - qcom,sdm845-qmp-ufs-phy
> +      - qcom,sdm845-qmp-usb3-phy
> +      - qcom,sdm845-qmp-usb3-uni-phy
> +      - qcom,sm8150-qmp-ufs-phy
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: Address and length of PHY's common serdes block.
> +      - description: Address and length of the DP_COM control block.
> +
> +  reg-names:
> +    items:
> +      - const: reg-base
> +      - const: dp_com
> +
> +  "#clock-cells":
> +     enum: [ 1, 2 ]
> +
> +  "#address-cells":
> +    enum: [ 1, 2 ]
> +
> +  "#size-cells":
> +    enum: [ 1, 2 ]
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 4
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4
> +
> +  resets:
> +    minItems: 1
> +    maxItems: 3
> +
> +  reset-names:
> +    minItems: 1
> +    maxItems: 3
> +
> +  vdda-phy-supply:
> +    description:
> +        Phandle to a regulator supply to PHY core block.
> +
> +  vdda-pll-supply:
> +    description:
> +        Phandle to 1.8V regulator supply to PHY refclk pll block.
> +
> +  vddp-ref-clk-supply:
> +    description:
> +        Phandle to a regulator supply to any specific refclk
> +        pll block.
> +
> +#Required nodes:
> +patternProperties:
> +  "^phy@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Each device node of QMP phy is required to have as many child nodes as
> +      the number of lanes the PHY has.
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - "#address-cells"
> +  - "#size-cells"
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - vdda-phy-supply
> +  - vdda-pll-supply
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdm845-qmp-usb3-phy
> +              - qcom,sdm845-qmp-usb3-uni-phy
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Phy aux clock.
> +            - description: Phy config clock.
> +            - description: 19.2 MHz ref clk.
> +            - description: Phy common block aux clock.
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: cfg_ahb
> +            - const: ref
> +            - const: com_aux
> +        resets:
> +          items:
> +            - description: reset of phy block.
> +            - description: phy common block reset.
> +        reset-names:
> +          items:
> +            - const: phy
> +            - const: common
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8996-qmp-pcie-phy
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Phy aux clock.
> +            - description: Phy config clock.
> +            - description: 19.2 MHz ref clk.
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: cfg_ahb
> +            - const: ref
> +        resets:
> +          items:
> +            - description: reset of phy block.
> +            - description: phy common block reset.
> +            - description: phy's ahb cfg block reset.
> +        reset-names:
> +          items:
> +            - const: phy
> +            - const: common
> +            - const: cfg
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8996-qmp-usb3-phy
> +              - qcom,msm8998-qmp-pcie-phy
> +              - qcom,msm8998-qmp-usb3-phy
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Phy aux clock.
> +            - description: Phy config clock.
> +            - description: 19.2 MHz ref clk.
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: cfg_ahb
> +            - const: ref
> +        resets:
> +          items:
> +            - description: reset of phy block.
> +            - description: phy common block reset.
> +        reset-names:
> +          items:
> +             - const: phy
> +             - const: common
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8998-qmp-ufs-phy
> +              - qcom,sdm845-qmp-ufs-phy
> +              - qcom,sm8150-qmp-ufs-phy
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: 19.2 MHz ref clk.
> +            - description: Phy reference aux clock.
> +        clock-names:
> +          items:
> +            - const: ref
> +            - const: ref_aux
> +        resets:
> +          items:
> +            - description: PHY reset in the UFS controller.
> +        reset-names:
> +          items:
> +            - const: ufsphy
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq8074-qmp-pcie-phy
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: pipe clk.
> +        clock-names:
> +          items:
> +            - const: pipe_clk
> +        resets:
> +          items:
> +            - description: reset of phy block.
> +            - description: phy common block reset.
> +        reset-names:
> +          items:
> +            - const: phy
> +            - const: common
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdm845-qhp-pcie-phy
> +              - qcom,sdm845-qmp-pcie-phy
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Phy aux clock.
> +            - description: Phy config clock.
> +            - description: 19.2 MHz ref clk.
> +            - description: Phy refgen clk.
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: cfg_ahb
> +            - const: ref
> +            - const: refgen
> +        resets:
> +          items:
> +            - description: reset of phy block.
> +        reset-names:
> +          items:
> +            - const: phy
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,sdm845-qmp-usb3-phy
> +    then:
> +      required:
> +        - reg-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +    usb_1_qmpphy: phy-wrapper@88e9000 {
> +        compatible = "qcom,sdm845-qmp-usb3-phy";
> +        reg = <0 0x088e9000 0 0x18c>,
> +              <0 0x088e8000 0 0x10>;
> +        reg-names = "reg-base", "dp_com";
> +        #clock-cells = <1>;
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +                 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +                 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> +                 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> +        clock-names = "aux", "cfg_ahb", "ref", "com_aux";
> +
> +        resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
> +                 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
> +        reset-names = "phy", "common";
> +
> +        vdda-phy-supply = <&vdda_usb2_ss_1p2>;
> +        vdda-pll-supply = <&vdda_usb2_ss_core>;
> +
> +        usb_1_ssphy: phy@88e9200 {
> +                reg = <0 0x088e9200 0 0x128>,
> +                      <0 0x088e9400 0 0x200>,
> +                      <0 0x088e9c00 0 0x218>,
> +                      <0 0x088e9600 0 0x128>,
> +                      <0 0x088e9800 0 0x200>,
> +                      <0 0x088e9a00 0 0x100>;
> +                #clock-cells = <0>;
> +                #phy-cells = <0>;
> +                clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +                clock-names = "pipe0";
> +                clock-output-names = "usb3_phy_pipe_clk_src";
> +            };
> +        };
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> deleted file mode 100644
> index a214ce6..0000000
> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> +++ /dev/null
> @@ -1,237 +0,0 @@
> -Qualcomm QMP PHY controller
> -===========================
> -
> -QMP phy controller supports physical layer functionality for a number of
> -controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
> -
> -Required properties:
> - - compatible: compatible list, contains:
> -	       "qcom,ipq8074-qmp-pcie-phy" for PCIe phy on IPQ8074
> -	       "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
> -	       "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
> -	       "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,
> -	       "qcom,msm8998-qmp-ufs-phy" for UFS QMP phy on msm8998,
> -	       "qcom,msm8998-qmp-pcie-phy" for PCIe QMP phy on msm8998,
> -	       "qcom,sdm845-qhp-pcie-phy" for QHP PCIe phy on sdm845,
> -	       "qcom,sdm845-qmp-pcie-phy" for QMP PCIe phy on sdm845,
> -	       "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
> -	       "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
> -	       "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845,
> -	       "qcom,sm8150-qmp-ufs-phy" for UFS QMP phy on sm8150.
> -
> -- reg:
> -  - index 0: address and length of register set for PHY's common
> -             serdes block.
> -  - index 1: address and length of the DP_COM control block (for
> -             "qcom,sdm845-qmp-usb3-phy" only).
> -
> -- reg-names:
> -  - For "qcom,sdm845-qmp-usb3-phy":
> -    - Should be: "reg-base", "dp_com"
> -  - For all others:
> -    - The reg-names property shouldn't be defined.
> -
> - - #address-cells: must be 1
> - - #size-cells: must be 1
> - - ranges: must be present
> -
> - - clocks: a list of phandles and clock-specifier pairs,
> -	   one for each entry in clock-names.
> - - clock-names: "cfg_ahb" for phy config clock,
> -		"aux" for phy aux clock,
> -		"ref" for 19.2 MHz ref clk,
> -		"com_aux" for phy common block aux clock,
> -		"ref_aux" for phy reference aux clock,
> -
> -		For "qcom,ipq8074-qmp-pcie-phy": no clocks are listed.
> -		For "qcom,msm8996-qmp-pcie-phy" must contain:
> -			"aux", "cfg_ahb", "ref".
> -		For "qcom,msm8996-qmp-usb3-phy" must contain:
> -			"aux", "cfg_ahb", "ref".
> -		For "qcom,msm8998-qmp-usb3-phy" must contain:
> -			"aux", "cfg_ahb", "ref".
> -		For "qcom,msm8998-qmp-ufs-phy" must contain:
> -			"ref", "ref_aux".
> -		For "qcom,msm8998-qmp-pcie-phy" must contain:
> -			"aux", "cfg_ahb", "ref".
> -		For "qcom,sdm845-qhp-pcie-phy" must contain:
> -			"aux", "cfg_ahb", "ref", "refgen".
> -		For "qcom,sdm845-qmp-pcie-phy" must contain:
> -			"aux", "cfg_ahb", "ref", "refgen".
> -		For "qcom,sdm845-qmp-usb3-phy" must contain:
> -			"aux", "cfg_ahb", "ref", "com_aux".
> -		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
> -			"aux", "cfg_ahb", "ref", "com_aux".
> -		For "qcom,sdm845-qmp-ufs-phy" must contain:
> -			"ref", "ref_aux".
> -		For "qcom,sm8150-qmp-ufs-phy" must contain:
> -			"ref", "ref_aux".
> -
> - - resets: a list of phandles and reset controller specifier pairs,
> -	   one for each entry in reset-names.
> - - reset-names: "phy" for reset of phy block,
> -		"common" for phy common block reset,
> -		"cfg" for phy's ahb cfg block reset,
> -		"ufsphy" for the PHY reset in the UFS controller.
> -
> -		For "qcom,ipq8074-qmp-pcie-phy" must contain:
> -			"phy", "common".
> -		For "qcom,msm8996-qmp-pcie-phy" must contain:
> -			"phy", "common", "cfg".
> -		For "qcom,msm8996-qmp-usb3-phy" must contain
> -			"phy", "common".
> -		For "qcom,msm8998-qmp-usb3-phy" must contain
> -			"phy", "common".
> -		For "qcom,msm8998-qmp-ufs-phy": must contain:
> -			"ufsphy".
> -		For "qcom,msm8998-qmp-pcie-phy" must contain:
> -			"phy", "common".
> -		For "qcom,sdm845-qhp-pcie-phy" must contain:
> -			"phy".
> -		For "qcom,sdm845-qmp-pcie-phy" must contain:
> -			"phy".
> -		For "qcom,sdm845-qmp-usb3-phy" must contain:
> -			"phy", "common".
> -		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
> -			"phy", "common".
> -		For "qcom,sdm845-qmp-ufs-phy": must contain:
> -			"ufsphy".
> -		For "qcom,sm8150-qmp-ufs-phy": must contain:
> -			"ufsphy".
> -
> - - vdda-phy-supply: Phandle to a regulator supply to PHY core block.
> - - vdda-pll-supply: Phandle to 1.8V regulator supply to PHY refclk pll block.
> -
> -Optional properties:
> - - vddp-ref-clk-supply: Phandle to a regulator supply to any specific refclk
> -			pll block.
> -
> -Required nodes:
> - - Each device node of QMP phy is required to have as many child nodes as
> -   the number of lanes the PHY has.
> -
> -Required properties for child nodes of PCIe PHYs (one child per lane):
> - - reg: list of offset and length pairs of register sets for PHY blocks -
> -	tx, rx, pcs, and pcs_misc (optional).
> - - #phy-cells: must be 0
> -
> -Required properties for a single "lanes" child node of non-PCIe PHYs:
> - - reg: list of offset and length pairs of register sets for PHY blocks
> -	For 1-lane devices:
> -		tx, rx, pcs, and (optionally) pcs_misc
> -	For 2-lane devices:
> -		tx0, rx0, pcs, tx1, rx1, and (optionally) pcs_misc
> - - #phy-cells: must be 0
> -
> -Required properties for child node of PCIe and USB3 qmp phys:
> - - clocks: a list of phandles and clock-specifier pairs,
> -	   one for each entry in clock-names.
> - - clock-names: Must contain following:
> -		 "pipe<lane-number>" for pipe clock specific to each lane.
> - - clock-output-names: Name of the PHY clock that will be the parent for
> -		       the above pipe clock.
> -	For "qcom,ipq8074-qmp-pcie-phy":
> -		- "pcie20_phy0_pipe_clk"	Pipe Clock parent
> -			(or)
> -		  "pcie20_phy1_pipe_clk"
> - - #clock-cells: must be 0
> -    - Phy pll outputs pipe clocks for pipe based PHYs. These clocks are then
> -      gate-controlled by the gcc.
> -
> -Required properties for child node of PHYs with lane reset, AKA:
> -	"qcom,msm8996-qmp-pcie-phy"
> - - resets: a list of phandles and reset controller specifier pairs,
> -	   one for each entry in reset-names.
> - - reset-names: Must contain following:
> -		 "lane<lane-number>" for reset specific to each lane.
> -
> -Example:
> -	phy@34000 {
> -		compatible = "qcom,msm8996-qmp-pcie-phy";
> -		reg = <0x34000 0x488>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
> -			<&gcc GCC_PCIE_PHY_CFG_AHB_CLK>,
> -			<&gcc GCC_PCIE_CLKREF_CLK>;
> -		clock-names = "aux", "cfg_ahb", "ref";
> -
> -		vdda-phy-supply = <&pm8994_l28>;
> -		vdda-pll-supply = <&pm8994_l12>;
> -
> -		resets = <&gcc GCC_PCIE_PHY_BCR>,
> -			<&gcc GCC_PCIE_PHY_COM_BCR>,
> -			<&gcc GCC_PCIE_PHY_COM_NOCSR_BCR>;
> -		reset-names = "phy", "common", "cfg";
> -
> -		pciephy_0: lane@35000 {
> -			reg = <0x35000 0x130>,
> -				<0x35200 0x200>,
> -				<0x35400 0x1dc>;
> -			#clock-cells = <0>;
> -			#phy-cells = <0>;
> -
> -			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
> -			clock-names = "pipe0";
> -			clock-output-names = "pcie_0_pipe_clk_src";
> -			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
> -			reset-names = "lane0";
> -		};
> -
> -		pciephy_1: lane@36000 {
> -		...
> -		...
> -	};
> -
> -	phy@88eb000 {
> -		compatible = "qcom,sdm845-qmp-usb3-uni-phy";
> -		reg = <0x88eb000 0x18c>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
> -			 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> -			 <&gcc GCC_USB3_SEC_CLKREF_CLK>,
> -			 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>;
> -		clock-names = "aux", "cfg_ahb", "ref", "com_aux";
> -
> -		resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR>,
> -			 <&gcc GCC_USB3_PHY_SEC_BCR>;
> -		reset-names = "phy", "common";
> -
> -		lane@88eb200 {
> -			reg = <0x88eb200 0x128>,
> -			      <0x88eb400 0x1fc>,
> -			      <0x88eb800 0x218>,
> -			      <0x88eb600 0x70>;
> -			#clock-cells = <0>;
> -			#phy-cells = <0>;
> -			clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
> -			clock-names = "pipe0";
> -			clock-output-names = "usb3_uni_phy_pipe_clk_src";
> -		};
> -	};
> -
> -	phy@1d87000 {
> -		compatible = "qcom,sdm845-qmp-ufs-phy";
> -		reg = <0x1d87000 0x18c>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -		clock-names = "ref",
> -			      "ref_aux";
> -		clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
> -			 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> -
> -		lanes@1d87400 {
> -			reg = <0x1d87400 0x108>,
> -			      <0x1d87600 0x1e0>,
> -			      <0x1d87c00 0x1dc>,
> -			      <0x1d87800 0x108>,
> -			      <0x1d87a00 0x1e0>;
> -			#phy-cells = <0>;
> -		};
> -	};
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
