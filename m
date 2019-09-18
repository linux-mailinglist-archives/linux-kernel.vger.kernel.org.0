Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC50BB69F2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 19:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387479AbfIRRxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 13:53:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42381 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387428AbfIRRxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:53:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so462421pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zPkmWhTEOgVWyMbCMBPQIeNFinodsP7S1cmh7eh7uPg=;
        b=kKksnrzJRE5Gj39bk/xIPqJyuWBFe9meU0J2qB10Qq7kZbI2oF9/Ys8VNFMj3LAt24
         W1ilCkKo9MwiKaaoOOCcmgDHSCqjUjKeO8/UF43QaipA17lQdfdLoFkOGJ88RrRF6Omh
         SKCY3/se9We+H6LJSp7OhUHe8ps5g/0juIqLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zPkmWhTEOgVWyMbCMBPQIeNFinodsP7S1cmh7eh7uPg=;
        b=johbJ21xdOrzMRAJAjQ07iOqbbD8jFqoshU+EZnlQbSKn5dGqVpH9mh2ZDLbif81co
         RQ2XIIuMYgaZrAO49Aj6Nh3UoBkiWjgjtjDBpbT/N2G9DN5Q+NnYWx7JskEfJckEGQUB
         D0SpE53potX49+3yYMt7oTLc7fFSobpKRtxrDKvM9a3jw+Gfcm8N62ENfKRk9gVelp/3
         53Vca7Q6Ljq1Bd8Xn9OcYtOtHLAEd3wYm4l45RiP90V8ipnSvnnLBP4e5xvxUMCH9DiZ
         A5yl/Z/eyUCMZGFvVVra2oUAAl7gFeCprV4MIatGKfUM5eFgXlV2cWUtG+LKBGKJqrh5
         e9kA==
X-Gm-Message-State: APjAAAVebcEP/APaQieeYM5XJkC7ReHTzOGb7SSldm7HZHLOqJh2R82/
        XQGWrc9Fmx/gymQpDoW8VUw48A==
X-Google-Smtp-Source: APXvYqyDSDByYnU4omzQnLNajzuNIdwyaNrSFDYZ1pBp+EJgXvKHvtAUw74sz6Jl20YLNOQBgDyfIQ==
X-Received: by 2002:a63:c09:: with SMTP id b9mr4985093pgl.245.1568829183014;
        Wed, 18 Sep 2019 10:53:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 69sm8362930pfb.145.2019.09.18.10.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 10:53:02 -0700 (PDT)
Date:   Wed, 18 Sep 2019 10:52:56 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette =?utf-8?B?wqA=?= <mturquette@baylibre.com>,
        robh+dt@kernel.org, David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: clk: qcom: Add YAML schemas for the
 GCC clock bindings
Message-ID: <20190918175256.GM133864@google.com>
References: <20190918095018.17979-1-tdas@codeaurora.org>
 <20190918095018.17979-3-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190918095018.17979-3-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

not a full review, just a couple of things I noticed, comments inline.

On Wed, Sep 18, 2019 at 03:20:17PM +0530, Taniya Das wrote:
> The GCC clock provider have a bunch of generic properties that
> are needed in a device tree. Add a YAML schemas for those. Also update
> the compatible for SC7180 along with example for clocks & clock-names.

I would suggest to split this in two:

