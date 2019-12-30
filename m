Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C8312CE66
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 10:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfL3JiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 04:38:00 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43940 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfL3JiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 04:38:00 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBU9btZ8008994;
        Mon, 30 Dec 2019 03:37:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577698675;
        bh=HEsmbipAwW0v5k2Dk4uWd1mq6oacihDpfL4YGD2Huys=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PawEK2Rc6yNXpkLSBV37uUbqNZekrvmCmwfpDrqguyY9rbm1EgSYY9vZ4yv7Ra7i7
         To/lNH56sqSLuuqamMoBxWX2l6DW6+EzdXYrW3zEBhYCfsdjf9oR8Cbqejg4AIi3sm
         yLidjSVu/zDDxMEaF8qfFOjZhl8/IGwzpvNWDquU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBU9btlr113518
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Dec 2019 03:37:55 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 30
 Dec 2019 03:37:54 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 30 Dec 2019 03:37:54 -0600
Received: from [10.1.3.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBU9bqS2026637;
        Mon, 30 Dec 2019 03:37:53 -0600
Subject: Re: [PATCH 2/3] dt-bindings: phy: Add lane<n>-mode property to WIZ
 (SERDES wrapper)
To:     Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Roger Quadros <rogerq@ti.com>
References: <cover.1575906694.git.jsarha@ti.com>
 <fb79923b1591cc5f26b6973beb92ce503ad3f4d1.1575906694.git.jsarha@ti.com>
 <20191219190833.GA16358@bogus> <3cf64e30-6b4d-a138-7164-54d1cdc8e05a@ti.com>
 <CAL_JsqKNFbPebM=pC+GL_DMuf5OPZF4FyJ7KGdSonDAeL_3P1A@mail.gmail.com>
From:   Jyri Sarha <jsarha@ti.com>
Autocrypt: addr=jsarha@ti.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <15d0bd42-5bb5-ee14-9e2a-7beb55671e8a@ti.com>
Date:   Mon, 30 Dec 2019 11:37:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKNFbPebM=pC+GL_DMuf5OPZF4FyJ7KGdSonDAeL_3P1A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/12/2019 23:31, Rob Herring wrote:
> On Fri, Dec 20, 2019 at 5:52 AM Jyri Sarha <jsarha@ti.com> wrote:
>>
>> On 19/12/2019 21:08, Rob Herring wrote:
>>> On Mon, Dec 09, 2019 at 06:22:11PM +0200, Jyri Sarha wrote:
>>>> Add property to indicate the usage of SERDES lane controlled by the
>>>> WIZ wrapper. The wrapper configuration has some variation depending on
>>>> how each lane is going to be used.
>>>>
>>>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>>>> ---
>>>>  .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml    | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>>>> index 94e3b4b5ed8e..399725f65278 100644
>>>> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>>>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>>>> @@ -97,6 +97,18 @@ patternProperties:
>>>>        Torrent SERDES should follow the bindings specified in
>>>>        Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
>>>>
>>>> +  "^lane[1-4]-mode$":
>>>> +    allOf:
>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>>>> +      - enum: [0, 1, 2, 3, 4, 5, 6]
>>>> +    description: |
>>>> +     Integer describing static lane usage for the lane indicated in
>>>> +     the property name. For Sierra there may be properties lane0 and
>>>> +     lane1, for Torrent all lane[1-4]-mode properties may be
>>>> +     there. The constants to indicate the lane usage are defined in
>>>> +     "include/dt-bindings/phy/phy.h". The lane is assumed to be unused
>>>> +     if its lane<n>-use property does not exist.
>>>
>>> The defines were intended to be in 'phys' cells. Does putting both lane
>>> and mode in the client 'phys' properties not work?
>>>
>>
>> Let me first check if I understood you. So you are suggesting something
>> like this:
>>
>> dp-phy {
>>         #phy-cells = <5>; /* 1 for phy-type and 4 for lanes = 5 */
>>         ...
>> };
>>
>> dp-bridge {
>>         ...
>>         phys = <&dp-phy PHY_TYPE_DP 1 1 0 0>; /* lanes 0 and 1 for DP */
> 
> Yes, but I think the lanes can be a single cell mask. And I'd probably
> make that the first cell which is generally "which PHY" and make
> type/mode the 2nd cell. I'd look for other users of PHY_TYPE_ defines
> and match what they've done if possible.
> 

I see. This will cause some head ache on the driver implementation side,
as there is no way for the phy driver to peek the lane use or type from
the phy client's device tree node. It also looks to me that the phy
API[1] has to be extended quite a bit before the phy client can pass the
lane usage information to the phy driver. It will cause some pain to
implement the extension without breaking the phy API and causing a nasty
cross dependency over all the phy client domains.

Also, there is not much point in putting the PHY_TYPE constant to the
phy client's node, as normally the phy client driver will know quite
well what PHY_TYPE to use. E.g. a SATA driver will always select
PHY_TYPE_SATA and a PCIE driver will select PHY_TYPE_PCIE, etc.

Kishon, if we have to take this road it also starts to sound like we
will have to move the phy client's phandle to point to the phy wrapper
node, if we want to keep the actual phy driver wrapper agnostic. Then we
can make the wrapper to act like a proxy that forwards the phy_ops calls
to the actual phy driver. Luckily the per lane phy-type selection is not
a blocker for our j721e DisplayPort functionality.

Best regards,
Jyri

[1] include/linux/phy/phy.h


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
