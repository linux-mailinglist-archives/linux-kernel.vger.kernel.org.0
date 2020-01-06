Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61AB130D93
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 07:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgAFGcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 01:32:39 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53836 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgAFGci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 01:32:38 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0066Wbnl018714;
        Mon, 6 Jan 2020 00:32:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578292357;
        bh=bU7JD9mSLgbKPED+rEVhbTC9TEOicgI7SxvgPaaB5nQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=amD3+lLrRSUkocUPynBlK5cf0Qqq6NraEtD7CK5whO/YwtKoLGjvYJrF9dNVfhiwD
         dwvr+8S/epT++qGUZ2QPYyP4nO1RQUlzWQFQ1Zu4xnH10FPJJhk7DLybXQfLHWwRuB
         aXLjfbh2Vik5BRdfdRyGftvDeXuu+ZCYbHWTAiUo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0066WaCN085336
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Jan 2020 00:32:37 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 00:32:36 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 00:32:36 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0066WXBo046469;
        Mon, 6 Jan 2020 00:32:34 -0600
Subject: Re: [PATCH v4 0/3] phy: cadence: j721e-wiz: Add Type-C plug flip
 support
To:     Roger Quadros <rogerq@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20191028102153.24866-1-rogerq@ti.com>
 <d9f3af03-b9a6-d5b9-dce6-e573ceef7348@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6be83e71-4205-bc86-f788-46c955bf9fe5@ti.com>
Date:   Mon, 6 Jan 2020 12:04:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d9f3af03-b9a6-d5b9-dce6-e573ceef7348@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roger,

On 09/12/19 3:19 PM, Roger Quadros wrote:
> Hi Kishon,
> 
> On 28/10/2019 12:21, Roger Quadros wrote:
>> Hi,
>>
>> On J721e platform, the 2 lanes of SERDES PHY are used to achieve
>> USB Type-C plug flip support without any additional MUX component
>> by using a lane swap feature.
>>
>> However, the driver needs to know the Type-C plug orientation before
>> it can decide whether to swap the lanes or not. This is achieved via a
>> GPIO named DIR.
>>
>> Another constraint is that the lane swap must happen only when the PHY
>> is in inactive state. This is achieved by sampling the GPIO and
>> programming the lane swap before bringing the PHY out of reset.
>>
>> This series adds support to read the GPIO and accordingly program
>> the Lane swap for Type-C plug flip support.
>>
>> Series must be applied on top of
>> https://lkml.org/lkml/2019/10/23/589
> 
> I just tested this on top of Sierra PHY patches v3
> https://lkml.org/lkml/2019/11/28/186
> on v5.5-rc1
> 
> USB3 works fine on J7ES.
> 
> Please queue this along with the Sierra PHY patches for -next. Thanks.

This series doesn't apply cleanly. Can you resend the series please
based on phy -next?

Thanks
Kishon
> 
> cheers,
> -roger
> 
>>
>> cheers,
>> -roger
>>
>> Changelog:
>> v4
>> - fixes in dt-binding document
>>    - fix typo
>>    - change to typec-dir-debounce-ms and add min/max/default values
>>    - drop reference to uint32 type
>> - fixes in driver
>>    - change to updated typec-dir-debounce-ms property
>>    - add limit checks and use default value if not specified
>>
>> v3
>> - Rebase on v2 of PHY series and update DT binding to yaml
>>
>> v2
>> - revise commit log of patch 1
>> - use regmap_field in patch 3
>>
>> Roger Quadros (3):
>>    phy: cadence: Sierra: add phy_reset hook
>>    dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir GPIO
>>    phy: ti: j721e-wiz: Manage typec-gpio-dir
>>
>>   .../bindings/phy/ti,phy-j721e-wiz.yaml        | 17 ++++++
>>   drivers/phy/cadence/phy-cadence-sierra.c      | 10 +++
>>   drivers/phy/ti/phy-j721e-wiz.c                | 61 +++++++++++++++++++
>>   3 files changed, 88 insertions(+)
>>
> 
