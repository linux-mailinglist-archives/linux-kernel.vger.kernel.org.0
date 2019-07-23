Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC4471055
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 06:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfGWEK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 00:10:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45692 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfGWEKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 00:10:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6N4AcQZ084842;
        Mon, 22 Jul 2019 23:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563855038;
        bh=XVQwkygam6XUYEnTe8AJ648CRlJe+ilV+FEAKjn2rNk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=i2oKgZIxxAGqvixuh0zwlHSsthhL4f5ATxJn75fKFU5poGsHBBOBlUB4Uf5XnzPKg
         382ORi84YpgwMEpXRvUfkXu2QTZys2UrfnGJKw66QTRz4ABgTo1daN4PNEVVfwVcod
         ehmrKWZ9j3qflQyzW+Z65JrzTX25le7sfZqMxyOg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6N4Ac2U090509
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Jul 2019 23:10:38 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 22
 Jul 2019 23:10:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 22 Jul 2019 23:10:37 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6N4AYpB052900;
        Mon, 22 Jul 2019 23:10:35 -0500
Subject: Re: [RESEND PATCH 01/10] dt-bindings: crypto: k3: Add sa2ul bindings
 documentation
To:     Rob Herring <robh@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <t-kristo@ti.com>,
        <linux-crypto@vger.kernel.org>, <nm@ti.com>
References: <20190628042745.28455-1-j-keerthy@ti.com>
 <20190628042745.28455-2-j-keerthy@ti.com> <20190722182945.GA24685@bogus>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <b8712fe4-4590-fdda-8a24-bf0f135ad567@ti.com>
Date:   Tue, 23 Jul 2019 09:41:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722182945.GA24685@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/07/19 11:59 PM, Rob Herring wrote:
> On Fri, Jun 28, 2019 at 09:57:36AM +0530, Keerthy wrote:
>> The series adds Crypto hardware accelerator support for SA2UL.
>> SA2UL stands for security accelerator ultra lite.
>>
>> The Security Accelerator (SA2_UL) subsystem provides hardware
>> cryptographic acceleration for the following use cases:
>> • Encryption and authentication for secure boot
>> • Encryption and authentication of content in applications
>>    requiring DRM (digital rights management) and
>>    content/asset protection
>> The device includes one instantiation of SA2_UL named SA2_UL0
>>
>> SA2UL needs on tx channel and a pair of rx dma channels.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   .../devicetree/bindings/crypto/sa2ul.txt      | 47 +++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/crypto/sa2ul.txt
>>
>> diff --git a/Documentation/devicetree/bindings/crypto/sa2ul.txt b/Documentation/devicetree/bindings/crypto/sa2ul.txt
>> new file mode 100644
>> index 000000000000..81cc039673b4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/crypto/sa2ul.txt
>> @@ -0,0 +1,47 @@
>> +K3 SoC SA2UL crypto module
>> +
>> +Required properties:
>> +
>> +- compatible : Should be:
>> +  - "ti,sa2ul-crypto"
> 
> Needs to be SoC specific.

okay

> 
>> +- reg : Offset and length of the register set for the module
>> +
>> +- dmas: DMA specifiers for tx and rx dma. sa2ul needs one tx channel
>> +	and 2 rx channels. First rx channel for < 256 bytes and
>> +	the other one for >=256 bytes. See the DMA client binding,
>> +        Documentation/devicetree/bindings/dma/dma.txt
>> +- dma-names: DMA request names has to have one tx and 2 rx names
>> +	corresponding to dmas abive.
>> +- ti,psil-config* - UDMA PSIL native Peripheral using packet mode.
>> +	SA2UL must have EPIB(Extended protocal information block)
>> +	and PSDATA(protocol specific data) properties.
> 
> If ti,needs-epib is required, then why do you need to specify it in DT?
> In any case, this all seems like channel config info that should be part
> of the #dma-cells.

ti,needs-epib is the udma client(Here sa2ul) conveying the udma layer.
Not every udma client needs epib.

Peter,

Any thoughts on the above?

- Keerthy

> 
> Also, don't use vendor prefixes on node names.

Okay

> 
>> +
>> +Example AM654 SA2UL:
>> +crypto: crypto@4E00000 {
>> +	compatible = "ti,sa2ul-crypto";
>> +	reg = <0x0 0x4E00000 0x0 0x1200>;
>> +	ti,psil-base = <0x4000>;
>> +
>> +	dmas = <&main_udmap &crypto 0 UDMA_DIR_TX>,
>> +		<&main_udmap &crypto 0 UDMA_DIR_RX>,
>> +		<&main_udmap &crypto 1 UDMA_DIR_RX>;
>> +	dma-names = "tx", "rx1", "rx2";
>> +
>> +	ti,psil-config0 {
>> +		linux,udma-mode = <UDMA_PKT_MODE>;
>> +		ti,needs-epib;
>> +		ti,psd-size = <64>;
>> +	};
>> +
>> +	ti,psil-config1 {
>> +		linux,udma-mode = <UDMA_PKT_MODE>;
>> +		ti,needs-epib;
>> +		ti,psd-size = <64>;
>> +	};
>> +
>> +	ti,psil-config2 {
>> +		linux,udma-mode = <UDMA_PKT_MODE>;
>> +		ti,needs-epib;
>> +		ti,psd-size = <64>;
>> +	};
>> +};
>> -- 
>> 2.17.1
>>
