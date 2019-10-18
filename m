Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D954DC4A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 14:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442763AbfJRMXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 08:23:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40516 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442702AbfJRMXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:23:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9ICN9Yf013215;
        Fri, 18 Oct 2019 07:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571401389;
        bh=I4qPIv3TfJomROlJ51jMxTwuDPaA3EB49Ea1gtA/Jko=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bn/UYDgeGgGNFmMAAiWvSKqtuZFAHubxGv06IYeTTPmKm9TxpuiwSTQaEo9s4NS77
         Jl/ry4jaSCy7V7kWJLvYXy/bxgdh2exp1AnTIYbRBnpNqcnxwze+G61jiDowvFuoDp
         /xXabzz+n6YMFvx7DD4QHNCsRT5Sgr/WmxhPiPc8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9ICN99P088786;
        Fri, 18 Oct 2019 07:23:09 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 18
 Oct 2019 07:23:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 18 Oct 2019 07:23:09 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9ICN6Yl096018;
        Fri, 18 Oct 2019 07:23:07 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-am654-base-board: Add disable-wp for
 mmc0
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <robh+dt@kernel.org>, <nm@ti.com>
References: <20191003114251.20533-1-faiz_abbas@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <ea838a43-4ee7-3e40-e610-fe4bdbef81c9@ti.com>
Date:   Fri, 18 Oct 2019 15:23:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191003114251.20533-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2019 14:42, Faiz Abbas wrote:
> MMC0_SDWP is not connected to the card. Indicate this by adding a
> disable-wp flag.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index 1102b84f853d..143474119328 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -221,6 +221,7 @@
>   	bus-width = <8>;
>   	non-removable;
>   	ti,driver-strength-ohm = <50>;
> +	disable-wp;
>   };
>   
>   &dwc3_1 {
> 

Queuing up towards 5.5, thanks.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
