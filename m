Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73271240D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 09:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfLRIAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 03:00:11 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:30607 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfLRIAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:00:11 -0500
Received: from [10.28.39.99] (10.28.39.99) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 18 Dec
 2019 16:00:21 +0800
Subject: Re: [PATCH v4 1/6] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
To:     Maxime Ripard <maxime@cerno.tech>
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20191206074052.15557-1-jian.hu@amlogic.com>
 <20191206074052.15557-2-jian.hu@amlogic.com>
 <20191213103856.qo7vlnuk4ajz3vq5@gilmour.lan>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <ba16b846-1d5f-3d1e-e8e2-420687d11e8a@amlogic.com>
Date:   Wed, 18 Dec 2019 16:00:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191213103856.qo7vlnuk4ajz3vq5@gilmour.lan>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.99]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

Thanks for your review

On 2019/12/13 18:38, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Dec 06, 2019 at 03:40:47PM +0800, Jian Hu wrote:
>> Add the documentation to support Amlogic A1 PLL clock driver,
>> and add A1 PLL clock controller bindings.
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> ---
>>   .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 59 +++++++++++++++++++
>>   include/dt-bindings/clock/a1-pll-clkc.h       | 16 +++++
>>   2 files changed, 75 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>>   create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>> new file mode 100644
>> index 000000000000..7feeef5abf1b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>> @@ -0,0 +1,59 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>> + */
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/clock/amlogic,a1-pll-clkc.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Amlogic Meson A/C serials PLL Clock Control Unit Device Tree Bindings
>> +
>> +maintainers:
>> +  - Neil Armstrong <narmstrong@baylibre.com>
>> +  - Jerome Brunet <jbrunet@baylibre.com>
>> +  - Jian Hu <jian.hu@jian.hu.com>
>> +
>> +properties:
>> +  compatible:
>> +    - enum:
>> +        - amlogic,a1-pll-clkc
> 
> I'm not sure this works, compatible shouldn't contain a list.
> 
I refered to 
Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml.

I have used 'dt-doc-validate' tools to check, it will report something 
wrong below.

properties:compatible: [{'enum': ['amlogic,a1-pll-clkc']}] is not of 
type 'object', 'boolean'

Refer to
https://github.com/robherring/dt-schema/blob/master/example-schema.yaml

I will change it like this:

properties:
   compatible:
     oneOf:
       - enum:
          - amlogic,a1-pll-clkc

And It has been passed by 'dt-doc-validate' tools.

Is it right?

> You can write this like:
> compatible:
>    const: amlogic,a1-pll-clkc
> 
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +clocks:
>> +  minItems: 2
>> +  maxItems: 2
> 
> This is redundant, it will be added automatically by the tools ...
If I remove the minItems, it will pass by dt-doc-validate.

Would please tell how to use dt-schema to generate automatically it?

> 
>> +  items:
>> +   - description: Input xtal_fixpll
>> +   - description: Input xtal_hifipll
> 
> ... When you have a list of items :)
> 
>> +
>> +clock-names:
>> +  minItems: 2
>> +  maxItems: 2
>> +  items:
>> +     - const: xtal_fixpll
>> +     - const: xtal_hifipll
> 
> Same story here
OK, I will change it when I find the right way.
> 
> Maxime
> 
