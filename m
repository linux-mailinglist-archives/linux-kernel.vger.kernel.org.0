Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD53C13C280
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 14:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgAONUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 08:20:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:43588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgAONUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:20:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B050FADDC;
        Wed, 15 Jan 2020 13:20:17 +0000 (UTC)
Subject: Re: [PATCH] arm64: dts: realtek: rtd16xx: Add memory reservations
To:     James Tai <james.tai@realtek.com>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20200103060441.1109-1-afaerber@suse.de>
 <51cf409ed1a44f038a5f1df133986063@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <6ac92228-8dcb-3927-e3ee-d9564ec7d20e@suse.de>
Date:   Wed, 15 Jan 2020 14:20:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <51cf409ed1a44f038a5f1df133986063@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.01.20 um 09:13 schrieb James Tai:
>> Reserve memory regions for RPC and TEE.
>>
>> Fixes: e5a9e237608d ("arm64: dts: realtek: Add RTD1619 SoC and Realtek
>> Mjolnir EVB")
>> Cc: James Tai <james.tai@realtek.com>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
>>   arch/arm64/boot/dts/realtek/rtd16xx.dtsi | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
[...]
> Acked-by: James Tai <james.tai@realtek.com>

Thanks, applied to linux-realtek.git v5.6/dt:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git/log/?h=v5.6/dt

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
