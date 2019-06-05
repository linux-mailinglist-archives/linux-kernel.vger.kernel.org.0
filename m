Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0063356FC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 08:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfFEGbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 02:31:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49444 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFEGa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:30:59 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x556Uuiw065580;
        Wed, 5 Jun 2019 01:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559716256;
        bh=xufq4zsgyRLrZo2MfHTNUdK52WNJg8XUlkPMm4NwCMU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bJNL66q1skwWEDasM7A23VSi9/FGgddAKlsLfy+RLQbx52465XFfLWiAlv45qsdMN
         WH5Uo7Mky2HUuxGYMe1KVkiej4K0vTRmJqwlGohxQ4tCatCXt47XMtq04cuQKDVOLu
         6+L80wogACHV2GEBOyLWdVta9v5SCYgB46WemDRU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x556Uu09089926
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Jun 2019 01:30:56 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 5 Jun
 2019 01:30:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 5 Jun 2019 01:30:55 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x556UqLj110256;
        Wed, 5 Jun 2019 01:30:53 -0500
Subject: Re: [RFC PATCH 1/3] arm64: dts: ti: am6-wakeup: Add gpio node
To:     Lokesh Vutla <lokeshvutla@ti.com>, <t-kristo@ti.com>, <nm@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190605060846.25314-1-j-keerthy@ti.com>
 <20190605060846.25314-2-j-keerthy@ti.com>
 <e6ec3894-4e3d-e721-c1bc-791263b2d309@ti.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <bac5737a-3924-b59f-1d90-a2a9b3a390f1@ti.com>
Date:   Wed, 5 Jun 2019 12:01:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e6ec3894-4e3d-e721-c1bc-791263b2d309@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/19 11:46 AM, Lokesh Vutla wrote:
> 
> 
> On 05/06/19 11:38 AM, Keerthy wrote:
>> Add gpio0 node under wakeup domain. This has 56 gpios
>> and all are capable of generating banked interrupts.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
>> index f1ca171abdf8..8c6c99e7c6ed 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
>> @@ -74,4 +74,19 @@
>>   		ti,sci-dst-id = <56>;
>>   		ti,sci-rm-range-girq = <0x4>;
>>   	};
>> +
>> +	wkup_gpio0: wkup_gpio0@42110000 {
>> +		compatible = "ti,k2g-gpio", "ti,keystone-gpio";
> 
> This is not k2g. Can you either create a am6 specific compatible or just use
> ti,keystone-gpio.

It seems practice is now to have separate compatible. I will add am6 
specific compatible.

> 
> Thanks and regards,
> Lokesh
> 
>> +		reg = <0x42110000 0x100>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		interrupt-parent = <&intr_wkup_gpio>;
>> +		interrupts = <59 128>, <59 129>, <59 130>, <59 131>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <2>;
>> +		ti,ngpio = <56>;
>> +		ti,davinci-gpio-unbanked = <0>;
>> +		clocks = <&k3_clks 59 0>;
>> +		clock-names = "gpio";
>> +	};
>>   };
>>
