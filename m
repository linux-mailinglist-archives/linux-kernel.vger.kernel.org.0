Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30BC117A476
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 12:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCELk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 06:40:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:54812 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgCELk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:40:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 03:40:56 -0800
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="234389164"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 03:40:52 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] drm/drm_displayid.h: Replace zero-length array with flexible-array member
In-Reply-To: <20200305110105.GA21188@embeddedor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200305110105.GA21188@embeddedor>
Date:   Thu, 05 Mar 2020 13:40:49 +0200
Message-ID: <87y2sfni66.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Mar 2020, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  include/drm/drm_displayid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/drm/drm_displayid.h b/include/drm/drm_displayid.h
> index 9d3b745c3107..94b4390bf990 100644
> --- a/include/drm/drm_displayid.h
> +++ b/include/drm/drm_displayid.h
> @@ -89,7 +89,7 @@ struct displayid_detailed_timings_1 {
>  
>  struct displayid_detailed_timing_block {
>  	struct displayid_block base;
> -	struct displayid_detailed_timings_1 timings[0];
> +	struct displayid_detailed_timings_1 timings[];
>  };
>  
>  #define for_each_displayid_db(displayid, block, idx, length) \

-- 
Jani Nikula, Intel Open Source Graphics Center
