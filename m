Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29001464C7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 10:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAWJpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 04:45:53 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45162 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgAWJpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:45:53 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00N9jbZ5117672;
        Thu, 23 Jan 2020 03:45:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579772738;
        bh=0OarRbl/p4h9x83lCORIsIyAzrGcOjoV4wCt5Jo9hQk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=W5031Zc7aA8LS+kXhKpqvHJVX28BU3duSOdx5GzHp29UVHDE3ziLjnAiwgUStCEmZ
         pbNhhVhIziO45KZ/lSxGMPY8nXMbUwo80IXOWlyO3yY/UYsCuMpf32tvM3hOi+vFGR
         MC293yeKgWwZorXSnm+Ai9DA/nLYEBSQohiheXSk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00N9jb6S013992
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jan 2020 03:45:37 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 23
 Jan 2020 03:45:37 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 23 Jan 2020 03:45:37 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00N9jZPV115897;
        Thu, 23 Jan 2020 03:45:35 -0600
Subject: Re: [PATCH v2 1/9] arm64: dts: ti: k3-am65-main: Correct main NAVSS
 representation
To:     Lokesh Vutla <lokeshvutla@ti.com>, <t-kristo@ti.com>, <nm@ti.com>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200122082621.4974-1-peter.ujfalusi@ti.com>
 <20200122082621.4974-2-peter.ujfalusi@ti.com>
 <600df214-620b-fa41-82ef-01132d9bdfae@ti.com>
 <04a1bb97-f308-f866-ad4f-907cd7fb3515@ti.com>
 <469a35b0-9b60-7faf-2b1b-a77f9f502a50@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <52078b70-b5dd-103a-45ea-55fd36cba480@ti.com>
Date:   Thu, 23 Jan 2020 11:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <469a35b0-9b60-7faf-2b1b-a77f9f502a50@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/01/2020 10.32, Lokesh Vutla wrote:
> 
> 
> On 22/01/20 5:09 PM, Peter Ujfalusi wrote:
>>
>>
>> On 22/01/2020 13.03, Lokesh Vutla wrote:
>>>
>>>
>>> On 22/01/20 1:56 PM, Peter Ujfalusi wrote:
>>>> NAVSS is a subsystem containing different IPs, it is not really a bus.
>>>> Change the compatible from "simple-bus" to "simple-mfd" to reflect that.
>>>>
>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>> ---
>>>>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>>> index efb24579922c..e40f7acbec42 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>>> @@ -385,8 +385,8 @@ intr_main_gpio: interrupt-controller0 {
>>>>  		ti,sci-rm-range-girq = <0x1>;
>>>>  	};
>>>>  
>>>> -	cbass_main_navss: interconnect0 {
>>>> -		compatible = "simple-bus";
>>>> +	cbass_main_navss: navss@30800000 {
>>>
>>> This introduces below dtc warning when built with W=1
>>>
>>> arch/arm64/boot/dts/ti/k3-am65-main.dtsi:388.35-530.4: Warning
>>> (unit_address_vs_reg): /interconnect@100000/navss@30800000: node has a unit
>>> name, but no reg property
>>
>> Interesting, the example in
>> Documentation/devicetree/bindings/dma/ti/k3-udma.yaml
>>
>> is basically the same and dt_binding_check is happy about it:
>> DTC     Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml
>> CHECK   Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml
>>
>> but it screamed when I had the simple-bus in there (copied from the
>> existing dtsi file).
>>
>> The node name for simple-bus _must_ be
>> '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
>>
>> I would not use any of these to NAVSS node...
>>
>>> this is representing cbass inside main_navss, just like cbass_main. You can drop
>>> this patch and the similar mcu version.
>>
>> According to Documentation/devicetree/bindings/mfd/mfd.txt:
>> - compatible : "simple-mfd" - this signifies that the operating system
>>   should consider all subnodes of the MFD device as separate devices
>>   akin to how "simple-bus" indicates when to see subnodes as children
>>   for a simple memory-mapped bus.
>>
>> NAVSS is falling into simple-mfd as the devices under it are independent
>> devices.
> 
> okay, may be rename cbass_main_navss to main_navss.

Actually we don't even need label for any of the NAVSS nodes.

> 
> Thanks and regards,
> Lokesh
> 
>>
>>>
>>> Thanks and regards,
>>> Lokesh
>>>
>>>> +		compatible = "simple-mfd";
>>>>  		#address-cells = <2>;
>>>>  		#size-cells = <2>;
>>>>  		ranges;
>>>>
>>
>> - Péter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
