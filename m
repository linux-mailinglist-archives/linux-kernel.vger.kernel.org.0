Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B938189129
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 23:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCQWPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 18:15:20 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:46094 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726476AbgCQWPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:15:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C9D5C181D330D;
        Tue, 17 Mar 2020 22:15:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7903:9025:10004:10400:10848:11232:11658:11914:12043:12297:12438:12555:12663:12740:12760:12895:12986:13069:13071:13161:13229:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21080:21433:21451:21627:21811:21939:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: chin52_2e3840607711f
X-Filterd-Recvd-Size: 2086
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Mar 2020 22:15:17 +0000 (UTC)
Message-ID: <623eb1bc61951ed3c68a9224b9aa99a25e763913.camel@perches.com>
Subject: Re: [PATCH 1/3] drm: drm_vm: Use fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 Mar 2020 15:13:29 -0700
In-Reply-To: <20200317164806.GO2363188@phenom.ffwll.local>
References: <cover.1584040050.git.joe@perches.com>
         <398db73cdc8a584fd7f34f5013c04df13ba90f64.1584040050.git.joe@perches.com>
         <20200317164806.GO2363188@phenom.ffwll.local>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-17 at 17:48 +0100, Daniel Vetter wrote:
> On Thu, Mar 12, 2020 at 12:17:12PM -0700, Joe Perches wrote:
> > Convert /* fallthrough */ style comments to fallthrough;
> > 
> > Convert the various uses of fallthrough comments to fallthrough;
> > 
> > Done via script
> > Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/
> > 
> > And by hand:
> > 
> > This file has a fallthrough comment outside of an #ifdef block
> > that causes gcc to emit a warning if converted in-place.
> > 
> > So move the new fallthrough; inside the containing #ifdef/#endif too.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I'm assuming this all lands through a special pull? Or should I apply
> this?

Hi Daniel.

I think you should apply this.

The idea here is to allow a scripted conversion at some
point and this patch is necessary to avoid new compiler
warnings after running the script.


