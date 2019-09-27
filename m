Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9453DC0AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 20:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfI0SUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 14:20:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33103 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfI0SUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:20:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so9210356wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0EYL4Y9+sNFSeoW58R9jcyu1CvfiVJtQtALYLXx6xD4=;
        b=YqBwG3/KisZl5EOeyV2VYWz4E6VKggj/6AvQoO+DEECgzYKcEuYjT5N8PCP880hR4I
         6LZLNJDkD/1QkAbNOTL7l/GrWPwwJ0OED+9mEB14XuZ6Q9lA25UkFmreWBZg3P5gRLtQ
         pKVRrEka+bgclmEFFpRKUOCKADx6jekTQny/eKaWR4D7aQaobptyOjDP/Ugu1ZcSVHJ7
         M9pz97LiNpUCKrO8NgB2dlXeBBUnxoI3eGRifpygHpo1WOAcpoJJ3laliPjCqBTeRjwl
         GD3+R0MLbQSoDw1gQ2hMwdc3QUEkb/leXy/zFyizNjNrCtgNbesYRdk7xsZs5Sf42DXa
         lGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0EYL4Y9+sNFSeoW58R9jcyu1CvfiVJtQtALYLXx6xD4=;
        b=TTIiFtnzRLU6RY//P8VrjdFuGS8EQWIY1SKj4t2RoG0s10JQwygR6vHmQVH05t0gw7
         D5d+HEMyiZ//1szLv/CXw4vllmuqQvp7MNhSvJFz41tePd7iUwRoHAoZf2iO11E+GY3W
         lNCR9PZW5l1b4QaZfGO2S/hE9b8MCxe6gCl8Vrd6j0734RC4DUp7QP5kfvGWeqDVNp58
         vqd4Tye3FeRaH+G/rRvh/R+X0eDUhx25IxFeH1CdGQvXi0vCXZePJIoJqPNcq/sXJ1UF
         rVnr7IBhUznIbnY6ONIpI1phrVGmEuwS7gH3eBsfpGdMYB8ZHTkjshp91HNzTTRh6thi
         BzLw==
X-Gm-Message-State: APjAAAVavIpYTfQecOqUh04AfKytM09FqgTPSjF66t31Et70w/Kdv234
        g9ouB1ihU5Qgx/iwuxVX+Zsa9keM73I6mWxvA5I=
X-Google-Smtp-Source: APXvYqxbNsv8ooPy9g7nhDYI58MT/VTNMF5K0CZSZLdVNgCipNlhoOWNNoD3LF6M0DHB7twOwasADlSpWWUdLQYtn9g=
X-Received: by 2002:a1c:1a45:: with SMTP id a66mr8120883wma.102.1569608452234;
 Fri, 27 Sep 2019 11:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190926225122.31455-1-lyude@redhat.com> <20190926225122.31455-4-lyude@redhat.com>
 <6129c0a5-9a8a-8a05-4dd9-db3204dcbfd8@amd.com>
In-Reply-To: <6129c0a5-9a8a-8a05-4dd9-db3204dcbfd8@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 27 Sep 2019 14:20:39 -0400
Message-ID: <CADnq5_PH=Znbo1NajL=OJFbOyEYFXX7xrQM-8hh7YXUhXpicrQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/amdgpu/dm/mst: Use ->atomic_best_encoder
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Thomas Lim <Thomas.Lim@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Francis, David" <David.Francis@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "Zuo, Jerry" <Jerry.Zuo@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 1:56 PM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-09-26 6:51 p.m., Lyude Paul wrote:
> > We are supposed to be atomic after all. We'll need this in a moment for
> > the next commit.
> >
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Applied.  Thanks!

Alex

> Harry
>
> > ---
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > index a398ddd1f306..d9113ce0be09 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > @@ -243,17 +243,17 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
> >       return ret;
> >  }
> >
> > -static struct drm_encoder *dm_mst_best_encoder(struct drm_connector *connector)
> > +static struct drm_encoder *
> > +dm_mst_atomic_best_encoder(struct drm_connector *connector,
> > +                        struct drm_connector_state *connector_state)
> >  {
> > -     struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
> > -
> > -     return &amdgpu_dm_connector->mst_encoder->base;
> > +     return &to_amdgpu_dm_connector(connector)->mst_encoder->base;
> >  }
> >
> >  static const struct drm_connector_helper_funcs dm_dp_mst_connector_helper_funcs = {
> >       .get_modes = dm_dp_mst_get_modes,
> >       .mode_valid = amdgpu_dm_connector_mode_valid,
> > -     .best_encoder = dm_mst_best_encoder,
> > +     .atomic_best_encoder = dm_mst_atomic_best_encoder,
> >  };
> >
> >  static void amdgpu_dm_encoder_destroy(struct drm_encoder *encoder)
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
