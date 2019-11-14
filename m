Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E5AFBC6A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 00:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKMXUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 18:20:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:52534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfKMXUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 18:20:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E88BB26C;
        Wed, 13 Nov 2019 23:20:29 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] arm64: dts: realtek: Add RTD1619 SoC and Realtek
 Mjolnir EVB
To:     James Tai <james.tai@realtek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        'DTML' <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
References: <73fb8106ec1a4665b59a2d187a576b71@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <9cadb78c-99af-8948-e76f-c26f263693b3@suse.de>
Date:   Thu, 14 Nov 2019 00:20:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <73fb8106ec1a4665b59a2d187a576b71@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 12.11.19 um 16:45 schrieb James Tai:
> Add Device Trees for Realtek RTD1619 SoC family, RTD1619 SoC and
> Realtek Mjolnir EVB.
> 
> Signed-off-by: James Tai <james.tai@realtek.com>
> ---

Lacking the requested changelog.

>  arch/arm64/boot/dts/realtek/Makefile          |   2 +
>  .../boot/dts/realtek/rtd1619-mjolnir.dts      |  40 +++++
>  arch/arm64/boot/dts/realtek/rtd1619.dtsi      |  12 ++
>  arch/arm64/boot/dts/realtek/rtd16xx.dtsi      | 163 ++++++++++++++++++
>  4 files changed, 217 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd1619.dtsi
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd16xx.dtsi

Somehow the last hunk (rtd16xx.dtsi) didn't apply with git-am or patch
-p1, not sure why. I have manually copied the file into place and fixed
up some more nits below:

