Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12F46DE9F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 12:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfJUKoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 06:44:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54192 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfJUKoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:44:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id i16so12730342wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=scLxrXB2JkKl6vta+3mTkAzs1I5wCAnHIXFyhshFKsc=;
        b=dysGK81OTtl6t75l0UEaZDJAkBvHfbMOONSr32fRuIoZnukYBsO03bIEDhFRqiRLuF
         1ETEdcHV+Uxpa9tn5lLintCYd1hQu3+wyFUWH+7+7Hhmh0yEBQOa5G22W5d1qIqA29lV
         416Z9dw+VYQcV/4MPjeU6oSSKLXxy/gb6+Yh7iKyPL1cCBdS7JR3gtCXDJjULMwSh9dT
         3zgirFv2ndbYtCiDgvDrMKG7ZF6iQJcRvTqo5hPvbCRUubbMCs4aI3wz1CsqSN6YEFnA
         E3/41go93Dw5cVjmfhOpEMVeGQJPGi2Oj8tRzI+EXfijisFpWvSyOByOzEi+lvvPSWJH
         23WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=scLxrXB2JkKl6vta+3mTkAzs1I5wCAnHIXFyhshFKsc=;
        b=oqn0QjeBWZKerK5QG3vjt/QcJjAWQgL30OU7RcU1yDAr0mFcLYX0NF3r3hYc9LOdKO
         6GHFMbAIbI5JTBOk9GIABuRXdhmRy+KUGBvbQsT1WePg2Zruo4bBatm1HuyDkZfL3bgP
         QKl9/PWNZ9X1MKDOo9MFzBaduramQs5BsRH31KyQtxICpGssGp4myRV/bhnAYqcYqGoN
         upzIHpJ0SOoMaA3wiaiLEPeXuw0eriYjWRomb+tXjwm3w5ppznlHfwEwiRUEqQg/0taq
         +6NWXUFouN3S2j/XTU0uXuIxqgHHBKMFGVlv5XnKt39DF9toykPuctLUNwed0sOL5xfK
         goSA==
X-Gm-Message-State: APjAAAW34pftN4N7u+/gaZLjhvDROOFYGUx3MDy2YmCNKtM09lQHEGc0
        Zie9vRIsX7aNkTEsG/GV6Jmj6Q==
X-Google-Smtp-Source: APXvYqyTGarYEKrL+o0UJk/nvWo3S5am2f5UZDs/T+KV0lTBla79+NMRHygXnrDNivC0+YnaU0B/kg==
X-Received: by 2002:a05:600c:387:: with SMTP id w7mr19099737wmd.138.1571654637571;
        Mon, 21 Oct 2019 03:43:57 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q66sm15277735wme.39.2019.10.21.03.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:43:56 -0700 (PDT)
References: <1571382865-41978-1-git-send-email-jian.hu@amlogic.com> <1571382865-41978-2-git-send-email-jian.hu@amlogic.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "Rob Herring" <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: meson: add A1 clock controller bindings
In-reply-to: <1571382865-41978-2-git-send-email-jian.hu@amlogic.com>
Date:   Mon, 21 Oct 2019 12:43:55 +0200
Message-ID: <1jv9sibcpg.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 18 Oct 2019 at 09:14, Jian Hu <jian.hu@amlogic.com> wrote:

> Add the documentation to support Amlogic A1 clock driver,
> and add A1 clock controller bindings.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  .../devicetree/bindings/clock/amlogic,a1-clkc.yaml | 143
> +++++++++++++++++++++

Those are 2 different controllers, not variants.
One description (one file) per controller please

