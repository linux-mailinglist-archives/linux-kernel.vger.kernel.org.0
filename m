Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFBC5D6866
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 19:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbfJNRYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 13:24:53 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36438 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387724AbfJNRYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:24:53 -0400
Received: by mail-yb1-f194.google.com with SMTP id t4so2992696ybk.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9bItvDSfbUsGhJswtzc99Hv7SGEwqL2WVtPMge+nuj8=;
        b=ZdR7ZoWpTjUK/j/uIvcYxf8AsCcxUN5J75ACgNQc+j+DUc6RjjZSMYsGtv9DWU1tu+
         lMQ9QGm9fH8BnO1gvS5egsNQgkrYm16hoNSRbAxYmrK/k6aCUYBw0msI/NEVNAUQhI51
         nBsK7ZayQ4iZgYNy9foFBnwqOVPfMhAoKPnLGmSCz7qNtQLojlfZ8rNA3eXiE56WahVE
         qf+vNcHJ5BiiytaxK+cwUrdRvsbLr0zRQOWVEFpA0E9GEn6UxrMipdUfHzzfQYmKwF2U
         FmstD00eybdMC+4+nSNwloJ8OlNmWtonMauOhCToYkn2Ogct4DHlwPTCjpFHE676KaF8
         jgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9bItvDSfbUsGhJswtzc99Hv7SGEwqL2WVtPMge+nuj8=;
        b=PhBY6eV84YWuP1pXsepdxqzgSDIHs2r1fFRKFrMmLyYBs4Hjr9RogpZJ31cLku1i8V
         iptdAgitxiEwo+IaM9CRv3KwfF6y+t2KNGd53hmej1GvxGHTnSX52ALrD7M6NgPEEzEo
         fnbyR3rBp7FlG8kAoBOovdhvcH06evwnMyUOSEvdIewdxIyqTzIdcicPn6vcax+3SbLz
         fDbwbqoswddoLusABXFcbTm9GbN4Npo1J9VXWNMylsUqX+0QMLLIWdLEMNKMOM9CM6o2
         A6kP5Vf+jQgGhomo79hLj0pFb/Ft6aZkAFK3BzmEmlsRruYmsj116cC7ctN1wSkKlIIr
         +iiA==
X-Gm-Message-State: APjAAAW9Y717yHHJHYAqcQhvu2DwjTJBzGKOUu/mdVwBoDt4ymEACVPM
        SUZFS2dLkPpwc63yrDX//pBhUOJuDEZcJOdR2FKJQA==
X-Google-Smtp-Source: APXvYqzB4zzkOE4i6QIC5XrmCSDNAgopQj1flwi6e5XwJDEcgzOgZP4uJU4RwXKlJHcUAR/TstlAmokX+NlbIZ6pO9k=
X-Received: by 2002:a25:d610:: with SMTP id n16mr20533403ybg.486.1571073891004;
 Mon, 14 Oct 2019 10:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191014125302.21479-1-anders.roxell@linaro.org>
In-Reply-To: <20191014125302.21479-1-anders.roxell@linaro.org>
From:   Sean Paul <sean@poorly.run>
Date:   Mon, 14 Oct 2019 13:24:14 -0400
Message-ID: <CAMavQKKYzj_jbP2UTMe1O6K5GYxxM1buB=iWC8vFZU5e0vTGGA@mail.gmail.com>
Subject: Re: [PATCH] drm/dp-mst: remove unused variable
To:     Anders Roxell <anders.roxell@linaro.org>,
        Manasi Navare <manasi.d.navare@intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 8:53 AM Anders Roxell <anders.roxell@linaro.org> wr=
ote:
>
> The variable 'dev' is no longer used and the compiler rightly complains
> that it should be removed.
>
> ../drivers/gpu/drm/drm_dp_mst_topology.c: In function =E2=80=98drm_atomic=
_get_mst_topology_state=E2=80=99:
> ../drivers/gpu/drm/drm_dp_mst_topology.c:4187:21: warning: unused variabl=
e =E2=80=98dev=E2=80=99 [-Wunused-variable]
>   struct drm_device *dev =3D mgr->dev;
>                      ^~~
>
> Rework to remove the unused variable.
>
> Fixes: 83fa9842afe7 ("drm/dp-mst: Drop connection_mutex check")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Hi Anders,
Thank you for your patch! Manasi has already posted a patch for this:
https://patchwork.freedesktop.org/patch/335358/

It's reviewed, so we're just waiting for it to land.

Sean


> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
> index 9364e4f42975..9cccc5e63309 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -4184,8 +4184,6 @@ EXPORT_SYMBOL(drm_dp_mst_topology_state_funcs);
>  struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(stru=
ct drm_atomic_state *state,
>                                                                     struc=
t drm_dp_mst_topology_mgr *mgr)
>  {
> -       struct drm_device *dev =3D mgr->dev;
> -
>         return to_dp_mst_topology_state(drm_atomic_get_private_obj_state(=
state, &mgr->base));
>  }
>  EXPORT_SYMBOL(drm_atomic_get_mst_topology_state);
> --
> 2.20.1
>
