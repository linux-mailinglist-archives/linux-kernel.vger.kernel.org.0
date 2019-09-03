Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1828A7662
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 23:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfICVlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 17:41:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32949 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfICVlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:41:21 -0400
Received: by mail-lf1-f68.google.com with SMTP id d10so6234469lfi.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 14:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H1PZ5kr/dsAx4cT+3csxTLNZoAMXbRZcCQBAXYy5TT4=;
        b=KKOjF1/f+Z0h2Z0BKBQOo5FLzyYb10ANYNttnM4Damtx4objdFfaPYt9uf0Fpk6MW4
         +bLAinuaZOO9lMZhAZh+CEafF1gbvnDBZRF8gBDGGp8FN9OpCYHdjepUoNMIcPBq+xIf
         RfM0i91nWttVdX9k0r9M7tmvGACkG2jbjRYrm/oKl42pnrNbB/K9hX+Mm/J8st0DDs4Z
         aBpFpFpFfFu0oj3CqplIz0/lxFkjKxNTnH47xpuTsfpJYc19TpWXf6rcIvKxsYZ/2QDD
         lGPx2tnHZr8cOO7VVs7OzdqnR+2v9lOKqGVGpIC5+QJMPMPotdRctk313b0Ps8dSoCz8
         7S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H1PZ5kr/dsAx4cT+3csxTLNZoAMXbRZcCQBAXYy5TT4=;
        b=qmZtvV3DGf6fyzkm6nZOQ1lz60RvMdcyUqOmrbFzXP3fMf+w1mHpLLnCLa9n5sc3BN
         UY57LaIvy3OzC4cLpgb8QmTKmpKkbgCxL5DU29z9M+Rb/yKOvACP6wzGUgghl6BSCJQF
         NM1kkCQr0HG8Sj4p2harw6Uvc00UPbECJJh10jdNtQt0yzDxgNIf6AoOKcfsrsKAvIpI
         rc5eMzmHYAWXNy1zGzaVJ/UwjSbG5+aW+8+lDz3B5Gnh0/iJxJPoEOrn7znH1FL3uFWc
         5DYfcdU1NoigcNsUIFtTlVMN6Rfih8rT9diFJPgqYMnY3THfICbFY2FVq6rjxg2p5vy1
         KLsQ==
X-Gm-Message-State: APjAAAUSzqbASFbuOFy6A/mx6mxjASIDqRg626F/TmKKLX1gTYWPj96q
        Lirv3Aw9r7BvGQTF6nmnR4iIbl4JunfjErcKAuO6qorU
X-Google-Smtp-Source: APXvYqyOBelIp4G9zJKfaeg2cThEC8YLsrZgrTmdSFzXCqEvB4d4FrCaYMulrTL44c+RpnIjHGcjltwT5se1HqzpcOo=
X-Received: by 2002:a19:6d02:: with SMTP id i2mr21293876lfc.191.1567546878927;
 Tue, 03 Sep 2019 14:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190903204645.25487-1-lyude@redhat.com> <20190903204645.25487-12-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-12-lyude@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 4 Sep 2019 07:41:07 +1000
Message-ID: <CAPM=9tz0fdZpfFAfQ0aCQ4D+0XQGm=zqeFKDHPFNwVEUeM1f5g@mail.gmail.com>
Subject: Re: [PATCH v2 11/27] drm/dp_mst: Constify guid in drm_dp_get_mst_branch_by_guid()
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Juston Li <juston.li@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <hwentlan@amd.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 at 06:48, Lyude Paul <lyude@redhat.com> wrote:
>
> And it's helper, we'll be using this in just a moment.
>

Reviewed-by: Dave Airlie <airlied@redhat.com>

> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
> index 43452872efad..b44d3696c09a 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2060,7 +2060,7 @@ static struct drm_dp_mst_branch *drm_dp_get_mst_bra=
nch_device(struct drm_dp_mst_
>
>  static struct drm_dp_mst_branch *get_mst_branch_device_by_guid_helper(
>         struct drm_dp_mst_branch *mstb,
> -       uint8_t *guid)
> +       const uint8_t *guid)
>  {
>         struct drm_dp_mst_branch *found_mstb;
>         struct drm_dp_mst_port *port;
> @@ -2084,7 +2084,7 @@ static struct drm_dp_mst_branch *get_mst_branch_dev=
ice_by_guid_helper(
>
>  static struct drm_dp_mst_branch *
>  drm_dp_get_mst_branch_device_by_guid(struct drm_dp_mst_topology_mgr *mgr=
,
> -                                    uint8_t *guid)
> +                                    const uint8_t *guid)
>  {
>         struct drm_dp_mst_branch *mstb;
>         int ret;
> --
> 2.21.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
