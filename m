Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDD5121A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 20:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfLPTjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 14:39:31 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42570 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfLPTjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:39:31 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBGJdOj3115233;
        Mon, 16 Dec 2019 13:39:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576525164;
        bh=vCabfj6+uoFYGOCcB6wnIJ2lDm1TOSkgjhyBX1IgwgI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ce0JkAaZ1zfcH19gaXbXctW9eDGOI2v98/etQOtrPVORgjAgNzstbSOh2wxlHkPge
         7qKDnkYChgPW8NknN6iO12Ne2oIXYFGuv/Cwm0GoXYodV8s8IjzTu//cSAQrSKvy9Y
         Hr0UAakYNRFzYpW204a9Dbt3RuE5ZiKsRzo1LiO0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBGJdOQX046541;
        Mon, 16 Dec 2019 13:39:24 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 13:39:23 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 13:39:23 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBGJdLtG095374;
        Mon, 16 Dec 2019 13:39:21 -0600
Subject: Re: [PATCH] ARM: dts: omap3: name mdio node properly
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20191216193022.30201-1-grygorii.strashko@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <0b341b95-9d59-8053-09fc-db009e1099b9@ti.com>
Date:   Mon, 16 Dec 2019 21:39:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216193022.30201-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Pls. Ignore this mail.

On 16/12/2019 21:30, Grygorii Strashko wrote:
> Rename davinci_mdio DT node "ethernet"->"mdio"
> This fixes the following DT schemas check errors:
> am3517-craneboard.dt.yaml: ethernet@5c030000: $nodename:0: 'ethernet@5c030000' does not match '^mdio(@.*)?'
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>   arch/arm/boot/dts/am3517.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
> index 76f819f4ba48..84e13778a64a 100644
> --- a/arch/arm/boot/dts/am3517.dtsi
> +++ b/arch/arm/boot/dts/am3517.dtsi
> @@ -74,7 +74,7 @@
>   			clock-names = "ick";
>   		};
>   
> -		davinci_mdio: ethernet@5c030000 {
> +		davinci_mdio: mdio@5c030000 {
>   			compatible = "ti,davinci_mdio";
>   			ti,hwmods = "davinci_mdio";
>   			status = "disabled";
> 

Pls. Ignore this mail.

-- 
Best regards,
grygorii
