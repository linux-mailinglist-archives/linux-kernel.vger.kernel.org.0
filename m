Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B94C21185DA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 12:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfLJLKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 06:10:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:39249 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfLJLKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:10:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 03:10:25 -0800
X-IronPort-AV: E=Sophos;i="5.69,299,1571727600"; 
   d="scan'208";a="207247012"
Received: from rmoran-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.35.46])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 03:10:21 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     allen <allen.chen@ite.com.tw>
Cc:     Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        open list <linux-kernel@vger.kernel.org>,
        "open list\:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Pi-Hsun Shih <pihsun@chromium.org>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm/edid: fixup EDID 1.3 and 1.4 judge reduced-blanking timings logic
In-Reply-To: <1574761572-26585-1-git-send-email-allen.chen@ite.com.tw>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1574761572-26585-1-git-send-email-allen.chen@ite.com.tw>
Date:   Tue, 10 Dec 2019 13:10:18 +0200
Message-ID: <87r21ce8rp.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019, allen <allen.chen@ite.com.tw> wrote:
> According to VESA ENHANCED EXTENDED DISPLAY IDENTIFICATION DATA STANDARD
> (Defines EDID Structure Version 1, Revision 4) page: 39
> How to determine whether the monitor support RB timing or not?
> EDID 1.4
> First:  read detailed timing descriptor and make sure byte 0 = 0x00,
> 	byte 1 = 0x00, byte 2 = 0x00 and byte 3 = 0xFD
> Second: read EDID bit 0 in feature support byte at address 18h = 1
> 	and detailed timing descriptor byte 10 = 0x04
> Third:  if EDID bit 0 in feature support byte = 1 &&
> 	detailed timing descriptor byte 10 = 0x04
> 	then we can check byte 15, if bit 4 in byte 15 = 1 is support RB
>         if EDID bit 0 in feature support byte != 1 ||
> 	detailed timing descriptor byte 10 != 0x04,
> 	then byte 15 can not be used
>
> The linux code is_rb function not follow the VESA's rule
>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index f5926bf..e11e585 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -93,6 +93,12 @@ struct detailed_mode_closure {
>  	int modes;
>  };
>  
> +struct edid_support_rb_closure {
> +	struct edid *edid;
> +	bool valid_support_rb;
> +	bool support_rb;
> +};
> +
>  #define LEVEL_DMT	0
>  #define LEVEL_GTF	1
>  #define LEVEL_GTF2	2
> @@ -2017,23 +2023,41 @@ struct drm_display_mode *drm_mode_find_dmt(struct drm_device *dev,
>  	}
>  }
>  
> +static bool
> +is_display_descriptor(const u8 *r, u8 tag)
> +{
> +	return (!r[0] && !r[1] && !r[2] && r[3] == tag) ? true : false;
> +}
> +
>  static void
>  is_rb(struct detailed_timing *t, void *data)
>  {
>  	u8 *r = (u8 *)t;
> -	if (r[3] == EDID_DETAIL_MONITOR_RANGE)
> -		if (r[15] & 0x10)
> -			*(bool *)data = true;
> +	struct edid_support_rb_closure *closure = data;
> +	struct edid *edid = closure->edid;
> +
> +	if (is_display_descriptor(r, EDID_DETAIL_MONITOR_RANGE)) {
> +		if (edid->features & BIT(0) && r[10] == BIT(2)) {

I'll try to explain my original comment again.

Consider edid->features & BIT(0). It remains unchanged across the
iteration. The code will only change anything if edid->features &
BIT(0).

> +			closure->valid_support_rb = true;
> +			closure->support_rb = (r[15] & 0x10) ? true : false;

You could combine these to e.g. a single int.

	if (r[10] == BIT(2)) {
		int *ret = data;
		*ret = !!(r[15] & 0x10);
	}

> +		}
> +	}
>  }
>  
>  /* EDID 1.4 defines this explicitly.  For EDID 1.3, we guess, badly. */
>  static bool
>  drm_monitor_supports_rb(struct edid *edid)
>  {
> +	struct edid_support_rb_closure closure = {
> +		.edid = edid,
> +		.valid_support_rb = false,
> +		.support_rb = false,
> +	};
> +
>  	if (edid->revision >= 4) {
> -		bool ret = false;
> -		drm_for_each_detailed_block((u8 *)edid, is_rb, &ret);
> -		return ret;
> +		drm_for_each_detailed_block((u8 *)edid, is_rb, &closure);
> +		if (closure.valid_support_rb)
> +			return closure.support_rb;

Here, you'd do:

        if (edid->features & BIT(0)) {
        	int ret = -1;
		drm_for_each_detailed_block((u8 *)edid, is_rb, &ret);
                if (ret != -1)
                	return ret;
	}


>  	}
>  
>  	return ((edid->input & DRM_EDID_INPUT_DIGITAL) != 0);

-- 
Jani Nikula, Intel Open Source Graphics Center
