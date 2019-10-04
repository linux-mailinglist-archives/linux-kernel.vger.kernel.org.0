Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E136CC358
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 21:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbfJDTIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 15:08:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:39662 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730393AbfJDTIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:08:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 12:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="196758338"
Received: from lpindor-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.17.203])
  by orsmga006.jf.intel.com with ESMTP; 04 Oct 2019 12:08:27 -0700
Date:   Fri, 4 Oct 2019 20:08:26 +0100
From:   Eric Engestrom <eric.engestrom@intel.com>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, kernel@collabora.com,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm: Fix comment doc for format_modifiers
Message-ID: <20191004190826.x26gb5wnurmwobej@intel.com>
References: <20191002183011.GA29177@ravnborg.org>
 <20191003075118.6257-1-andrzej.p@collabora.com>
 <20191003135318.GH1208@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191003135318.GH1208@intel.com>
Organization: Intel Corporation (UK) Ltd. - Co. Reg. 1134945 - Pipers Way,
 Swindon SN3 1RJ
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 2019-10-03 16:53:18 +0300, Ville Syrjälä wrote:
> On Thu, Oct 03, 2019 at 09:51:18AM +0200, Andrzej Pietrasiewicz wrote:
> > To human readers
> 
> The commit message is always for human readers, no need to point that
> out...
> 
> > 
> > "array of struct drm_format modifiers" is almost indistinguishable from
> > "array of struct drm_format_modifiers", especially given that
> > struct drm_format_modifier does exist.
> 
> ..but this paragraph still manages to 100% confuse this particular human.

There's an underscore instead of a space on the second line
(s/drm_format modifiers/drm_format_modifiers/).

It should definitely be reworded to be much clearer.

> 
> The actual code changes lgtm, so with the commit message reworded
> this patch is
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> > 
> > And indeed the parameter passes an array of uint64_t rather than an array
> > of structs, but the first words of the comment suggest that it passes
> > 
> > Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> > ---
> >  drivers/gpu/drm/drm_plane.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> > index d6ad60ab0d38..0d4f9172c0dd 100644
> > --- a/drivers/gpu/drm/drm_plane.c
> > +++ b/drivers/gpu/drm/drm_plane.c
> > @@ -160,7 +160,7 @@ static int create_in_format_blob(struct drm_device *dev, struct drm_plane *plane
> >   * @funcs: callbacks for the new plane
> >   * @formats: array of supported formats (DRM_FORMAT\_\*)
> >   * @format_count: number of elements in @formats
> > - * @format_modifiers: array of struct drm_format modifiers terminated by
> > + * @format_modifiers: array of format modifiers terminated by
> >   *                    DRM_FORMAT_MOD_INVALID
> >   * @type: type of plane (overlay, primary, cursor)
> >   * @name: printf style format string for the plane name, or NULL for default name
> > -- 
> > 2.17.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
