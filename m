Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C9E50057
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 05:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfFXDrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 23:47:00 -0400
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:44831 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727132AbfFXDrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:47:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E5BE8837F24C;
        Mon, 24 Jun 2019 03:46:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:152:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:4823:5007:6119:7903:8784:10004:10400:10848:11026:11232:11233:11473:11657:11658:11914:12043:12048:12296:12297:12438:12740:12895:13069:13311:13357:13894:14096:14097:14659:14721:14777:21063:21080:21451:21627:30012:30026:30054:30070:30091,0,RBL:23.242.70.174:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: dust72_279b0f5cc505
X-Filterd-Recvd-Size: 3038
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Jun 2019 03:46:56 +0000 (UTC)
Message-ID: <f7af76e8237f490f75d9f2624127e01c55476d2f.camel@perches.com>
Subject: Re: [PATCH -next v2] drm/amdgpu: return 'ret' in amdgpu_pmu_init
From:   Joe Perches <joe@perches.com>
To:     maowenan <maowenan@huawei.com>, airlied@linux.ie, daniel@ffwll.ch,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, dan.carpenter@oracle.com, julia.lawall@lip6.fr
Cc:     kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jonathan Kim <jonathan.kim@amd.com>
Date:   Sun, 23 Jun 2019 20:46:55 -0700
In-Reply-To: <b468d765-bef7-70a8-9a14-bad0e6ed14df@huawei.com>
References: <20190622104318.GT28859@kadam>
         <20190622130527.182022-1-maowenan@huawei.com>
         <0ab82cdb0bec30e7e431f106f8e0e9d141491555.camel@perches.com>
         <b468d765-bef7-70a8-9a14-bad0e6ed14df@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-24 at 11:41 +0800, maowenan wrote:
> 
> On 2019/6/23 2:13, Joe Perches wrote:
> > On Sat, 2019-06-22 at 21:05 +0800, Mao Wenan wrote:
> > > There is one warning:
> > > drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
> > > drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> > >   int ret = 0;
> > []
> > >  v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
> > >  amdgpu_pmu_init().
> > []
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> > []
> > > @@ -252,8 +252,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
> > >  	case CHIP_VEGA20:
> > >  		/* init df */
> > >  		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
> > > -				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
> > > -				       DF_V3_6_MAX_COUNTERS);
> > > +							   "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
> > > +							   DF_V3_6_MAX_COUNTERS);
> > 
> > trivia:
> > 
> > The indentation change seems superfluous and
> > appears to make the code harder to read.
> > 
> > You could also cc Jonathan Kim who wrote all of this.
> I think this is just display issue in mail format. It is correct that in vi/vim.
> The arguments are line up with '(' after my change.

Use 8 character tabs and try again please.

> @@ -252,8 +252,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)$
>  ^Icase CHIP_VEGA20:$
>  ^I^I/* init df */$
>  ^I^Iret = init_pmu_by_type(adev, df_v3_6_attr_groups,$
> -^I^I^I^I       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,$
> -^I^I^I^I       DF_V3_6_MAX_COUNTERS);$
> +^I^I^I^I^I^I^I   "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,$
> +^I^I^I^I^I^I^I   DF_V3_6_MAX_COUNTERS);$


