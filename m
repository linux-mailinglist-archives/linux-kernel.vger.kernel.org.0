Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D1E342AA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 11:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfFDJIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 05:08:00 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10647 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfFDJH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:07:59 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf634ed0000>; Tue, 04 Jun 2019 02:07:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 04 Jun 2019 02:07:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 04 Jun 2019 02:07:57 -0700
Received: from [10.26.11.158] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Jun
 2019 09:07:55 +0000
Subject: Re: [PATCH 1/2] arm64: tegra: add ACONNECT, ADMA and AGIC nodes
To:     Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1557143908-5850-1-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9f9962fc-a261-aecc-b4c5-408a75ebcb5f@nvidia.com>
Date:   Tue, 4 Jun 2019 10:07:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1557143908-5850-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559639277; bh=W8UdYZLraYxD4+0Ke/wC7x//2u3askjjeOYkjgGXURE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AvoTOcWVfpF2SdHPUh/uMZUMX5Nyr54VUrZeXYZ2kV/o8FhUdnr/OyoA8bdltZRWj
         mQxKww8XdjkrcXnhUM/Oowis804Gke8eFBpNCHFgsC6SMFxaPSGqromOox4DNUFYm0
         KT2HEF2VDEhLaXvNV92wXET+zis9kzUijOF0SQtxtx60yq+QP/Y4y7ue793KOe9aaH
         t+kB13MXRngraXpBjzhjEYlY4+K4VydgO1pAGpvxdaj1YFx/l0RmrxeXxM412oyz9i
         UnNHUqhT7UIJ3/EXivHsDvmL1OMfQ5+J5hCyC+8YjphGPVixRXOzY/s+ELUGBJWjnU
         GMg9t2lodF9Bg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/05/2019 12:58, Sameer Pujar wrote:
> Add DT nodes for following devices on Tegra186 and Tegra194
>  * ACONNECT
>  * ADMA
>  * AGIC
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 67 ++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 67 ++++++++++++++++++++++++++++++++
>  2 files changed, 134 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index 6e2b6ce..2c432c9 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -1153,4 +1153,71 @@
>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>  		interrupt-parent = <&gic>;
>  	};
> +
> +	aconnect@2a41000 {
> +		compatible = "nvidia,tegra210-aconnect";
> +		clocks = <&bpmp TEGRA186_CLK_APE>,
> +			 <&bpmp TEGRA186_CLK_APB2APE>;
> +		clock-names = "ape", "apb2ape";
> +		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_AUD>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;

My recollection is that non-empty range is preferred from what Rob told
me in the past. See the Tegra210 binding.

> +		status = "disabled";
> +
> +		dma@2930000 {

Although I did not do this for Tegra210, I think that the preferred
convention is 'dma-controller@xxxxxxxxx'.

> +			compatible = "nvidia,tegra186-adma";
> +			reg = <0x0 0x02930000 0x0 0x50000>;
> +			interrupt-parent = <&agic>;
> +			interrupts =  <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH 0>;
> +			#dma-cells = <1>;
> +			clocks = <&bpmp TEGRA186_CLK_AHUB>;
> +			clock-names = "d_audio";
> +			status = "disabled";
> +		};
> +
> +		agic: agic@2a41000 {
> +			compatible = "nvidia,tegra210-agic";
> +			#interrupt-cells = <4>;

Why 4? This does not match the binding document for the arm-gic.

> +			interrupt-controller;
> +			reg = <0x0 0x02a41000 0x0 0x1000>,
> +			      <0x0 0x02a42000 0x0 0x1000>;

I believe that the 2nd address range should have size 0x2000 for the CPU
interfaces.

> +			interrupts = <GIC_SPI 145 (GIC_CPU_MASK_SIMPLE(4) |
> +					IRQ_TYPE_LEVEL_HIGH)>;
> +			clocks = <&bpmp TEGRA186_CLK_APE>;
> +			clock-names = "clk";
> +			status = "disabled";
> +		};
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index c77ca21..dcab504 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -1054,4 +1054,71 @@
>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>  		interrupt-parent = <&gic>;
>  	};
> +
> +	aconnect@2a41000 {
> +		compatible = "nvidia,tegra210-aconnect";
> +		clocks = <&bpmp TEGRA194_CLK_APE>,
> +			 <&bpmp TEGRA194_CLK_APB2APE>;
> +		clock-names = "ape", "apb2ape";
> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_AUD>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;

Same as above.

> +		status = "disabled";
> +
> +		dma@2930000 {

Same as above.

> +			compatible = "nvidia,tegra186-adma";
> +			reg = <0x0 0x02930000 0x0 0x50000>;
> +			interrupt-parent = <&agic>;
> +			interrupts =  <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH 0>,
> +				      <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH 0>;
> +			#dma-cells = <1>;
> +			clocks = <&bpmp TEGRA194_CLK_AHUB>;
> +			clock-names = "d_audio";
> +			status = "disabled";
> +		};
> +
> +		agic: agic@2a41000 {
> +			compatible = "nvidia,tegra210-agic";
> +			#interrupt-cells = <4>;

Same as above.

> +			interrupt-controller;
> +			reg = <0x0 0x02a41000 0x0 0x1000>,
> +			      <0x0 0x02a42000 0x0 0x1000>;

Same as above.

> +			interrupts = <GIC_SPI 145 (GIC_CPU_MASK_SIMPLE(4) |
> +					IRQ_TYPE_LEVEL_HIGH)>;
> +			clocks = <&bpmp TEGRA194_CLK_APE>;
> +			clock-names = "clk";
> +			status = "disabled";
> +		};
> +	};
>  };
> 

Cheers
Jon

-- 
nvpublic