1. conversion to YAML
2. add SC7180 header and example

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,gcc.txt    |  94 -----------
>  .../devicetree/bindings/clock/qcom,gcc.yaml   | 157 ++++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-sc7180.h   | 155 +++++++++++++++++
>  3 files changed, 312 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-sc7180.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
> deleted file mode 100644
> index d14362ad4132..000000000000
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt
> +++ /dev/null
> @@ -1,94 +0,0 @@
> -Qualcomm Global Clock & Reset Controller Binding
> -------------------------------------------------
> -
> -Required properties :
> -- compatible : shall contain only one of the following:
> -
> -			"qcom,gcc-apq8064"
> -			"qcom,gcc-apq8084"
> -			"qcom,gcc-ipq8064"
> -			"qcom,gcc-ipq4019"
> -			"qcom,gcc-ipq8074"
> -			"qcom,gcc-msm8660"
> -			"qcom,gcc-msm8916"
> -			"qcom,gcc-msm8960"
> -			"qcom,gcc-msm8974"
> -			"qcom,gcc-msm8974pro"
> -			"qcom,gcc-msm8974pro-ac"
> -			"qcom,gcc-msm8994"
> -			"qcom,gcc-msm8996"
> -			"qcom,gcc-msm8998"
> -			"qcom,gcc-mdm9615"
> -			"qcom,gcc-qcs404"
> -			"qcom,gcc-sdm630"
> -			"qcom,gcc-sdm660"
> -			"qcom,gcc-sdm845"
> -			"qcom,gcc-sm8150"
> -
> -- reg : shall contain base register location and length
> -- #clock-cells : shall contain 1
> -- #reset-cells : shall contain 1
> -
> -Optional properties :
> -- #power-domain-cells : shall contain 1
> -- Qualcomm TSENS (thermal sensor device) on some devices can
> -be part of GCC and hence the TSENS properties can also be
> -part of the GCC/clock-controller node.
> -For more details on the TSENS properties please refer
> -Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> -- protected-clocks : Protected clock specifier list as per common clock
> - binding.
> -
> -For SM8150 only:
> -       - clocks: a list of phandles and clock-specifier pairs,
> -                 one for each entry in clock-names.
> -       - clock-names: "bi_tcxo" (required)
> -                      "sleep_clk" (optional)
> -                      "aud_ref_clock" (optional)
> -
> -Example:
> -	clock-controller@900000 {
> -		compatible = "qcom,gcc-msm8960";
> -		reg = <0x900000 0x4000>;
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -		#power-domain-cells = <1>;
> -	};
> -
> -Example of GCC with TSENS properties:
> -	clock-controller@900000 {
> -		compatible = "qcom,gcc-apq8064";
> -		reg = <0x00900000 0x4000>;
> -		nvmem-cells = <&tsens_calib>, <&tsens_backup>;
> -		nvmem-cell-names = "calib", "calib_backup";
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -		#thermal-sensor-cells = <1>;
> -	};
> -
> -Example of GCC with protected-clocks properties:
> -	clock-controller@100000 {
> -		compatible = "qcom,gcc-sdm845";
> -		reg = <0x100000 0x1f0000>;
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -		#power-domain-cells = <1>;
> -		protected-clocks = <GCC_QSPI_CORE_CLK>,
> -				   <GCC_QSPI_CORE_CLK_SRC>,
> -				   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
> -				   <GCC_LPASS_Q6_AXI_CLK>,
> -				   <GCC_LPASS_SWAY_CLK>;
> -	};
> -
> -Example of GCC with clocks
> -	gcc: clock-controller@100000 {
> -		compatible = "qcom,gcc-sm8150";
> -		reg = <0x00100000 0x1f0000>;
> -		#clock-cells = <1>;
> -		#reset-cells = <1>;
> -		#power-domain-cells = <1>;
> -		clock-names = "bi_tcxo",
> -		              "sleep_clk";
> -		clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> -			 <&sleep_clk>;
> -	};
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> new file mode 100644
> index 000000000000..056a7977c458
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> @@ -0,0 +1,157 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller Binding
> +
> +maintainers:
> +  - Stephen Boyd <sboyd@kernel.org>
> +
> +properties:
> +  "#clock-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  compatible :
> +     enum:
> +       - qcom,gcc-apq8064
> +       - qcom,gcc-apq8084
> +       - qcom,gcc-ipq8064
> +       - qcom,gcc-ipq4019
> +       - qcom,gcc-ipq8074
> +       - qcom,gcc-msm8660
> +       - qcom,gcc-msm8916
> +       - qcom,gcc-msm8960
> +       - qcom,gcc-msm8974
> +       - qcom,gcc-msm8974pro
> +       - qcom,gcc-msm8974pro-ac
> +       - qcom,gcc-msm8994
> +       - qcom,gcc-msm8996
> +       - qcom,gcc-msm8998
> +       - qcom,gcc-mdm9615
> +       - qcom,gcc-qcs404
> +       - qcom,gcc-sdm630
> +       - qcom,gcc-sdm660
> +       - qcom,gcc-sdm845
> +       - qcom,gcc-sm8150
> +       - qcom,gcc-sc7180
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +    items:
> +      - description: Board XO source
> +      - description: Board active XO source
> +      - description: Sleep clock source(optional)
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 3
> +    items:
> +      - const: bi_tcxo
> +      - const: bi_tcxo_ao
> +      - const: sleep_clk
> +
> +  nvmem-cells:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      Qualcomm TSENS (thermal sensor device) on some devices can
> +      be part of GCC and hence the TSENS properties can also be part
> +      of the GCC/clock-controller node.
> +      For more details on the TSENS properties please refer
> +      Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +
> +  nvmem-cell-names:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      Names for each nvmem-cells specified.
> +    items:
> +      - const: calib
> +      - const: calib_backup
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +  protected-clocks:
> +    description:
> +       Protected clock specifier list as per common clock binding
> +
> +required:
> +  - "#clock-cells"
> +  - "#reset-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    // Example:
> +    clock-controller@900000 {
> +      compatible = "qcom,gcc-msm8960";
> +      reg = <0x900000 0x4000>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +    };
> +
> +
> +  - |
> +    // Example of GCC with TSENS properties:
> +    clock-controller@900000 {
> +      compatible = "qcom,gcc-apq8064";
> +      reg = <0x00900000 0x4000>;
> +      nvmem-cells = <&tsens_calib>, <&tsens_backup>;
> +      nvmem-cell-names = "calib", "calib_backup";
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #thermal-sensor-cells = <1>;
> +    };
> +
> +  - |
> +    //Example of GCC with protected-clocks properties:
> +    clock-controller@100000 {
> +      compatible = "qcom,gcc-sdm845";
> +      reg = <0x100000 0x1f0000>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +      protected-clocks = <187>, <188>, <189>, <190>, <191>;
> +    };
> +
> +  - |
> +    //Example of GCC with clock node properties for SM8150:
> +    clock-controller@100000 {
> +      compatible = "qcom,gcc-sm8150";
> +      reg = <0x00100000 0x1f0000>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +      clocks = <&rpmhcc 0>, <&rpmhcc 1>, <&sleep_clk>;
> +      clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
> +     };
> +
> +  - |
> +    //Example of GCC with clock nodes properties:

