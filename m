Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA77F86F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 03:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKLCjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 21:39:35 -0500
Received: from smtprelay0079.hostedemail.com ([216.40.44.79]:46010 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726928AbfKLCjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:39:35 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 7B961181D3026;
        Tue, 12 Nov 2019 02:39:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3866:3868:3871:3872:4321:5007:6737:7903:8957:9592:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12048:12296:12297:12555:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: end54_35f6dbbf31b05
X-Filterd-Recvd-Size: 2553
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Nov 2019 02:39:30 +0000 (UTC)
Message-ID: <01c630e6d4c58b3f6184603e158f53fb9aaeae7d.camel@perches.com>
Subject: Re: [PATCH -next] drm/amd/display: Fix old-style declaration
From:   Joe Perches <joe@perches.com>
To:     YueHaibing <yuehaibing@huawei.com>, harry.wentland@amd.com,
        sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com, Jun.Lei@amd.com,
        David.Francis@amd.com, Dmytro.Laktyushkin@amd.com,
        nicholas.kazlauskas@amd.com, martin.leung@amd.com,
        Chris.Park@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 Nov 2019 18:39:15 -0800
In-Reply-To: <20191111122801.18584-1-yuehaibing@huawei.com>
References: <20191111122801.18584-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-11-11 at 20:28 +0800, YueHaibing wrote:
> Fix a build warning:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:75:1:
>  warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
[]
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
[]
> @@ -69,7 +69,7 @@
>  #define DC_LOGGER \
>  	dc->ctx->logger
>  
> -const static char DC_BUILD_ID[] = "production-build";
> +static const char DC_BUILD_ID[] = "production-build";

DC_BUILD_ID is used exactly once.
Maybe just use it directly and remove DC_BUILD_ID instead?

---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1fdba13..803dc14 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -69,8 +69,6 @@
 #define DC_LOGGER \
 	dc->ctx->logger
 
-const static char DC_BUILD_ID[] = "production-build";
-
 /**
  * DOC: Overview
  *
@@ -815,7 +813,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 	if (dc->res_pool->dmcu != NULL)
 		dc->versions.dmcu_version = dc->res_pool->dmcu->dmcu_version;
 
-	dc->build_id = DC_BUILD_ID;
+	dc->build_id = "production-build";
 
 	DC_LOG_DC("Display Core initialized\n");
 


