Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3EB026650
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfEVOwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 10:52:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:58335 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbfEVOwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:52:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 07:52:18 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 May 2019 07:52:16 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Gen Zhang <blackgod016574@gmail.com>, sean@poorly.run
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm_edid-load: Fix a missing-check bug in drivers/gpu/drm/drm_edid_load.c
In-Reply-To: <20190522123920.GB6772@zhanggen-UX430UQ>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190522123920.GB6772@zhanggen-UX430UQ>
Date:   Wed, 22 May 2019 17:55:35 +0300
Message-ID: <87o93u7d3s.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019, Gen Zhang <blackgod016574@gmail.com> wrote:
> In drm_load_edid_firmware(), fwstr is allocated by kstrdup(). And fwstr
> is dereferenced in the following codes. However, memory allocation 
> functions such as kstrdup() may fail and returns NULL. Dereferencing 
> this null pointer may cause the kernel go wrong. Thus we should check 
> this kstrdup() operation.
> Further, if kstrdup() returns NULL, we should return ERR_PTR(-ENOMEM) to
> the caller site.

strsep() handles the NULL pointer just fine, so there won't be a NULL
dereference. However this patch seems like the right thing to do anyway.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
>
> ---
> diff --git a/drivers/gpu/drm/drm_edid_load.c b/drivers/gpu/drm/drm_edid_load.c
> index a491509..a0e107a 100644
> --- a/drivers/gpu/drm/drm_edid_load.c
> +++ b/drivers/gpu/drm/drm_edid_load.c
> @@ -290,6 +290,8 @@ struct edid *drm_load_edid_firmware(struct drm_connector *connector)
>  	 * the last one found one as a fallback.
>  	 */
>  	fwstr = kstrdup(edid_firmware, GFP_KERNEL);
> +	if (!fwstr)
> +		return ERR_PTR(-ENOMEM);
>  	edidstr = fwstr;
>  
>  	while ((edidname = strsep(&edidstr, ","))) {
> ---
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Jani Nikula, Intel Open Source Graphics Center