add "for SC7180"

> +    clock-controller@100000 {
> +      compatible = "qcom,gcc-sc7180";
> +      reg = <0x100000 0x1f0000>;
> +      clocks = <&rpmhcc 0>, <&rpmhcc 1>;

IIUC the ids correspond to GCC_GPLL0_MAIN_DIV_CDIV and GPLL0. If
that is correct I guess the intention is to use the constants in the
DT?

> +      clock-names = "bi_tcxo", "bi_tcxo_ao";
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +    };
> +...
> diff --git a/include/dt-bindings/clock/qcom,gcc-sc7180.h b/include/dt-bindings/clock/qcom,gcc-sc7180.h
> new file mode 100644
> index 000000000000..d76b061f6a4e
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,gcc-sc7180.h
> @@ -0,0 +1,155 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SC7180_H
> +#define _DT_BINDINGS_CLK_QCOM_GCC_SC7180_H
> +
> +/* GCC clocks */
> +#define GCC_GPLL0_MAIN_DIV_CDIV					0
> +#define GPLL0							1
> +#define GPLL0_OUT_EVEN						2
> +#define GPLL1							3
> +#define GPLL4							4
> +#define GPLL6							5
> +#define GPLL7							6
> +#define GCC_AGGRE_UFS_PHY_AXI_CLK				7
> +#define GCC_AGGRE_USB3_PRIM_AXI_CLK				8
> +#define GCC_BOOT_ROM_AHB_CLK					9
> +#define GCC_CAMERA_AHB_CLK					10
> +#define GCC_CAMERA_HF_AXI_CLK					11
> +#define GCC_CAMERA_THROTTLE_HF_AXI_CLK				12
> +#define GCC_CAMERA_XO_CLK					13
> +#define GCC_CE1_AHB_CLK						14
> +#define GCC_CE1_AXI_CLK						15
> +#define GCC_CE1_CLK						16
> +#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				17
> +#define GCC_CPUSS_AHB_CLK					18
> +#define GCC_CPUSS_AHB_CLK_SRC					19
> +#define GCC_CPUSS_GNOC_CLK					20
> +#define GCC_CPUSS_RBCPR_CLK					21
> +#define GCC_DDRSS_GPU_AXI_CLK					22
> +#define GCC_DISP_AHB_CLK					23
> +#define GCC_DISP_GPLL0_CLK_SRC					24
> +#define GCC_DISP_GPLL0_DIV_CLK_SRC				25
> +#define GCC_DISP_HF_AXI_CLK					26
> +#define GCC_DISP_THROTTLE_HF_AXI_CLK				27
> +#define GCC_DISP_XO_CLK						28
> +#define GCC_GP1_CLK						29
> +#define GCC_GP1_CLK_SRC						30
> +#define GCC_GP2_CLK						31
> +#define GCC_GP2_CLK_SRC						32
> +#define GCC_GP3_CLK						33
> +#define GCC_GP3_CLK_SRC						34
> +#define GCC_GPU_CFG_AHB_CLK					35
> +#define GCC_GPU_GPLL0_CLK_SRC					36
> +#define GCC_GPU_GPLL0_DIV_CLK_SRC				37
> +#define GCC_GPU_MEMNOC_GFX_CLK					38
> +#define GCC_GPU_SNOC_DVM_GFX_CLK				39
> +#define GCC_NPU_AXI_CLK						40
> +#define GCC_NPU_BWMON_AXI_CLK					41
> +#define GCC_NPU_BWMON_DMA_CFG_AHB_CLK				42
> +#define GCC_NPU_BWMON_DSP_CFG_AHB_CLK				43
> +#define GCC_NPU_CFG_AHB_CLK					44
> +#define GCC_NPU_DMA_CLK						45
> +#define GCC_NPU_GPLL0_CLK_SRC					46
> +#define GCC_NPU_GPLL0_DIV_CLK_SRC				47
> +#define GCC_PDM2_CLK						48
> +#define GCC_PDM2_CLK_SRC					49
> +#define GCC_PDM_AHB_CLK						50
> +#define GCC_PDM_XO4_CLK						51
> +#define GCC_PRNG_AHB_CLK					52
> +#define GCC_QSPI_CNOC_PERIPH_AHB_CLK				53
> +#define GCC_QSPI_CORE_CLK					54
> +#define GCC_QSPI_CORE_CLK_SRC					55
> +#define GCC_QUPV3_WRAP0_CORE_2X_CLK				56
> +#define GCC_QUPV3_WRAP0_CORE_CLK				57
> +#define GCC_QUPV3_WRAP0_S0_CLK					58
> +#define GCC_QUPV3_WRAP0_S0_CLK_SRC				59
> +#define GCC_QUPV3_WRAP0_S1_CLK					60
> +#define GCC_QUPV3_WRAP0_S1_CLK_SRC				61
> +#define GCC_QUPV3_WRAP0_S2_CLK					62
> +#define GCC_QUPV3_WRAP0_S2_CLK_SRC				63
> +#define GCC_QUPV3_WRAP0_S3_CLK					64
> +#define GCC_QUPV3_WRAP0_S3_CLK_SRC				65
> +#define GCC_QUPV3_WRAP0_S4_CLK					66
> +#define GCC_QUPV3_WRAP0_S4_CLK_SRC				67
> +#define GCC_QUPV3_WRAP0_S5_CLK					68
> +#define GCC_QUPV3_WRAP0_S5_CLK_SRC				69
> +#define GCC_QUPV3_WRAP1_CORE_2X_CLK				70
> +#define GCC_QUPV3_WRAP1_CORE_CLK				71
> +#define GCC_QUPV3_WRAP1_S0_CLK					72
> +#define GCC_QUPV3_WRAP1_S0_CLK_SRC				73
> +#define GCC_QUPV3_WRAP1_S1_CLK					74
> +#define GCC_QUPV3_WRAP1_S1_CLK_SRC				75
> +#define GCC_QUPV3_WRAP1_S2_CLK					76
> +#define GCC_QUPV3_WRAP1_S2_CLK_SRC				77
> +#define GCC_QUPV3_WRAP1_S3_CLK					78
> +#define GCC_QUPV3_WRAP1_S3_CLK_SRC				79
> +#define GCC_QUPV3_WRAP1_S4_CLK					80
> +#define GCC_QUPV3_WRAP1_S4_CLK_SRC				81
> +#define GCC_QUPV3_WRAP1_S5_CLK					82
> +#define GCC_QUPV3_WRAP1_S5_CLK_SRC				83
> +#define GCC_QUPV3_WRAP_0_M_AHB_CLK				84
> +#define GCC_QUPV3_WRAP_0_S_AHB_CLK				85
> +#define GCC_QUPV3_WRAP_1_M_AHB_CLK				86
> +#define GCC_QUPV3_WRAP_1_S_AHB_CLK				87
> +#define GCC_SDCC1_AHB_CLK					88
> +#define GCC_SDCC1_APPS_CLK					89
> +#define GCC_SDCC1_APPS_CLK_SRC					90
> +#define GCC_SDCC1_ICE_CORE_CLK					91
> +#define GCC_SDCC1_ICE_CORE_CLK_SRC				92
> +#define GCC_SDCC2_AHB_CLK					93
> +#define GCC_SDCC2_APPS_CLK					94
> +#define GCC_SDCC2_APPS_CLK_SRC					95
> +#define GCC_SYS_NOC_CPUSS_AHB_CLK				96
> +#define GCC_UFS_MEM_CLKREF_CLK					97
> +#define GCC_UFS_PHY_AHB_CLK					98
> +#define GCC_UFS_PHY_AXI_CLK					99
> +#define GCC_UFS_PHY_AXI_CLK_SRC					100
> +#define GCC_UFS_PHY_ICE_CORE_CLK				101
> +#define GCC_UFS_PHY_ICE_CORE_CLK_SRC				102
> +#define GCC_UFS_PHY_PHY_AUX_CLK					103
> +#define GCC_UFS_PHY_PHY_AUX_CLK_SRC				104
> +#define GCC_UFS_PHY_RX_SYMBOL_0_CLK				105
> +#define GCC_UFS_PHY_TX_SYMBOL_0_CLK				106
> +#define GCC_UFS_PHY_UNIPRO_CORE_CLK				107
> +#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC				108
> +#define GCC_USB30_PRIM_MASTER_CLK				109
> +#define GCC_USB30_PRIM_MASTER_CLK_SRC				110
> +#define GCC_USB30_PRIM_MOCK_UTMI_CLK				111
> +#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			112
> +#define GCC_USB30_PRIM_SLEEP_CLK				113
> +#define GCC_USB3_PRIM_CLKREF_CLK				114
> +#define GCC_USB3_PRIM_PHY_AUX_CLK				115
> +#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				116
> +#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				117
> +#define GCC_USB3_PRIM_PHY_PIPE_CLK				118
> +#define GCC_USB_PHY_CFG_AHB2PHY_CLK				119
> +#define GCC_VIDEO_AHB_CLK					120
> +#define GCC_VIDEO_AXI_CLK					121
> +#define GCC_VIDEO_GPLL0_DIV_CLK_SRC				122
> +#define GCC_VIDEO_THROTTLE_AXI_CLK				123
> +#define GCC_VIDEO_XO_CLK					124
> +
> +/* GCC resets */
> +#define GCC_QUSB2PHY_PRIM_BCR					0
> +#define GCC_QUSB2PHY_SEC_BCR					1
> +#define GCC_UFS_PHY_BCR						2
> +#define GCC_USB30_PRIM_BCR					3
> +#define GCC_USB3_DP_PHY_PRIM_BCR				4
> +#define GCC_USB3_DP_PHY_SEC_BCR					5
> +#define GCC_USB3_PHY_PRIM_BCR					6
> +#define GCC_USB3_PHY_SEC_BCR					7
> +#define GCC_USB3PHY_PHY_PRIM_BCR				8
> +#define GCC_USB3PHY_PHY_SEC_BCR					9
> +#define GCC_USB_PHY_CFG_AHB2PHY_BCR				10
> +
> +/* GCC GDSCRs */
> +#define UFS_PHY_GDSC						0
> +#define USB30_PRIM_GDSC						1
> +#define HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC			2
> +#define HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC			3
> +
> +#endif
