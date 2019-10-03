Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07C6C9FE2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 15:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfJCNxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 09:53:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:55653 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfJCNxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:53:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 06:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,252,1566889200"; 
   d="scan'208";a="192127166"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga007.fm.intel.com with SMTP; 03 Oct 2019 06:53:19 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 03 Oct 2019 16:53:18 +0300
Date:   Thu, 3 Oct 2019 16:53:18 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        kernel@collabora.com, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm: Fix comment doc for format_modifiers
Message-ID: <20191003135318.GH1208@intel.com>
References: <20191002183011.GA29177@ravnborg.org>
 <20191003075118.6257-1-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191003075118.6257-1-andrzej.p@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 09:51:18AM +0200, Andrzej Pietrasiewicz wrote:
> To human readers

The commit message is always for human readers, no need to point that
out...

> 
> "array of struct drm_format modifiers" is almost indistinguishable from
> "array of struct drm_format_modifiers", especially given that
> struct drm_format_modifier does exist.

..but this paragraph still manages to 100% confuse this particular human.

The actual code changes lgtm, so with the commit message reworded
this patch is
Reviewed-by: Ville Syrj�l� <ville.syrjala@linux.intel.com>

> 
> And indeed the parameter passes an array of uint64_t rather than an array
> of structs, but the first words of the comment suggest that it passes
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> ---
>  drivers/gpu/drm/drm_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index d6ad60ab0d38..0d4f9172c0dd 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -160,7 +160,7 @@ static int create_in_format_blob(struct drm_device *dev, struct drm_plane *plane
>   * @funcs: callbacks for the new plane
>   * @formats: array of supported formats (DRM_FORMAT\_\*)
>   * @format_count: number of elements in @formats
> - * @format_modifiers: array of struct drm_format modifiers terminated by
> + * @format_modifiers: array of format modifiers terminated by
>   *                    DRM_FORMAT_MOD_INVALID
>   * @type: type of plane (overlay, primary, cursor)
>   * @name: printf style format string for the plane name, or NULL for default name
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrj�l�
Intel
