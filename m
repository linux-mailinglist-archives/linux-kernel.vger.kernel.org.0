Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D378E169313
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 03:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBWCQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 21:16:41 -0500
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:51709 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726884AbgBWCQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:16:41 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D6704837F24D;
        Sun, 23 Feb 2020 02:16:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2560:2563:2682:2685:2731:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:7903:8784:8985:9025:10004:10400:10848:11026:11232:11473:11658:11854:11914:12043:12050:12114:12297:12438:12555:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21611:21627:21788:30054:30056:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: tank92_1ce31dc6cfa4f
X-Filterd-Recvd-Size: 2400
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 23 Feb 2020 02:16:38 +0000 (UTC)
Message-ID: <7792266dfede1df5742e527dc304b610fcfbd025.camel@perches.com>
Subject: Re: [PATCH] phy: phy-meson-g12a-usb2: Fix GENMASK misuse
From:   Joe Perches <joe@perches.com>
To:     Ondrej Jirman <megous@megous.com>, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>
Date:   Sat, 22 Feb 2020 18:15:12 -0800
In-Reply-To: <20200222235142.242732-1-megous@megous.com>
References: <20200222235142.242732-1-megous@megous.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-02-23 at 00:51 +0100, Ondrej Jirman wrote:
> Arguments to GENMASK should be msb >= lsb.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
> I just grepped the whole kernel tree for GENMASK argument order issues,
> and this is one of the three that popped up. No testing was done.

Both of these were submitted last year.
https://lkml.org/lkml/2019/7/10/20

I hope they get applied one day.

Neither patch has an affect today as none of the
#defines are used.

Perhaps deleting the #defines is better.

>  drivers/phy/amlogic/phy-meson-g12a-usb2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> index 9065ffc85eb47..cd7eccab26490 100644
> --- a/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> @@ -66,7 +66,7 @@
>  #define PHY_CTRL_R14						0x38
>  	#define PHY_CTRL_R14_I_RDP_EN				BIT(0)
>  	#define PHY_CTRL_R14_I_RPU_SW1_EN			BIT(1)
> -	#define PHY_CTRL_R14_I_RPU_SW2_EN			GENMASK(2, 3)
> +	#define PHY_CTRL_R14_I_RPU_SW2_EN			GENMASK(3, 2)
>  	#define PHY_CTRL_R14_PG_RSTN				BIT(4)
>  	#define PHY_CTRL_R14_I_C2L_DATA_16_8			BIT(5)
>  	#define PHY_CTRL_R14_I_C2L_ASSERT_SINGLE_EN_ZERO	BIT(6)

