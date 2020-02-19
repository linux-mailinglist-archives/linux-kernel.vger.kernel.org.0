Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5493163BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 05:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBSEJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 23:09:11 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45554 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgBSEJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 23:09:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01J495wR059122;
        Tue, 18 Feb 2020 22:09:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582085345;
        bh=NK2Nj1NvUb+C/gMl830shjWOUmD7nMVZidNLmQZoaDQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dUWvTpbw47Zh5d39p9cosW2L+/KUflALNHPnhAdlq6FUnRgAX+fA6d4y08NpGZoIG
         bAUz27PryAnFNIpyKLShGLtyWIv8wHY204xY1sF+h44iXPyW/Du8zA5DTax4Ix40q9
         FjuWPdkZIhf/sE0+xh9sufjWJyBglnsxwEzTYWJU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01J494iV089131;
        Tue, 18 Feb 2020 22:09:05 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 18
 Feb 2020 22:09:04 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 18 Feb 2020 22:09:04 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01J490Wa014304;
        Tue, 18 Feb 2020 22:09:01 -0600
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: Add binding documentation for
 TI syscon gate clock
To:     Rob Herring <robh@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>
References: <20200215141724.32291-1-vigneshr@ti.com>
 <20200215141724.32291-2-vigneshr@ti.com> <20200219025811.GA20054@bogus>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <5eb5521b-2752-68a3-c11d-eea38e325666@ti.com>
Date:   Wed, 19 Feb 2020 09:39:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200219025811.GA20054@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/02/20 8:28 am, Rob Herring wrote:
> On Sat, Feb 15, 2020 at 07:47:23PM +0530, Vignesh Raghavendra wrote:
>> Add dt bindings for TI syscon gate clock driver that is used to control
>> EHRPWM's TimeBase clock (TBCLK) on TI's AM654 SoC.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml | 35 +++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
>> new file mode 100644
>> index 000000000000..3bf954ecb803
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
>> @@ -0,0 +1,35 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI syscon gate clock driver
> 
> Bindings are for h/w blocks, not drivers.
> 

Will drop driver from the title and commit msg

>> +
>> +maintainers:
>> +  - Vignesh Raghavendra <vigneshr@ti.com>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: ti,am654-ehrpwm-tbclk
>> +      - const: syscon
> 
> Why is this a syscon? Are there other functions or it's just the easy 
> way to get a regmap.
> 

Register that has tbclk enable/disable bit also contains bits to control
other functionalities and would need to be shared. Therefore its modeled
as syscon.

Regards
Vignesh

>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - "#clock-cells"
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +    ehrpwm_tbclk: syscon@4140 {
>> +        compatible = "ti,am654-ehrpwm-tbclk", "syscon";
>> +        reg = <0x4140 0x18>;
>> +        #clock-cells = <1>;
>> +    };
>> -- 
>> 2.25.0
>>

-- 
Regards
Vignesh
