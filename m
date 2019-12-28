Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C7E12BDC4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 15:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfL1OZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Dec 2019 09:25:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:53110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfL1OZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 09:25:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 10526AC46;
        Sat, 28 Dec 2019 14:25:52 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] arm64: dts: realtek: Add RTD1619 SoC and Realtek
 Mjolnir EVB
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
To:     James Tai <james.tai@realtek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        'DTML' <devicetree@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <73fb8106ec1a4665b59a2d187a576b71@realtek.com>
 <9cadb78c-99af-8948-e76f-c26f263693b3@suse.de>
 <fbc4dee61c2547458fa0791f38abaed2@realtek.com>
 <610ad23f-d133-8fd9-1741-80eb47157929@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <7bf764cb-a2d0-3fa3-8873-763ebfc0f93a@suse.de>
Date:   Sat, 28 Dec 2019 15:25:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <610ad23f-d133-8fd9-1741-80eb47157929@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.11.19 um 16:29 schrieb Andreas Färber:
> Am 15.11.19 um 15:52 schrieb James Tai:
>>>> Add Device Trees for Realtek RTD1619 SoC family, RTD1619 SoC and
>>>> Realtek Mjolnir EVB.
>>>>
>>>> Signed-off-by: James Tai <james.tai@realtek.com>
>>>> ---
>>>
>>> Lacking the requested changelog.
>>>
>>>>   arch/arm64/boot/dts/realtek/Makefile          |   2 +
>>>>   .../boot/dts/realtek/rtd1619-mjolnir.dts      |  40 +++++
>>>>   arch/arm64/boot/dts/realtek/rtd1619.dtsi      |  12 ++
>>>>   arch/arm64/boot/dts/realtek/rtd16xx.dtsi      | 163
>>> ++++++++++++++++++
>>>>   4 files changed, 217 insertions(+)
>>>>   create mode 100644 arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
>>>>   create mode 100644 arch/arm64/boot/dts/realtek/rtd1619.dtsi
>>>>   create mode 100644 arch/arm64/boot/dts/realtek/rtd16xx.dtsi
>>>
>>> Somehow the last hunk (rtd16xx.dtsi) didn't apply with git-am or patch -p1, not
>>> sure why. I have manually copied the file into place and fixed up some more
>>> nits below:
[...]
>> I'll correct these mistakes in next version.
> 
> No need for a v4, I already have it queued.

And applied to linux-realtek.git v5.6/dt now:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git/log/?h=v5.6/dt

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
