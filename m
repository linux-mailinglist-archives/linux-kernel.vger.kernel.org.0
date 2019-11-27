Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0267E10AAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 08:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfK0HHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 02:07:46 -0500
Received: from olimex.com ([184.105.72.32]:40434 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfK0HHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 02:07:45 -0500
Received: from 94.155.250.134 ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 23:07:44 -0800
Subject: Re: [PATCH 1/1] arm64: dts: allwinner: a64: olinuxino: Add VCC-PG
 supply
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Stefan Mavrodiev <stefan@olimex.com>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
References: <20191126110508.15264-1-stefan@olimex.com>
 <20191126162721.qi7scp3vadxn7k2i@gilmour.lan>
From:   Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <0c1d7377-7064-f509-ffc5-bd1e8f2fbaa8@olimex.com>
Date:   Wed, 27 Nov 2019 09:07:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191126162721.qi7scp3vadxn7k2i@gilmour.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/26/19 6:27 PM, Maxime Ripard wrote:
> Hi Stefan,
>
> On Tue, Nov 26, 2019 at 01:05:08PM +0200, Stefan Mavrodiev wrote:
>> On A64-OLinuXino boards, PG9 is used for USB1 enable/disable. The
>> port is supplied by DLDO4, which is disabled by default. The patch
>> adds the regulator as vcc-pg, which is later used by the pinctrl.
>>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>> ---
>>   arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> index 01a9a52edae4..c9d8c9c4ef20 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> @@ -163,6 +163,10 @@
>>   	status = "okay";
>>   };
>>
>> +&pio {
>> +	vcc-pg-supply=<&reg_dldo4>;
> The equal sign should have spaces around it.
>
> Also, can you please list all the bank supplies while you're at it?
Sure. Should the supplies defined as regulators names be added also to 
the pio node?
For example reg_aldo1 is named "vcc-pe".

Also, since the commit message will be different for better 
representation of the changes, should I send the next
patch as v2 or as a new one?

Best regards,
Stefan
>
> Thanks!
> Maxime
