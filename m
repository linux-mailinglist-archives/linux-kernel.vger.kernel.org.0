Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D33FB5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 17:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfKMQ4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 11:56:08 -0500
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:53376 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726129AbfKMQ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:56:08 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 30073100E7B40;
        Wed, 13 Nov 2019 16:56:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::,RULES_HIT:41:152:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:3138:3139:3140:3141:3142:3352:3622:3865:3868:3870:4321:5007:6119:7903:10004:10400:10471:10848:11026:11232:11473:11657:11658:11914:12043:12048:12296:12297:12438:12740:12895:13069:13255:13311:13357:13894:13972:14181:14659:14721:21080:21451:21627:30041:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: cloth41_18055f6faa706
X-Filterd-Recvd-Size: 2543
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed, 13 Nov 2019 16:56:04 +0000 (UTC)
Message-ID: <ac4566662a04e0c25039df7ed30789d0792885cd.camel@perches.com>
Subject: Re: [PATCH 1/7] drm/amdgpu: remove set but not used variable
 'mc_shared_chmap' from 'gfx_v6_0.c' and 'gfx_v7_0.c'
From:   Joe Perches <joe@perches.com>
To:     yu kuai <yukuai3@huawei.com>, alexander.deucher@amd.com,
        Felix.Kuehling@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Rex.Zhu@amd.com, evan.quan@amd.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com
Date:   Wed, 13 Nov 2019 08:55:47 -0800
In-Reply-To: <1573649074-72589-2-git-send-email-yukuai3@huawei.com>
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
         <1573649074-72589-2-git-send-email-yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-13 at 20:44 +0800, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c: In function
> ‘gfx_v6_0_constants_init’:
> drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c:1579:6: warning: variable
> ‘mc_shared_chmap’ set but not used [-Wunused-but-set-variable]
[]
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
[]
> @@ -1678,7 +1678,6 @@ static void gfx_v6_0_constants_init(struct amdgpu_device *adev)
>  
>  	WREG32(mmBIF_FB_EN, BIF_FB_EN__FB_READ_EN_MASK | BIF_FB_EN__FB_WRITE_EN_MASK);
>  
> -	mc_shared_chmap = RREG32(mmMC_SHARED_CHMAP);

I do not know the hardware but frequently hardware like
this has read ordering requirements and various registers
can not be read in a random order.

Does removing this read have no effect on the hardware?

>  	adev->gfx.config.mc_arb_ramcfg = RREG32(mmMC_ARB_RAMCFG);
>  	mc_arb_ramcfg = adev->gfx.config.mc_arb_ramcfg;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
[]
> @@ -4336,7 +4336,6 @@ static void gfx_v7_0_gpu_early_init(struct amdgpu_device *adev)
>  		break;
>  	}
>  
> -	mc_shared_chmap = RREG32(mmMC_SHARED_CHMAP);
>  	adev->gfx.config.mc_arb_ramcfg = RREG32(mmMC_ARB_RAMCFG);
>  	mc_arb_ramcfg = adev->gfx.config.mc_arb_ramcfg;

Same question.

