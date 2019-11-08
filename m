Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9C2F45B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 12:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbfKHL3z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Nov 2019 06:29:55 -0500
Received: from hermes.aosc.io ([199.195.250.187]:34250 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbfKHL3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:29:54 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id C845041447;
        Fri,  8 Nov 2019 11:29:51 +0000 (UTC)
Date:   Fri, 08 Nov 2019 19:29:21 +0800
In-Reply-To: <20191107214514.kcz42mcehyrrif4o@core.my.home>
References: <20191020134229.1216351-3-megous@megous.com> <20191107204645.13739-1-rikard.falkeborn@gmail.com> <20191107214514.kcz42mcehyrrif4o@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] phy: allwinner: Fix GENMASK misuse
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
CC:     arnd@arndb.de, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, kishon@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, mark.rutland@arm.com,
        mripard@kernel.org, paul.kocialkowski@bootlin.com,
        robh+dt@kernel.org, tglx@linutronix.de, wens@csie.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <F563E52E-72BF-4297-A14F-DDE2B490DADB@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2019年11月8日 GMT+08:00 上午5:45:14, "Ondřej Jirman" <megous@megous.com> 写到:
>Hello Rikard,
>
>On Thu, Nov 07, 2019 at 09:46:45PM +0100, Rikard Falkeborn wrote:
>> Arguments are supposed to be ordered high then low.
>> 
>> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
>> ---
>> Spotted while trying to add compile time checks of GENMASK arguments.
>> Patch has only been compile tested.
>
>thank you!
>
>Tested-by: Ondrej Jirman <megous@megous.com>

Does it affect or fix the performance?

>
>regards,
>	o.
>
>>  drivers/phy/allwinner/phy-sun50i-usb3.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c
>b/drivers/phy/allwinner/phy-sun50i-usb3.c
>> index 1169f3e83a6f..b1c04f71a31d 100644
>> --- a/drivers/phy/allwinner/phy-sun50i-usb3.c
>> +++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
>> @@ -49,7 +49,7 @@
>>  #define SUNXI_LOS_BIAS(n)		((n) << 3)
>>  #define SUNXI_LOS_BIAS_MASK		GENMASK(5, 3)
>>  #define SUNXI_TXVBOOSTLVL(n)		((n) << 0)
>> -#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(0, 2)
>> +#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(2, 0)
>>  
>>  struct sun50i_usb3_phy {
>>  	struct phy *phy;
>> -- 
>> 2.24.0
>> 
