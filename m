Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8EE4F468A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 12:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390371AbfKHLnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 06:43:09 -0500
Received: from vps.xff.cz ([195.181.215.36]:46966 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390303AbfKHLnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1573213381; bh=lE0IEyhRZdzSCV11eufQ/7MoeNiErKeSnathaLA1lNU=;
        h=Date:From:To:Subject:X-My-GPG-KeyId:References:From;
        b=N02473gjGfoh4FNolyioo32WH6IieZfnLJyQNsMA0nPAvDQkTSDPisLlvb3n3SXHO
         7AVe8qFjWddBloPUZwFm5DUw3VMc4Aqy730ScMHIW1+8dTjaChczSKoMoNEdUB//M4
         Lb5+/V0MW/FyCAzq0khvPJrtjxUGzimQera7k3vI=
Date:   Fri, 8 Nov 2019 12:43:01 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Icenowy Zheng <icenowy@aosc.io>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>, arnd@arndb.de,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        kishon@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        mark.rutland@arm.com, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, robh+dt@kernel.org,
        tglx@linutronix.de, wens@csie.org
Subject: Re: [PATCH] phy: allwinner: Fix GENMASK misuse
Message-ID: <20191108114301.v3663hs5ftjsoec3@core.my.home>
Mail-Followup-To: Icenowy Zheng <icenowy@aosc.io>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>, arnd@arndb.de,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        kishon@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        mark.rutland@arm.com, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, robh+dt@kernel.org,
        tglx@linutronix.de, wens@csie.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20191020134229.1216351-3-megous@megous.com>
 <20191107204645.13739-1-rikard.falkeborn@gmail.com>
 <20191107214514.kcz42mcehyrrif4o@core.my.home>
 <F563E52E-72BF-4297-A14F-DDE2B490DADB@aosc.io>
 <20191108114138.snghk5n7kwuw7zz3@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191108114138.snghk5n7kwuw7zz3@core.my.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 12:41:39PM +0100, megous hlavni wrote:
> On Fri, Nov 08, 2019 at 07:29:21PM +0800, Icenowy Zheng wrote:
> > 
> > 
> > 于 2019年11月8日 GMT+08:00 上午5:45:14, "Ondřej Jirman" <megous@megous.com> 写到:
> > >Hello Rikard,
> > >
> > >On Thu, Nov 07, 2019 at 09:46:45PM +0100, Rikard Falkeborn wrote:
> > >> Arguments are supposed to be ordered high then low.
> > >> 
> > >> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > >> ---
> > >> Spotted while trying to add compile time checks of GENMASK arguments.
> > >> Patch has only been compile tested.
> > >
> > >thank you!
> > >
> > >Tested-by: Ondrej Jirman <megous@megous.com>
> > 
> > Does it affect or fix the performance?
> 
> See here: https://forum.armbian.com/topic/10131-orange-pi-lite2-usb3-now-working/?do=findComment&comment=88904
> 
> Quote:
> 
> > It may or may not help. On Opi3 I see no change, probably because HUB is
> > really close to the SoC, but on boards without a HUB, SoC's USB3 phy will
> > have to drive the signal over the longer cable and this patch might benefit
> > those boards. 
> 
> Maybe someone with boards without PHY will test it more.

Eh, on boards without a USB3 HUB.

> regards,
> 	o.
> 
> > >
> > >regards,
> > >	o.
> > >
> > >>  drivers/phy/allwinner/phy-sun50i-usb3.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >> 
> > >> diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c
> > >b/drivers/phy/allwinner/phy-sun50i-usb3.c
> > >> index 1169f3e83a6f..b1c04f71a31d 100644
> > >> --- a/drivers/phy/allwinner/phy-sun50i-usb3.c
> > >> +++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
> > >> @@ -49,7 +49,7 @@
> > >>  #define SUNXI_LOS_BIAS(n)		((n) << 3)
> > >>  #define SUNXI_LOS_BIAS_MASK		GENMASK(5, 3)
> > >>  #define SUNXI_TXVBOOSTLVL(n)		((n) << 0)
> > >> -#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(0, 2)
> > >> +#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(2, 0)
> > >>  
> > >>  struct sun50i_usb3_phy {
> > >>  	struct phy *phy;
> > >> -- 
> > >> 2.24.0
> > >> 
