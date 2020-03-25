Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC741929F9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 14:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgCYNfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 09:35:36 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:32827 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgCYNfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:35:31 -0400
Received: from [10.18.38.73] (10.18.38.73) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 25 Mar
 2020 21:36:06 +0800
Subject: Re: [PATCH 02/13] usb: dwc3: meson-g12a: specify phy names in soc
 data
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     <kishon@ti.com>, <balbi@kernel.org>, <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200324102030.31000-1-narmstrong@baylibre.com>
 <20200324102030.31000-3-narmstrong@baylibre.com>
 <CAFBinCA9rQKWx47F2-dT4ZrCwSKW+LiwAH2VdzPKr-9ymRxkSw@mail.gmail.com>
 <a7020606-57be-81de-da2d-73d399853217@baylibre.com>
 <CAFBinCDOrhXAEwPf4L8-5XoCGqDT89=L2CX2Qsr2J-1pQp6N5Q@mail.gmail.com>
From:   Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <0cc6076c-1334-026f-c7ce-32a5945351b5@amlogic.com>
Date:   Wed, 25 Mar 2020 21:36:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDOrhXAEwPf4L8-5XoCGqDT89=L2CX2Qsr2J-1pQp6N5Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.38.73]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/24 22:19, Martin Blumenstingl wrote:
> On Tue, Mar 24, 2020 at 3:17 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> On 24/03/2020 15:13, Martin Blumenstingl wrote:
>>> Hi Neil,
>>>
>>> On Tue, Mar 24, 2020 at 11:20 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>> [...]
>>>> +static const char *meson_a1_phy_names[] = {
>>>> +       "usb2-phy0", "usb2-phy1"
>>>> +};
>>> my understanding is that the A1 SoC only has usb2-phy1.
>>> +Cc Hanjie Lin to confirm this
>>
>> I forgot a comment here, it only has a single PHY, but still the 2 U2 PHY
>> controls slots... it would need a large amount of code to handle this
>> tweak, and leaving 2 PHYs keeps the behavior before the patchset.
> I just reviewed patch #3 and I now understand that it would require a
> large code-change
> I'm fine with a comment
> 
> 
> Martin
> 
> .
> 

I see, 
A comment here will be more comprehensible.

Acked-by: Hanjie Lin <hanjie.lin@amlogic.com>

Hanjie