> 
> diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
> index 555638ada721..fb5f05978ecc 100644
> --- a/arch/arm64/boot/dts/realtek/Makefile
> +++ b/arch/arm64/boot/dts/realtek/Makefile
> @@ -7,3 +7,5 @@ dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-probox2-ava.dtb
>  dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
>  
>  dtb-$(CONFIG_ARCH_REALTEK) += rtd1296-ds418.dtb
> +
> +dtb-$(CONFIG_ARCH_REALTEK) += rtd1619-mjolnir.dtb
> diff --git a/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts b/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
> new file mode 100644
> index 000000000000..6ab791af3896
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Copyright (c) 2019 Realtek Semiconductor Corp.
> + */
> +
> +/dts-v1/;
> +
> +#include "rtd1619.dtsi"
> +
> +/ {
> +	compatible = "realtek,rtd1619", "realtek,mjolnir";

Order not fixed from v2. This is a schema violation and logically wrong.

> +	model= "Realtek Mjolnir EVB";

Space missing before =. Missed that in v2.

> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	aliases {
> +		serial0 = &uart0; /* The UART0 is debug console */
> +		serial1 = &uart1; /* The UART1 is on M.2 slot */
> +		serial2 = &uart2; /* The UART2 is on GPIO connector */
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "disabled";
> +};
> +
> +&uart2 {
> +	status = "disabled";
> +};

The comments were intended to go above each node, not after the aliases.
I've taken the liberty to annotate them further with their PCB label.

> diff --git a/arch/arm64/boot/dts/realtek/rtd1619.dtsi b/arch/arm64/boot/dts/realtek/rtd1619.dtsi
> new file mode 100644
> index 000000000000..e52bf708b04e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd1619.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Realtek RTD1619 SoC
> + *
> + * Copyright (c) 2019 Realtek Semiconductor Corp.
> + */
> +
> +#include "rtd16xx.dtsi"
> +
> +/ {
> +	compatible = "realtek,rtd1619";
> +};
> diff --git a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
> new file mode 100644
> index 000000000000..d9b572a870f5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +/*
> + * Realtek RTD16xx SoC family
> + *
> + * Copyright (c) 2019 Realtek Semiconductor Corp.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/{

Space missing. Missed that in v2.

> +	interrupt-parent = <&gic>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			next-level-cache = <&l3>;
> +		};
> +
> +		cpu2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +			next-level-cache = <&l3>;
> +		};
> +
> +		cpu3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x300>;
> +			enable-method = "psci";
> +			next-level-cache = <&l3>;
> +		};
> +
> +		cpu4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x400>;
> +			enable-method = "psci";
> +			next-level-cache = <&l3>;
> +		};
> +
> +		cpu5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x500>;
> +			enable-method = "psci";
> +			next-level-cache = <&l3>;
> +		};
> +
> +		l2: l2-cache {
> +			compatible = "cache";
> +			next-level-cache = <&l3>;
> +
> +		};
> +
> +		l3: l3-cache {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	arm_pmu: pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	osc27M: osc {
> +		compatible = "fixed-clock";
> +		clock-frequency = <27000000>;
> +		clock-output-names = "osc27M";
> +		#clock-cells = <0>;
> +	};
> +
> +	soc@98000000 {

If the node has a unit address, it also needs a reg property with that
value. So let's drop the unit address.

> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x98000000 0x98000000 0x68000000>;
> +
> +		rbus: r-bus@98000000 {
> +			compatible = "simple-bus";
> +			reg = <0x98000000 0x200000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x98000000 0x200000>;
> +
> +			uart0: serial0@7800 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0x7800 0x400>;
> +				reg-shift = <2>;
> +				reg-io-width = <4>;
> +				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-frequency = <27000000>;
> +				status = "disabled";
> +			};
> +
> +			uart1: serial1@1b200 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0x1b200 0x400>;
> +				reg-shift = <2>;
> +				reg-io-width = <4>;
> +				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-frequency = <432000000>;
> +				status = "disabled";
> +			};
> +
> +			uart2: serial2@1b400 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0x1b400 0x400>;
> +				reg-shift = <2>;
> +				reg-io-width = <4>;
> +				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-frequency = <432000000>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		gic: interrupt-controller@ff100000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0xff100000 0x10000>,
> +			      <0xff140000 0xc0000>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +	};
> +};
> +
> +&arm_pmu {
> +	interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>,
> +		<&cpu3>, <&cpu4>, <&cpu5>;
> +};

Now that they're in the same file, this can just go into the node.

Queuing on my rtd1295-next branch (before RTD1395), with changes:

diff --git a/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
b/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
index 6ab791af3896..44dd67e04335 100644
--- a/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
+++ b/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
@@ -8,8 +8,8 @@
 #include "rtd1619.dtsi"

 / {
-       compatible = "realtek,rtd1619", "realtek,mjolnir";
-       model= "Realtek Mjolnir EVB";
+       compatible = "realtek,mjolnir", "realtek,rtd1619";
+       model = "Realtek Mjolnir EVB";

        memory@0 {
                device_type = "memory";
@@ -21,20 +21,23 @@
        };

        aliases {
-               serial0 = &uart0; /* The UART0 is debug console */
-               serial1 = &uart1; /* The UART1 is on M.2 slot */
-               serial2 = &uart2; /* The UART2 is on GPIO connector */
+               serial0 = &uart0;
+               serial1 = &uart1;
+               serial2 = &uart2;
        };
 };

+/* debug console (J1) */
 &uart0 {
        status = "okay";
 };

+/* M.2 slot (CON4) */
 &uart1 {
        status = "disabled";
 };

+/* GPIO connector (T1) */
 &uart2 {
        status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
b/arch/arm64/boot/dts/real
tek/rtd16xx.dtsi
index 4422fe9c5a68..f1e3c088a014 100644
--- a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
@@ -8,7 +8,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>

-/{
+/ {
        interrupt-parent = <&gic>;
        #address-cells = <1>;
        #size-cells = <1>;
@@ -87,6 +87,8 @@
        arm_pmu: pmu {
                compatible = "arm,armv8-pmuv3";
                interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+               interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>,
+                       <&cpu3>, <&cpu4>, <&cpu5>;
        };

        psci {
@@ -101,7 +103,7 @@
                #clock-cells = <0>;
        };

-       soc@98000000 {
+       soc {
                compatible = "simple-bus";
                #address-cells = <1>;
                #size-cells = <1>;
@@ -149,14 +151,9 @@
                        compatible = "arm,gic-v3";
                        reg = <0xff100000 0x10000>,
                              <0xff140000 0xc0000>;
+                       interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
                        interrupt-controller;
                        #interrupt-cells = <3>;
-                       interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
                };
        };
 };
-
-&arm_pmu {
-       interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>,
-               <&cpu3>, <&cpu4>, <&cpu5>;
-};

Waiting on Rob for the underlying binding (and for v5.5-rc1 tag).

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
