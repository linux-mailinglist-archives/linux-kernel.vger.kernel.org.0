Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD1175159
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 16:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfGYOhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 10:37:23 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:38403 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729058AbfGYOhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:37:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 68FA18047AB9;
        Thu, 25 Jul 2019 14:37:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2198:2199:2393:2553:2559:2562:2828:2911:3138:3139:3140:3141:3142:3354:3622:3865:3867:3868:3871:3872:4250:4321:4425:4605:5007:6119:7903:8784:9121:10004:10400:10848:11026:11232:11233:11473:11657:11658:11914:12043:12296:12297:12438:12555:12663:12740:12760:12895:12986:13069:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21611:21627:30054:30060:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: mist49_3f8efb7ea8d42
X-Filterd-Recvd-Size: 3266
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jul 2019 14:37:16 +0000 (UTC)
Message-ID: <cc582041ad4a33780a7101b3df9d03bf36a2a280.camel@perches.com>
Subject: Re: [PATCH 03/12] drm: aspeed_gfx: Fix misuse of GENMASK macro
From:   Joe Perches <joe@perches.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-aspeed@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 25 Jul 2019 07:37:14 -0700
In-Reply-To: <CACPK8Xd3+iwkuw-Ofwf+Hy1Ez5-1pBvnk_G4xT72ZQdOVd7Sag@mail.gmail.com>
References: <cover.1562734889.git.joe@perches.com>
         <cddd7ad7e9f81dec1e86c106f04229d21fc21920.1562734889.git.joe@perches.com>
         <2a0c5ef5c7e20b190156908991e4c964a501d80a.camel@perches.com>
         <4f6709f8-381f-415c-8569-798b074b66c5@www.fastmail.com>
         <4e5bc8d61436024a30a8fb6a1516e29e23a75ede.camel@perches.com>
         <CACPK8Xd3+iwkuw-Ofwf+Hy1Ez5-1pBvnk_G4xT72ZQdOVd7Sag@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-25 at 02:52 +0000, Joel Stanley wrote:
> On Thu, 25 Jul 2019 at 01:18, Joe Perches <joe@perches.com> wrote:
> > On Thu, 2019-07-25 at 10:40 +0930, Andrew Jeffery wrote:
> > > On Thu, 25 Jul 2019, at 02:46, Joe Perches wrote:
> > > > On Tue, 2019-07-09 at 22:04 -0700, Joe Perches wrote:
> > > > > Arguments are supposed to be ordered high then low.
> > > > > 
> > > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > > > ---
> > > > >  drivers/gpu/drm/aspeed/aspeed_gfx.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > > > index a10358bb61ec..095ea03e5833 100644
> > > > > --- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > > > +++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > > > @@ -74,7 +74,7 @@ int aspeed_gfx_create_output(struct drm_device *drm);
> > > > >  /* CTRL2 */
> > > > >  #define CRT_CTRL_DAC_EN                  BIT(0)
> > > > >  #define CRT_CTRL_VBLANK_LINE(x)          (((x) << 20) & CRT_CTRL_VBLANK_LINE_MASK)
> > > > > -#define CRT_CTRL_VBLANK_LINE_MASK        GENMASK(20, 31)
> > > > > +#define CRT_CTRL_VBLANK_LINE_MASK        GENMASK(31, 20)
> > > 
> > > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> > 
> > This hardly needs a review, it needs to be applied.
> > There's a nominal git tree for aspeed here:
> > 
> > T:      git git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
> > 
> > But who's going to do apply this?
> 
> This is a DRM patch, so it goes through the DRM tree. I am a
> co-maintainer there and can apply it once I remember how to drive the
> tools.
> 
> (FYI, this macro is not used by the current driver).

Then perhaps CRT_CTRL_VBLANK and _MASK defines
should be removed instead.

cheers, Joe