>  include/dt-bindings/clock/a1-clkc.h                |  98 ++++++++++++++
>  include/dt-bindings/clock/a1-pll-clkc.h            |  16 +++
>  3 files changed, 257 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-clkc.h
>  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
>
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> new file mode 100644
> index 0000000..b382eebe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> @@ -0,0 +1,143 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + */
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/amlogic,a1-clkc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson A/C serials Clock Control Unit Device Tree Bindings
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +  - Jian Hu <jian.hu@jian.hu.com>
> +
> +description: |+
> +  The clock controller node should be the child of a syscon node with the
> +  required property:
> +
> +  - compatible:         Should be one of the following:
> +                        "amlogic,meson-a-analog-sysctrl", "syscon", "simple-mfd"
> +                        "amlogic,meson-a-periphs-sysctrl", "syscon", "simple-mfd"
> +
> +  Refer to the the bindings described in
> +  Documentation/devicetree/bindings/mfd/syscon.txt
> +
> +properties:
> +  "#clock-cells":
> +    const: 1
> +  compatible:
> +    - enum:
> +        - amlogic,a1-periphs-clkc
> +        - amlogic,a1-pll-clkc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 6
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 6
> +
> +required:
> +  - "#clock-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +if:
> +  properties:
> +    compatible:
> +      enum:
> +        - amlogic,a1-periphs-clkc
> +
> +then:
> +  properties:
> +    clocks:
> +      minItems: 2
> +      maxItems: 2
> +    items:
> +     - description: fixed pll gate clock
> +     - description: hifi pll gate clock
> +
> +    clock-names:
> +      minItems: 2
> +      maxItems: 2
> +      items:
> +        - const: xtal_fixpll
> +        - const: xtal_hifipll
> +
> +else:
> +  if:
> +    properties:
> +      compatible:
> +        const: amlogic,a1-pll-clkc
> +
> +  then:
> +    properties:
> +      clocks:
> +        minItems: 6
> +        maxItems: 6
> +        items:
> +         - description: Input fixed pll div2
> +         - description: Input fixed pll div3
> +         - description: Input fixed pll div5
> +         - description: Input fixed pll div7
> +         - description: Periph Hifi pll
> +         - description: Input Oscillator (usually at 24MHz)
> +
> +      clock-names:
> +        minItems: 6
> +        maxItems: 6
> +        items:
> +         - const: fclk_div2
> +         - const: fclk_div3
> +         - const: fclk_div5
> +         - const: fclk_div7
> +         - const: hifi_pll
> +         - const: xtal
> +
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    analog: system-controller@0 {
> +        compatible = "amlogic,meson-a-analog-sysctrl",
> +                     "simple-mfd", "syscon";
> +        reg = <0 0x7c00 0 0x21c>;
> +
> +        clkc_pll: pll-clock-controller {
> +                compatible = "amlogic,a1-pll-clkc";
> +                #clock-cells = <1>;
> +                clocks = <&clkc_periphs CLKID_XTAL_FIXPLL>,
> +                         <&clkc_periphs CLKID_XTAL_HIFIPLL>;
> +                clock-names = "xtal_fixpll", "xtal_hifipll";
> +        };
> +    };
> +
> +  - |
> +    periphs: system-controller@1 {
> +        compatible = "amlogic,meson-a-periphs-sysctrl",
> +                     "simple-mfd", "syscon";
> +        reg = <0 0x800 0 0x104>;
> +
> +        clkc_periphs: periphs-clock-controller {
> +                compatible = "amlogic,a1-periphs-clkc";
> +                #clock-cells = <1>;
> +                clocks = <&clkc_pll CLKID_FCLK_DIV2>,
> +                        <&clkc_pll CLKID_FCLK_DIV3>,
> +                        <&clkc_pll CLKID_FCLK_DIV5>,
> +                        <&clkc_pll CLKID_FCLK_DIV7>,
> +                        <&clkc_pll CLKID_HIFI_PLL>,
> +                        <&xtal>;
> +                clock-names = "fclk_div2", "fclk_div3", "fclk_div5",
> +                              "fclk_div7", "hifi_pll", "xtal";
> +        };
> +    };
> diff --git a/include/dt-bindings/clock/a1-clkc.h b/include/dt-bindings/clock/a1-clkc.h
> new file mode 100644
> index 0000000..1ba0112
> --- /dev/null
> +++ b/include/dt-bindings/clock/a1-clkc.h
> @@ -0,0 +1,98 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef __A1_CLKC_H
> +#define __A1_CLKC_H
> +
> +#define CLKID_XTAL_FIXPLL			1
> +#define CLKID_XTAL_USB_PHY			2
> +#define CLKID_XTAL_USB_CTRL			3
> +#define CLKID_XTAL_HIFIPLL			4
> +#define CLKID_XTAL_SYSPLL			5
> +#define CLKID_XTAL_DDS				6
> +#define CLKID_SYS_CLK				7
> +#define CLKID_CLKTREE				8
> +#define CLKID_RESET_CTRL			9
> +#define CLKID_ANALOG_CTRL			10
> +#define CLKID_PWR_CTRL				11
> +#define CLKID_PAD_CTRL				12
> +#define CLKID_SYS_CTRL				13
> +#define CLKID_TEMP_SENSOR			14
> +#define CLKID_AM2AXI_DIV			15
> +#define CLKID_SPICC_B				16
> +#define CLKID_SPICC_A				17
> +#define CLKID_CLK_MSR				18
> +#define CLKID_AUDIO				19
> +#define CLKID_JTAG_CTRL				20
> +#define CLKID_SARADC				21
> +#define CLKID_PWM_EF				22
> +#define CLKID_PWM_CD				23
> +#define CLKID_PWM_AB				24
> +#define CLKID_CEC				25
> +#define CLKID_I2C_S				26
> +#define CLKID_IR_CTRL				27
> +#define CLKID_I2C_M_D				28
> +#define CLKID_I2C_M_C				29
> +#define CLKID_I2C_M_B				30
> +#define CLKID_I2C_M_A				31
> +#define CLKID_ACODEC				32
> +#define CLKID_OTP				33
> +#define CLKID_SD_EMMC_A				34
> +#define CLKID_USB_PHY				35
> +#define CLKID_USB_CTRL				36
> +#define CLKID_SYS_DSPB				37
> +#define CLKID_SYS_DSPA				38
> +#define CLKID_DMA				39
> +#define CLKID_IRQ_CTRL				40
> +#define CLKID_NIC				41
> +#define CLKID_GIC				42
> +#define CLKID_UART_C				43
> +#define CLKID_UART_B				44
> +#define CLKID_UART_A				45
> +#define CLKID_SYS_PSRAM				46
> +#define CLKID_RSA				47
> +#define CLKID_CORESIGHT				48
> +#define CLKID_AM2AXI_VAD			49
> +#define CLKID_AUDIO_VAD				50
> +#define CLKID_AXI_DMC				51
> +#define CLKID_AXI_PSRAM				52
> +#define CLKID_RAMB				53
> +#define CLKID_RAMA				54
> +#define CLKID_AXI_SPIFC				55
> +#define CLKID_AXI_NIC				56
> +#define CLKID_AXI_DMA				57
> +#define CLKID_CPU_CTRL				58
> +#define CLKID_ROM				59
> +#define CLKID_PROC_I2C				60
> +#define CLKID_DSPA_SEL				61
> +#define CLKID_DSPB_SEL				62
> +#define CLKID_DSPA_EN_DSPA			63
> +#define CLKID_DSPA_EN_NIC			64
> +#define CLKID_DSPB_EN_DSPB			65
> +#define CLKID_DSPB_EN_NIC			66
> +#define CLKID_RTC_CLK				67
> +#define CLKID_CECA_32K				68
> +#define CLKID_CECB_32K				69
> +#define CLKID_24M				70
> +#define CLKID_12M				71
> +#define CLKID_FCLK_DIV2_DIVN			72
> +#define CLKID_GEN				73
> +#define CLKID_SARADC_SEL			74
> +#define CLKID_SARADC_CLK			75
> +#define CLKID_PWM_A				76
> +#define CLKID_PWM_B				77
> +#define CLKID_PWM_C				78
> +#define CLKID_PWM_D				79
> +#define CLKID_PWM_E				80
> +#define CLKID_PWM_F				81
> +#define CLKID_SPICC				82
> +#define CLKID_TS				83
> +#define CLKID_SPIFC				84
> +#define CLKID_USB_BUS				85
> +#define CLKID_SD_EMMC				86
> +#define CLKID_PSRAM				87
> +#define CLKID_DMC				88
> +
> +#endif /* __A1_CLKC_H */
> diff --git a/include/dt-bindings/clock/a1-pll-clkc.h b/include/dt-bindings/clock/a1-pll-clkc.h
> new file mode 100644
> index 0000000..58eae23
> --- /dev/null
> +++ b/include/dt-bindings/clock/a1-pll-clkc.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef __A1_PLL_CLKC_H
> +#define __A1_PLL_CLKC_H
> +
> +#define CLKID_FIXED_PLL				1
> +#define CLKID_FCLK_DIV2				6
> +#define CLKID_FCLK_DIV3				7
> +#define CLKID_FCLK_DIV5				8
> +#define CLKID_FCLK_DIV7				9
> +#define CLKID_HIFI_PLL				10
> +
> +#endif /* __A1_PLL_CLKC_H */

