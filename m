Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC3D18C984
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 10:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgCTJHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 05:07:35 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40650 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgCTJHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:07:34 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02K97UAp059436;
        Fri, 20 Mar 2020 04:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584695250;
        bh=CA60fAxu2Om4P8TmIH8kKHYbjd79oYciPDz/3lq0gVE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=W6a345w/oxVR7BQ8Mx0nAraxljHK6q8mHoD8zIYbYNlYknE8IriFVfvpsnYlqX17d
         XH5cN29zm5HNH00+fvkguper0jBs6gWRXdEvh8sKWEtQRK89w9T6cCs8u75xyshlpz
         64p4ysc4gKlPFdz9REjFgD9hiuQS+SqbWuHLjRvQ=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02K97UqX093926
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Mar 2020 04:07:30 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Mar 2020 04:07:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Mar 2020 04:07:29 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02K97QNc085215;
        Fri, 20 Mar 2020 04:07:27 -0500
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am65-mcu: Add DMA entries for ADC
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200312092823.21587-1-vigneshr@ti.com>
 <20200312092823.21587-2-vigneshr@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <5b1703e1-b1af-6436-3e46-34e27f7c8ada@ti.com>
Date:   Fri, 20 Mar 2020 11:07:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312092823.21587-2-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2020 11:28, Vignesh Raghavendra wrote:
> Add DMA entries for ADC nodes
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

Queued both patches towards 5.7, thanks.

-Tero

> ---
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 92629cbdc184..e85498f0dd05 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -82,6 +82,9 @@ tscadc0: tscadc@40200000 {
>   		assigned-clocks = <&k3_clks 0 2>;
>   		assigned-clock-rates = <60000000>;
>   		clock-names = "adc_tsc_fck";
> +		dmas = <&mcu_udmap 0x7100>,
> +			<&mcu_udmap 0x7101 >;
> +		dma-names = "fifo0", "fifo1";
>   
>   		adc {
>   			#io-channel-cells = <1>;
> @@ -97,6 +100,9 @@ tscadc1: tscadc@40210000 {
>   		assigned-clocks = <&k3_clks 1 2>;
>   		assigned-clock-rates = <60000000>;
>   		clock-names = "adc_tsc_fck";
> +		dmas = <&mcu_udmap 0x7102>,
> +			<&mcu_udmap 0x7103>;
> +		dma-names = "fifo0", "fifo1";
>   
>   		adc {
>   			#io-channel-cells = <1>;
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
