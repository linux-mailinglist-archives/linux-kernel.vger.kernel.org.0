Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230364F7BF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 20:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfFVSNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 14:13:31 -0400
Received: from smtprelay0129.hostedemail.com ([216.40.44.129]:51928 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725995AbfFVSNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 14:13:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 90855181D33FC;
        Sat, 22 Jun 2019 18:13:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:152:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:4321:4605:5007:7903:10004:10400:10848:11026:11232:11233:11473:11657:11658:11914:12043:12048:12296:12297:12438:12679:12740:12895:13069:13161:13229:13311:13357:13894:14659:14721:21063:21080:21451:21627:30012:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: guide54_1e3a390309d01
X-Filterd-Recvd-Size: 2148
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat, 22 Jun 2019 18:13:27 +0000 (UTC)
Message-ID: <0ab82cdb0bec30e7e431f106f8e0e9d141491555.camel@perches.com>
Subject: Re: [PATCH -next v2] drm/amdgpu: return 'ret' in amdgpu_pmu_init
From:   Joe Perches <joe@perches.com>
To:     Mao Wenan <maowenan@huawei.com>, airlied@linux.ie, daniel@ffwll.ch,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, dan.carpenter@oracle.com, julia.lawall@lip6.fr
Cc:     kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jonathan Kim <jonathan.kim@amd.com>
Date:   Sat, 22 Jun 2019 11:13:26 -0700
In-Reply-To: <20190622130527.182022-1-maowenan@huawei.com>
References: <20190622104318.GT28859@kadam>
         <20190622130527.182022-1-maowenan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-06-22 at 21:05 +0800, Mao Wenan wrote:
> There is one warning:
> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>   int ret = 0;
[]
>  v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
>  amdgpu_pmu_init().
[]
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
[]
> @@ -252,8 +252,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>  	case CHIP_VEGA20:
>  		/* init df */
>  		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
> -				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
> -				       DF_V3_6_MAX_COUNTERS);
> +							   "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
> +							   DF_V3_6_MAX_COUNTERS);

trivia:

The indentation change seems superfluous and
appears to make the code harder to read.

You could also cc Jonathan Kim who wrote all of this.


