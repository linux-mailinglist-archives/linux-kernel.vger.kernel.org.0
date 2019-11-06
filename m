Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11EF7F1C07
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 18:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbfKFRDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 12:03:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:56208 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbfKFRDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:03:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 09:03:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="200766728"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga008.fm.intel.com with SMTP; 06 Nov 2019 09:03:18 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 06 Nov 2019 19:03:17 +0200
Date:   Wed, 6 Nov 2019 19:03:17 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] drm: Limit to INT_MAX in create_blob ioctl
Message-ID: <20191106170317.GU1208@intel.com>
References: <20191106164755.31478-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191106164755.31478-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 05:47:55PM +0100, Daniel Vetter wrote:
> The hardened usercpy code is too paranoid ever since:
> 
> commit 6a30afa8c1fbde5f10f9c584c2992aa3c7f7a8fe
> Author: Kees Cook <keescook@chromium.org>
> Date:   Wed Nov 6 16:07:01 2019 +1100
> 
>     uaccess: disallow > INT_MAX copy sizes
> 
> Code itself should have been fine as-is.
> 
> Reported-by: syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com
> Fixes: 6a30afa8c1fb ("uaccess: disallow > INT_MAX copy sizes")
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> --
> Kees/Andrew,
> 
> Since this is -mm can I have a stable sha1 or something for
> referencing? Or do you want to include this in the -mm patch bomb for
> the merge window?
> -Daniel
> ---
>  drivers/gpu/drm/drm_property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
> index 892ce636ef72..6ee04803c362 100644
> --- a/drivers/gpu/drm/drm_property.c
> +++ b/drivers/gpu/drm/drm_property.c
> @@ -561,7 +561,7 @@ drm_property_create_blob(struct drm_device *dev, size_t length,
>  	struct drm_property_blob *blob;
>  	int ret;
>  
> -	if (!length || length > ULONG_MAX - sizeof(struct drm_property_blob))
> +	if (!length || length > INT_MAX - sizeof(struct drm_property_blob))
>  		return ERR_PTR(-EINVAL);

INT_MAX should be more than enough.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

>  
>  	blob = kvzalloc(sizeof(struct drm_property_blob)+length, GFP_KERNEL);
> -- 
> 2.24.0.rc2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
