Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9377BCBB04
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 14:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbfJDM5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 08:57:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40410 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbfJDM5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:57:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id l3so7066683wru.7;
        Fri, 04 Oct 2019 05:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XS9aaZMpGytggDjroiubtOG48XIjudiIkkyqLu//BAo=;
        b=CfZutqK2eyhMj4QYH5dAeTwCvDuMu78hH8sOobkZWo8qm2svsb/q3QV1/JgEXFDxGI
         IfMzm9/TKepsFaqC+XIMnMc53GndMFWcvcRVpn9GIrAE2Vigoe9F3HgbfiiI0GmjToSr
         QYwHPu4pKKmB2Yy44qgzJ/vVp4fhAjRDPHcDCNqAiEpjErKrRnuWiGmOMMuYUC63Gcms
         Eo0vKKBjllg2yG3BisOSgS/iyJ4SL5O32xzSyMNOfRq+GCR60760jAHQHjLKIlqVfGkT
         xpax/gUZeX1CBKAxoKUvnTx18iR6xS6JeVhl3BzeYiqqO9KCiRKlmdztxNZ1uV2ucsFo
         pHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XS9aaZMpGytggDjroiubtOG48XIjudiIkkyqLu//BAo=;
        b=TNKag1jqVCCvRDnJ7O7H6/rY7IToTx+uhzJ6kKBZXb3Qgw7hZagQl/aNfxWiRK2Nx3
         j7UF4OWLW7by/m7uYPykW0eUhErR1l3OE2zW4rpBaRnwCc/iLKwR8L370RzR5jYblKf+
         YaWJLgIefthvpbyg1WjQwcih/pM+0Eto4O0lou851KQUptGAfqXRdMUEBT8NSXYZ8rUp
         Gt/XJfiTYvwFGBTmp+/Ai0fFTsubFOv8cJHPrw1TbcRwn4x+Iu4NxPppbe2b5ms0exDV
         Z1hAerQjV8rTPccs5HtdBZSi11ENEFRRFzw9V/hUjamEojSPYGtf1EbgB1TyaOiItJNQ
         k6hw==
X-Gm-Message-State: APjAAAWIvFGFj9voSLVWf0iYgcM89dBtSd3DxlCl8fQp6+4Yh17qgOm6
        zwe0MRttQwws0/K9KPz3Ibelfbv0MiuaeiI8ag4=
X-Google-Smtp-Source: APXvYqw7a5NYS3b3BeLyQBXREKlOHjBFTJXthurPJdQ7nhyePsMLRV3NcpO1oI+myJ7I+eZ/HhBO3tS0mQBjuPunC0g=
X-Received: by 2002:adf:d08b:: with SMTP id y11mr12064059wrh.50.1570193857802;
 Fri, 04 Oct 2019 05:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191003214049.23067-1-colin.king@canonical.com> <70c50fec-7ab7-3ac9-3f49-d5f2651554e4@amd.com>
In-Reply-To: <70c50fec-7ab7-3ac9-3f49-d5f2651554e4@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 4 Oct 2019 08:57:25 -0400
Message-ID: <CADnq5_N6WP=gDE=Yqv6CqKs13LkUJzFx9C6YmiU1ua_MSg_uiw@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: remove redundant variable r and
 redundant return statement
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 3:29 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 03.10.19 um 23:40 schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is a return statement that is not reachable and a variable that
> > is not used.  Remove them.
> >
> > Addresses-Coverity: ("Structurally dead code")
> > Fixes: de7b45babd9b ("drm/amdgpu: cleanup creating BOs at fixed locatio=
n (v2)")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Applied.  Thanks!

Alex

>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 481e4c381083..814159f15633 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1636,7 +1636,6 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struc=
t amdgpu_device *adev)
> >   static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev=
)
> >   {
> >       uint64_t vram_size =3D adev->gmc.visible_vram_size;
> > -     int r;
> >
> >       adev->fw_vram_usage.va =3D NULL;
> >       adev->fw_vram_usage.reserved_bo =3D NULL;
> > @@ -1651,7 +1650,6 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct=
 amdgpu_device *adev)
> >                                         AMDGPU_GEM_DOMAIN_VRAM,
> >                                         &adev->fw_vram_usage.reserved_b=
o,
> >                                         &adev->fw_vram_usage.va);
> > -     return r;
> >   }
> >
> >   /**
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
