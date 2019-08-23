Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22DCB9A6E4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 07:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391789AbfHWE7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 00:59:55 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:49885 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391664AbfHWE7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 00:59:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 73D998368F05;
        Fri, 23 Aug 2019 04:59:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3871:3872:4321:5007:8784:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12297:12438:12555:12740:12760:12895:12986:13069:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: farm80_39106449b3b1d
X-Filterd-Recvd-Size: 2482
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 23 Aug 2019 04:59:52 +0000 (UTC)
Message-ID: <59c7ff8f2306069095503b72824714e369a378f8.camel@perches.com>
Subject: Re: [PATCH 10/12] phy: amlogic: G12A: Fix misuse of GENMASK macro
From:   Joe Perches <joe@perches.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 22 Aug 2019 21:59:49 -0700
In-Reply-To: <6d7abb4d-fe68-8d02-d985-7214118be126@ti.com>
References: <cover.1562734889.git.joe@perches.com>
         <d149d2851f9aa2425c927cb8e311e20c4b83e186.1562734889.git.joe@perches.com>
         <c6cabf9c-7edd-eea8-3388-df781163cddd@baylibre.com>
         <6d7abb4d-fe68-8d02-d985-7214118be126@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-23 at 08:11 +0530, Kishon Vijay Abraham I wrote:
> 
> On 22/07/19 12:53 PM, Neil Armstrong wrote:
> > On 10/07/2019 07:04, Joe Perches wrote:
> > > Arguments are supposed to be ordered high then low.
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > > ---
> > >  drivers/phy/amlogic/phy-meson-g12a-usb2.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> > > index 9065ffc85eb4..cd7eccab2649 100644
> > > --- a/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> > > +++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
> > > @@ -66,7 +66,7 @@
> > >  #define PHY_CTRL_R14						0x38
> > >  	#define PHY_CTRL_R14_I_RDP_EN				BIT(0)
> > >  	#define PHY_CTRL_R14_I_RPU_SW1_EN			BIT(1)
> > > -	#define PHY_CTRL_R14_I_RPU_SW2_EN			GENMASK(2, 3)
> > > +	#define PHY_CTRL_R14_I_RPU_SW2_EN			GENMASK(3, 2)
> > >  	#define PHY_CTRL_R14_PG_RSTN				BIT(4)
> > >  	#define PHY_CTRL_R14_I_C2L_DATA_16_8			BIT(5)
> > >  	#define PHY_CTRL_R14_I_C2L_ASSERT_SINGLE_EN_ZERO	BIT(6)
> > > 
> > 
> > Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Shouldn't this go to stable trees as well?

The macro define is unused so it doesn't have to go into stable.

> -Kishon

