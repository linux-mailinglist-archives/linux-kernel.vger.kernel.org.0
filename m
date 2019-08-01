Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 532557E331
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 21:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbfHATQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 15:16:30 -0400
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:55866 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726118AbfHATQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:16:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C848318029123;
        Thu,  1 Aug 2019 19:16:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1500:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3871:3872:3874:4321:4605:5007:6742:7576:9040:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13095:13311:13357:13439:14181:14659:14721:21080:21433:21451:21611:21627:30029:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: ring06_8f6c4551ca725
X-Filterd-Recvd-Size: 3026
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 19:16:24 +0000 (UTC)
Message-ID: <ce8c8a7342282467c3b681fd1b0874817250c16e.camel@perches.com>
Subject: Re: [PATCH][drm-next] drm/amd/powerplay: fix a few spelling mistakes
From:   Joe Perches <joe@perches.com>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Colin King <colin.king@canonical.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Aug 2019 12:16:23 -0700
In-Reply-To: <CADnq5_OdBM83zkkgtjwzQ0jqsiDP5wZoMXioGcq4mycX2=Tavw@mail.gmail.com>
References: <20190801083941.4230-1-colin.king@canonical.com>
         <CADnq5_OdBM83zkkgtjwzQ0jqsiDP5wZoMXioGcq4mycX2=Tavw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 15:02 -0400, Alex Deucher wrote:
> Applied.  thanks!
> 
> Alex
> 
> On Thu, Aug 1, 2019 at 4:39 AM Colin King <colin.king@canonical.com> wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There are a few spelling mistakes "unknow" -> "unknown" and
> > "enabeld" -> "enabled". Fix these.
[]
> > diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
[]
> > @@ -39,7 +39,7 @@ static const char* __smu_message_names[] = {
> >  const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type)
> >  {
> >         if (type < 0 || type > SMU_MSG_MAX_COUNT)

This looks like an off-by-one test against
SMU_MSG_MAX_COUNT where type
should be >=

> > -               return "unknow smu message";
> > +               return "unknown smu message";
> >         return __smu_message_names[type];
[]
> > @@ -52,7 +52,7 @@ static const char* __smu_feature_names[] = {
> >  const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask feature)
> >  {
> >         if (feature < 0 || feature > SMU_FEATURE_COUNT)

here too

> > -               return "unknow smu feature";
> > +               return "unknown smu feature";
> >         return __smu_feature_names[feature];

Perhaps instead it should be against ARRAY_SIZE(__smu_<foo>)

Also, the  __SMU_DUMMY_MAP macro is unnecessarily complex.

It might be better to have some direct
index and name struct like

struct enum_name {
	int val;
	const char *name;
};

And walk that.

Perhaps add a macro like

#define enum_map(e)
	{.val = e, .name = #e}


