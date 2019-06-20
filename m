Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1C34C997
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 10:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbfFTIhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 04:37:10 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4395 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbfFTIhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:37:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0b45b60002>; Thu, 20 Jun 2019 01:37:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 01:37:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Jun 2019 01:37:09 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 08:37:07 +0000
Subject: Re: [PATCH v6 2/2] arm64: tegra: enable ACONNECT, ADMA and AGIC
To:     Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1560945082-24554-1-git-send-email-spujar@nvidia.com>
 <1560945082-24554-2-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <7a5cd105-0e49-cd5f-650a-e4caa64c6638@nvidia.com>
Date:   Thu, 20 Jun 2019 09:37:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560945082-24554-2-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561019830; bh=kIzvlCTC2QG8LnzWlQUQjDEnI0BqnPyICmvbcCwX7/w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Cdhnf0MMHyLWN8DEMiK7tuJwFO9CiWRZ5JPHpfjPoZ6uHgE7m30AWjtSCEScIcsUK
         ZKP0HkNaqX1H9IBR+GdW+1nGRj8QLBvSGusE4hCx4p+b6vfPPavbhmJ9+/6E2oLUze
         cCiGI/niACbKIqMdhokMHz2vMoqLSXnjXS8+dBtiZenmM43BVCceVe/d2iVVeuX9nv
         sf+Sgeido6NrpuoqFod0hG85ZOkl9af5BnEjKajBttpV4jX+ZxGBF5iO8v99l8Ez37
         i2sk8APczjT8Pjz2xXcUVGrWmiCr+hxKk65iClcOhLGDt1spC50p7kHwu2jXXBFEaR
         FNe6MNfjTjEkw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/06/2019 12:51, Sameer Pujar wrote:
> Enable ACONNECT, ADMA and AGIC devices for following platforms
>   * Jetson TX2
>   * Jetson Xavier
> 
> Verified driver probe path and devices get registered fine.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  changes in current revision
>    * renamed agic, interrupt-controller, name
> 
>  arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 12 ++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 12 ++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
> index 5102de1..55c84bb 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
> @@ -298,4 +298,16 @@
>  			vin-supply = <&vdd_5v0_sys>;
>  		};
>  	};
> +
> +	aconnect {
> +		status = "okay";
> +
> +		dma-controller@2930000 {
> +			status = "okay";
> +		};
> +
> +		interrupt-controller@2a40000 {
> +			status = "okay";
> +		};
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> index 6e6df65..5981cdc 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -167,4 +167,16 @@
>  			};
>  		};
>  	};
> +
> +	aconnect {
> +		status = "okay";
> +
> +		dma-controller@2930000 {
> +			status = "okay";
> +		};
> +
> +		interrupt-controller@2a40000 {
> +			status = "okay";
> +		};
> +	};
>  };
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
