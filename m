Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DCBB26CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 22:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389692AbfIMUp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 16:45:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46293 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388947AbfIMUp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 16:45:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so2092600wrv.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 13:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3hF7VxXOV7BHD6k5BOkPEiNxXK73RAvKPQzHlzE3Mgc=;
        b=EXhj79R6pThJzFcs2ROo8JNydmCzNjEoMwzSwZkq7uYc5v4AXba7ALoaOOq9wIV5Jw
         ZoYD8U7WbFLLspOQ5EsqNvj75N+wDciPm4LnfHn3JxOdX1DR7v2zhgDqDBgOmdQEhGGJ
         K4t+psGf9bZh+Jx6UVmnoq/wiDuSyAQIWOCSOgvV37CMwqZiaBps1VFN+kKzvBsV30Wk
         GSXg36MeIXO8Di4uhArKqQ4B5aGPWsPnl0NqPfJHqMlSmQc68IK0cgGeklJbYikTGoTr
         cTPg5DRfRyu4YvsEfbf2PcekhCXlXWNbg2msDmot9vdKi5T4mhkOxD9QlhQDOcgXbrSW
         6HUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3hF7VxXOV7BHD6k5BOkPEiNxXK73RAvKPQzHlzE3Mgc=;
        b=CA3AL+Gj/6wHVmaSr12T79KguaTWd0FPtj1FOYf/P/FgYMk5ajma7ijHeDwmv9Ljfi
         4LM0KHeiIoVgLo0AwQDCUCYTSq7CVTlLN9QXGiQfWc4C7o/Ea9ye+qKbAfCmrZkKNY0H
         o2T4TR5hQ4zxKXl8HoE0ng9kAI0uCCtjqR2/HFqawYhVPNJvyQ2oQgdqSa2Zlk/MAG/1
         laAZOj7kNYDXXD+yRoXKJ1axKWOyrcglA9DJUY0fX1y2mg+D9CuJh4c+8OjBt3YcWHde
         5kwn+7M6FYdiSl/2jayShKpDafzqpdssDYK3KcbVjLh5eQOz06PHsN4GFGkmw+bqW4b7
         NE/w==
X-Gm-Message-State: APjAAAVW5zePBNeiaU1hhOh7Xx5n2XWDvQiJCiZ3OK2wyPoJkkZa777s
        rgE8392w15IAv3X/0R4AJCvaqR0OJi50r+n0exg=
X-Google-Smtp-Source: APXvYqyS2oiUi4hWTtXC1OMgMkSQa4s4mIMBsJX0rlejW2rUxgFxmerXPlyXTDHcj79XGn2x6AAkIXgg+trBnoyGSw0=
X-Received: by 2002:adf:dfc5:: with SMTP id q5mr43072171wrn.142.1568407550926;
 Fri, 13 Sep 2019 13:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190903204645.25487-1-lyude@redhat.com> <20190903204645.25487-24-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-24-lyude@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Sep 2019 16:45:37 -0400
Message-ID: <CADnq5_NvhO751ihc64KmkxR_dOWNn5XJ4bJc95CMUEkGkw1Y2Q@mail.gmail.com>
Subject: Re: [PATCH v2 23/27] drm/amdgpu: Iterate through DRM connectors correctly
To:     Lyude Paul <lyude@redhat.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>, Tao Zhou <tao.zhou1@amd.com>,
        Huang Rui <ray.huang@amd.com>, Shirish S <shirish.s@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Yu Zhao <yuzhao@google.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        David Francis <David.Francis@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Juston Li <juston.li@intel.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Emily Deng <Emily.Deng@amd.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Evan Quan <evan.quan@amd.com>,
        Harry Wentland <hwentlan@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        xinhui pan <xinhui.pan@amd.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Rex Zhu <Rex.Zhu@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 4:49 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Currently, every single piece of code in amdgpu that loops through
> connectors does it incorrectly and doesn't use the proper list iteration
> helpers, drm_connector_list_iter_begin() and
> drm_connector_list_iter_end(). Yeesh.
>
> So, do that.

In fairness, I think the origin of this code predated the iterators.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 13 +++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 20 +++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c  | 40 +++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        | 34 ++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        | 34 ++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 40 ++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 34 ++++++++++++----
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 ++++++++-------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 10 ++++-
>  11 files changed, 195 insertions(+), 73 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_connectors.c
> index ece55c8fa673..bd31bb595c04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -1022,8 +1022,12 @@ amdgpu_connector_dvi_detect(struct drm_connector *=
connector, bool force)
>                          */
>                         if (amdgpu_connector->shared_ddc && (ret =3D=3D c=
onnector_status_connected)) {
>                                 struct drm_connector *list_connector;
> +                               struct drm_connector_list_iter iter;
>                                 struct amdgpu_connector *list_amdgpu_conn=
ector;
> -                               list_for_each_entry(list_connector, &dev-=
>mode_config.connector_list, head) {
> +
> +                               drm_connector_list_iter_begin(dev, &iter)=
;
> +                               drm_for_each_connector_iter(list_connecto=
r,
> +                                                           &iter) {
>                                         if (connector =3D=3D list_connect=
or)
>                                                 continue;
>                                         list_amdgpu_connector =3D to_amdg=
pu_connector(list_connector);
> @@ -1040,6 +1044,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *c=
onnector, bool force)
>                                                 }
>                                         }
>                                 }
> +                               drm_connector_list_iter_end(&iter);
>                         }
>                 }
>         }
> @@ -1501,6 +1506,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
>  {
>         struct drm_device *dev =3D adev->ddev;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector;
>         struct amdgpu_connector_atom_dig *amdgpu_dig_connector;
>         struct drm_encoder *encoder;
> @@ -1515,10 +1521,12 @@ amdgpu_connector_add(struct amdgpu_device *adev,
>                 return;
>
>         /* see if we already added it */
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 amdgpu_connector =3D to_amdgpu_connector(connector);
>                 if (amdgpu_connector->connector_id =3D=3D connector_id) {
>                         amdgpu_connector->devices |=3D supported_device;
> +                       drm_connector_list_iter_end(&iter);
>                         return;
>                 }
>                 if (amdgpu_connector->ddc_bus && i2c_bus->valid) {
> @@ -1533,6 +1541,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
>                         }
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>
>         /* check if it's a dp bridge */
>         list_for_each_entry(encoder, &dev->mode_config.encoder_list, head=
) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 2f884699eaef..acd39ce9b08e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3004,6 +3004,7 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool suspend, bool fbcon)
>         struct amdgpu_device *adev;
>         struct drm_crtc *crtc;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         int r;
>
>         if (dev =3D=3D NULL || dev->dev_private =3D=3D NULL) {
> @@ -3026,9 +3027,11 @@ int amdgpu_device_suspend(struct drm_device *dev, =
bool suspend, bool fbcon)
>         if (!amdgpu_device_has_dc_support(adev)) {
>                 /* turn off display hw */
>                 drm_modeset_lock_all(dev);
> -               list_for_each_entry(connector, &dev->mode_config.connecto=
r_list, head) {
> -                       drm_helper_connector_dpms(connector, DRM_MODE_DPM=
S_OFF);
> -               }
> +               drm_connector_list_iter_begin(dev, &iter);
> +               drm_for_each_connector_iter(connector, &iter)
> +                       drm_helper_connector_dpms(connector,
> +                                                 DRM_MODE_DPMS_OFF);
> +               drm_connector_list_iter_end(&iter);
>                 drm_modeset_unlock_all(dev);
>                         /* unpin the front buffers and cursors */
>                 list_for_each_entry(crtc, &dev->mode_config.crtc_list, he=
ad) {
> @@ -3107,6 +3110,7 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool suspend, bool fbcon)
>  int amdgpu_device_resume(struct drm_device *dev, bool resume, bool fbcon=
)
>  {
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_device *adev =3D dev->dev_private;
>         struct drm_crtc *crtc;
>         int r =3D 0;
> @@ -3177,9 +3181,13 @@ int amdgpu_device_resume(struct drm_device *dev, b=
ool resume, bool fbcon)
>
>                         /* turn on display hw */
>                         drm_modeset_lock_all(dev);
> -                       list_for_each_entry(connector, &dev->mode_config.=
connector_list, head) {
> -                               drm_helper_connector_dpms(connector, DRM_=
MODE_DPMS_ON);
> -                       }
> +
> +                       drm_connector_list_iter_begin(dev, &iter);
> +                       drm_for_each_connector_iter(connector, &iter)
> +                               drm_helper_connector_dpms(connector,
> +                                                         DRM_MODE_DPMS_O=
N);
> +                       drm_connector_list_iter_end(&iter);
> +
>                         drm_modeset_unlock_all(dev);
>                 }
>                 amdgpu_fbdev_set_suspend(adev, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> index 1d4aaa9580f4..d2dd59a95e8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -370,11 +370,13 @@ void amdgpu_display_print_display_setup(struct drm_=
device *dev)
>         struct amdgpu_connector *amdgpu_connector;
>         struct drm_encoder *encoder;
>         struct amdgpu_encoder *amdgpu_encoder;
> +       struct drm_connector_list_iter iter;
>         uint32_t devices;
>         int i =3D 0;
>
> +       drm_connector_list_iter_begin(dev, &iter);
>         DRM_INFO("AMDGPU Display Connectors\n");
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_for_each_connector_iter(connector, &iter) {
>                 amdgpu_connector =3D to_amdgpu_connector(connector);
>                 DRM_INFO("Connector %d:\n", i);
>                 DRM_INFO("  %s\n", connector->name);
> @@ -438,6 +440,7 @@ void amdgpu_display_print_display_setup(struct drm_de=
vice *dev)
>                 }
>                 i++;
>         }
> +       drm_connector_list_iter_end(&iter);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_encoders.c
> index 571a6dfb473e..61fcf247a638 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
> @@ -37,12 +37,14 @@ amdgpu_link_encoder_connector(struct drm_device *dev)
>  {
>         struct amdgpu_device *adev =3D dev->dev_private;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector;
>         struct drm_encoder *encoder;
>         struct amdgpu_encoder *amdgpu_encoder;
>
> +       drm_connector_list_iter_begin(dev, &iter);
>         /* walk the list and link encoders to connectors */
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_for_each_connector_iter(connector, &iter) {
>                 amdgpu_connector =3D to_amdgpu_connector(connector);
>                 list_for_each_entry(encoder, &dev->mode_config.encoder_li=
st, head) {
>                         amdgpu_encoder =3D to_amdgpu_encoder(encoder);
> @@ -55,6 +57,7 @@ amdgpu_link_encoder_connector(struct drm_device *dev)
>                         }
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>  }
>
>  void amdgpu_encoder_set_active_device(struct drm_encoder *encoder)
> @@ -62,8 +65,10 @@ void amdgpu_encoder_set_active_device(struct drm_encod=
er *encoder)
>         struct drm_device *dev =3D encoder->dev;
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 if (connector->encoder =3D=3D encoder) {
>                         struct amdgpu_connector *amdgpu_connector =3D to_=
amdgpu_connector(connector);
>                         amdgpu_encoder->active_device =3D amdgpu_encoder-=
>devices & amdgpu_connector->devices;
> @@ -72,6 +77,7 @@ void amdgpu_encoder_set_active_device(struct drm_encode=
r *encoder)
>                                   amdgpu_connector->devices, encoder->enc=
oder_type);
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>  }
>
>  struct drm_connector *
> @@ -79,15 +85,20 @@ amdgpu_get_connector_for_encoder(struct drm_encoder *=
encoder)
>  {
>         struct drm_device *dev =3D encoder->dev;
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
> -       struct drm_connector *connector;
> +       struct drm_connector *connector, *found =3D NULL;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector;
>
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 amdgpu_connector =3D to_amdgpu_connector(connector);
> -               if (amdgpu_encoder->active_device & amdgpu_connector->dev=
ices)
> -                       return connector;
> +               if (amdgpu_encoder->active_device & amdgpu_connector->dev=
ices) {
> +                       found =3D connector;
> +                       break;
> +               }
>         }
> -       return NULL;
> +       drm_connector_list_iter_end(&iter);
> +       return found;
>  }
>
>  struct drm_connector *
> @@ -95,15 +106,20 @@ amdgpu_get_connector_for_encoder_init(struct drm_enc=
oder *encoder)
>  {
>         struct drm_device *dev =3D encoder->dev;
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
> -       struct drm_connector *connector;
> +       struct drm_connector *connector, *found =3D NULL;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector;
>
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 amdgpu_connector =3D to_amdgpu_connector(connector);
> -               if (amdgpu_encoder->devices & amdgpu_connector->devices)
> -                       return connector;
> +               if (amdgpu_encoder->devices & amdgpu_connector->devices) =
{
> +                       found =3D connector;
> +                       break;
> +               }
>         }
> -       return NULL;
> +       drm_connector_list_iter_end(&iter);
> +       return found;
>  }
>
>  struct drm_encoder *amdgpu_get_external_encoder(struct drm_encoder *enco=
der)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.c
> index 2a3f5ec298db..977e121204e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -87,10 +87,13 @@ static void amdgpu_hotplug_work_func(struct work_stru=
ct *work)
>         struct drm_device *dev =3D adev->ddev;
>         struct drm_mode_config *mode_config =3D &dev->mode_config;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>
>         mutex_lock(&mode_config->mutex);
> -       list_for_each_entry(connector, &mode_config->connector_list, head=
)
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter)
>                 amdgpu_connector_hotplug(connector);
> +       drm_connector_list_iter_end(&iter);
>         mutex_unlock(&mode_config->mutex);
>         /* Just fire off a uevent and let userspace tell us what to do */
>         drm_helper_hpd_irq_event(dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v10_0.c
> index 645550e7caf5..be82871ac3bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -330,9 +330,11 @@ static void dce_v10_0_hpd_init(struct amdgpu_device =
*adev)
>  {
>         struct drm_device *dev =3D adev->ddev;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         u32 tmp;
>
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_c=
onnector(connector);
>
>                 if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hp=
d)
> @@ -368,6 +370,7 @@ static void dce_v10_0_hpd_init(struct amdgpu_device *=
adev)
>                 amdgpu_irq_get(adev, &adev->hpd_irq,
>                                amdgpu_connector->hpd.hpd);
>         }
> +       drm_connector_list_iter_end(&iter);
>  }
>
>  /**
> @@ -382,9 +385,11 @@ static void dce_v10_0_hpd_fini(struct amdgpu_device =
*adev)
>  {
>         struct drm_device *dev =3D adev->ddev;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         u32 tmp;
>
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_c=
onnector(connector);
>
>                 if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hp=
d)
> @@ -397,6 +402,7 @@ static void dce_v10_0_hpd_fini(struct amdgpu_device *=
adev)
>                 amdgpu_irq_put(adev, &adev->hpd_irq,
>                                amdgpu_connector->hpd.hpd);
>         }
> +       drm_connector_list_iter_end(&iter);
>  }
>
>  static u32 dce_v10_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
> @@ -1219,10 +1225,12 @@ static void dce_v10_0_afmt_audio_select_pin(struc=
t drm_encoder *encoder)
>  static void dce_v10_0_audio_write_latency_fields(struct drm_encoder *enc=
oder,
>                                                 struct drm_display_mode *=
mode)
>  {
> -       struct amdgpu_device *adev =3D encoder->dev->dev_private;
> +       struct drm_device *dev =3D encoder->dev;
> +       struct amdgpu_device *adev =3D dev->dev_private;
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
>         struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector =3D NULL;
>         u32 tmp;
>         int interlace =3D 0;
> @@ -1230,12 +1238,14 @@ static void dce_v10_0_audio_write_latency_fields(=
struct drm_encoder *encoder,
>         if (!dig || !dig->afmt || !dig->afmt->pin)
>                 return;
>
> -       list_for_each_entry(connector, &encoder->dev->mode_config.connect=
or_list, head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 if (connector->encoder =3D=3D encoder) {
>                         amdgpu_connector =3D to_amdgpu_connector(connecto=
r);
>                         break;
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>
>         if (!amdgpu_connector) {
>                 DRM_ERROR("Couldn't find encoder's connector\n");
> @@ -1261,10 +1271,12 @@ static void dce_v10_0_audio_write_latency_fields(=
struct drm_encoder *encoder,
>
>  static void dce_v10_0_audio_write_speaker_allocation(struct drm_encoder =
*encoder)
>  {
> -       struct amdgpu_device *adev =3D encoder->dev->dev_private;
> +       struct drm_device *dev =3D encoder->dev;
> +       struct amdgpu_device *adev =3D dev->dev_private;
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
>         struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector =3D NULL;
>         u32 tmp;
>         u8 *sadb =3D NULL;
> @@ -1273,12 +1285,14 @@ static void dce_v10_0_audio_write_speaker_allocat=
ion(struct drm_encoder *encoder
>         if (!dig || !dig->afmt || !dig->afmt->pin)
>                 return;
>
> -       list_for_each_entry(connector, &encoder->dev->mode_config.connect=
or_list, head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 if (connector->encoder =3D=3D encoder) {
>                         amdgpu_connector =3D to_amdgpu_connector(connecto=
r);
>                         break;
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>
>         if (!amdgpu_connector) {
>                 DRM_ERROR("Couldn't find encoder's connector\n");
> @@ -1313,10 +1327,12 @@ static void dce_v10_0_audio_write_speaker_allocat=
ion(struct drm_encoder *encoder
>
>  static void dce_v10_0_audio_write_sad_regs(struct drm_encoder *encoder)
>  {
> -       struct amdgpu_device *adev =3D encoder->dev->dev_private;
> +       struct drm_device *dev =3D encoder->dev;
> +       struct amdgpu_device *adev =3D dev->dev_private;
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
>         struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector =3D NULL;
>         struct cea_sad *sads;
>         int i, sad_count;
> @@ -1339,12 +1355,14 @@ static void dce_v10_0_audio_write_sad_regs(struct=
 drm_encoder *encoder)
>         if (!dig || !dig->afmt || !dig->afmt->pin)
>                 return;
>
> -       list_for_each_entry(connector, &encoder->dev->mode_config.connect=
or_list, head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 if (connector->encoder =3D=3D encoder) {
>                         amdgpu_connector =3D to_amdgpu_connector(connecto=
r);
>                         break;
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>
>         if (!amdgpu_connector) {
>                 DRM_ERROR("Couldn't find encoder's connector\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v11_0.c
> index d9f470632b2c..bde48775cf1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> @@ -348,9 +348,11 @@ static void dce_v11_0_hpd_init(struct amdgpu_device =
*adev)
>  {
>         struct drm_device *dev =3D adev->ddev;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         u32 tmp;
>
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_c=
onnector(connector);
>
>                 if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hp=
d)
> @@ -385,6 +387,7 @@ static void dce_v11_0_hpd_init(struct amdgpu_device *=
adev)
>                 dce_v11_0_hpd_set_polarity(adev, amdgpu_connector->hpd.hp=
d);
>                 amdgpu_irq_get(adev, &adev->hpd_irq, amdgpu_connector->hp=
d.hpd);
>         }
> +       drm_connector_list_iter_end(&iter);
>  }
>
>  /**
> @@ -399,9 +402,11 @@ static void dce_v11_0_hpd_fini(struct amdgpu_device =
*adev)
>  {
>         struct drm_device *dev =3D adev->ddev;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         u32 tmp;
>
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_c=
onnector(connector);
>
>                 if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hp=
d)
> @@ -413,6 +418,7 @@ static void dce_v11_0_hpd_fini(struct amdgpu_device *=
adev)
>
>                 amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hp=
d.hpd);
>         }
> +       drm_connector_list_iter_end(&iter);
>  }
>
>  static u32 dce_v11_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
> @@ -1245,10 +1251,12 @@ static void dce_v11_0_afmt_audio_select_pin(struc=
t drm_encoder *encoder)
>  static void dce_v11_0_audio_write_latency_fields(struct drm_encoder *enc=
oder,
>                                                 struct drm_display_mode *=
mode)
>  {
> -       struct amdgpu_device *adev =3D encoder->dev->dev_private;
> +       struct drm_device *dev =3D encoder->dev;
> +       struct amdgpu_device *adev =3D dev->dev_private;
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
>         struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector =3D NULL;
>         u32 tmp;
>         int interlace =3D 0;
> @@ -1256,12 +1264,14 @@ static void dce_v11_0_audio_write_latency_fields(=
struct drm_encoder *encoder,
>         if (!dig || !dig->afmt || !dig->afmt->pin)
>                 return;
>
> -       list_for_each_entry(connector, &encoder->dev->mode_config.connect=
or_list, head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 if (connector->encoder =3D=3D encoder) {
>                         amdgpu_connector =3D to_amdgpu_connector(connecto=
r);
>                         break;
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>
>         if (!amdgpu_connector) {
>                 DRM_ERROR("Couldn't find encoder's connector\n");
> @@ -1287,10 +1297,12 @@ static void dce_v11_0_audio_write_latency_fields(=
struct drm_encoder *encoder,
>
>  static void dce_v11_0_audio_write_speaker_allocation(struct drm_encoder =
*encoder)
>  {
> -       struct amdgpu_device *adev =3D encoder->dev->dev_private;
> +       struct drm_device *dev =3D encoder->dev;
> +       struct amdgpu_device *adev =3D dev->dev_private;
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
>         struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector =3D NULL;
>         u32 tmp;
>         u8 *sadb =3D NULL;
> @@ -1299,12 +1311,14 @@ static void dce_v11_0_audio_write_speaker_allocat=
ion(struct drm_encoder *encoder
>         if (!dig || !dig->afmt || !dig->afmt->pin)
>                 return;
>
> -       list_for_each_entry(connector, &encoder->dev->mode_config.connect=
or_list, head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 if (connector->encoder =3D=3D encoder) {
>                         amdgpu_connector =3D to_amdgpu_connector(connecto=
r);
>                         break;
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>
>         if (!amdgpu_connector) {
>                 DRM_ERROR("Couldn't find encoder's connector\n");
> @@ -1339,10 +1353,12 @@ static void dce_v11_0_audio_write_speaker_allocat=
ion(struct drm_encoder *encoder
>
>  static void dce_v11_0_audio_write_sad_regs(struct drm_encoder *encoder)
>  {
> -       struct amdgpu_device *adev =3D encoder->dev->dev_private;
> +       struct drm_device *dev =3D encoder->dev;
> +       struct amdgpu_device *adev =3D dev->dev_private;
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
>         struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector =3D NULL;
>         struct cea_sad *sads;
>         int i, sad_count;
> @@ -1365,12 +1381,14 @@ static void dce_v11_0_audio_write_sad_regs(struct=
 drm_encoder *encoder)
>         if (!dig || !dig->afmt || !dig->afmt->pin)
>                 return;
>
> -       list_for_each_entry(connector, &encoder->dev->mode_config.connect=
or_list, head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 if (connector->encoder =3D=3D encoder) {
>                         amdgpu_connector =3D to_amdgpu_connector(connecto=
r);
>                         break;
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>
>         if (!amdgpu_connector) {
>                 DRM_ERROR("Couldn't find encoder's connector\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 3eb2e7429269..65f61de931d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -281,9 +281,11 @@ static void dce_v6_0_hpd_init(struct amdgpu_device *=
adev)
>  {
>         struct drm_device *dev =3D adev->ddev;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         u32 tmp;
>
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_c=
onnector(connector);
>
>                 if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hp=
d)
> @@ -309,7 +311,7 @@ static void dce_v6_0_hpd_init(struct amdgpu_device *a=
dev)
>                 dce_v6_0_hpd_set_polarity(adev, amdgpu_connector->hpd.hpd=
);
>                 amdgpu_irq_get(adev, &adev->hpd_irq, amdgpu_connector->hp=
d.hpd);
>         }
> -
> +       drm_connector_list_iter_end(&iter);
>  }
>
>  /**
> @@ -324,9 +326,11 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *=
adev)
>  {
>         struct drm_device *dev =3D adev->ddev;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         u32 tmp;
>
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_c=
onnector(connector);
>
>                 if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hp=
d)
> @@ -338,6 +342,7 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *a=
dev)
>
>                 amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hp=
d.hpd);
>         }
> +       drm_connector_list_iter_end(&iter);
>  }
>
>  static u32 dce_v6_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
> @@ -1124,20 +1129,24 @@ static void dce_v6_0_audio_select_pin(struct drm_=
encoder *encoder)
>  static void dce_v6_0_audio_write_latency_fields(struct drm_encoder *enco=
der,
>                                                 struct drm_display_mode *=
mode)
>  {
> -       struct amdgpu_device *adev =3D encoder->dev->dev_private;
> +       struct drm_device *dev =3D encoder->dev;
> +       struct amdgpu_device *adev =3D dev->dev_private;
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
>         struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector =3D NULL;
>         int interlace =3D 0;
>         u32 tmp;
>
> -       list_for_each_entry(connector, &encoder->dev->mode_config.connect=
or_list, head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 if (connector->encoder =3D=3D encoder) {
>                         amdgpu_connector =3D to_amdgpu_connector(connecto=
r);
>                         break;
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>
>         if (!amdgpu_connector) {
>                 DRM_ERROR("Couldn't find encoder's connector\n");
> @@ -1164,21 +1173,25 @@ static void dce_v6_0_audio_write_latency_fields(s=
truct drm_encoder *encoder,
>
>  static void dce_v6_0_audio_write_speaker_allocation(struct drm_encoder *=
encoder)
>  {
> -       struct amdgpu_device *adev =3D encoder->dev->dev_private;
> +       struct drm_device *dev =3D encoder->dev;
> +       struct amdgpu_device *adev =3D dev->dev_private;
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
>         struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector =3D NULL;
>         u8 *sadb =3D NULL;
>         int sad_count;
>         u32 tmp;
>
> -       list_for_each_entry(connector, &encoder->dev->mode_config.connect=
or_list, head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 if (connector->encoder =3D=3D encoder) {
>                         amdgpu_connector =3D to_amdgpu_connector(connecto=
r);
>                         break;
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>
>         if (!amdgpu_connector) {
>                 DRM_ERROR("Couldn't find encoder's connector\n");
> @@ -1221,10 +1234,12 @@ static void dce_v6_0_audio_write_speaker_allocati=
on(struct drm_encoder *encoder)
>
>  static void dce_v6_0_audio_write_sad_regs(struct drm_encoder *encoder)
>  {
> -       struct amdgpu_device *adev =3D encoder->dev->dev_private;
> +       struct drm_device *dev =3D encoder->dev;
> +       struct amdgpu_device *adev =3D dev->dev_private;
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
>         struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector =3D NULL;
>         struct cea_sad *sads;
>         int i, sad_count;
> @@ -1244,12 +1259,14 @@ static void dce_v6_0_audio_write_sad_regs(struct =
drm_encoder *encoder)
>                 { ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR13, HDMI_=
AUDIO_CODING_TYPE_WMA_PRO },
>         };
>
> -       list_for_each_entry(connector, &encoder->dev->mode_config.connect=
or_list, head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 if (connector->encoder =3D=3D encoder) {
>                         amdgpu_connector =3D to_amdgpu_connector(connecto=
r);
>                         break;
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>
>         if (!amdgpu_connector) {
>                 DRM_ERROR("Couldn't find encoder's connector\n");
> @@ -1632,6 +1649,7 @@ static void dce_v6_0_afmt_setmode(struct drm_encode=
r *encoder,
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
>         struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector =3D NULL;
>         int em =3D amdgpu_atombios_encoder_get_encoder_mode(encoder);
>         int bpc =3D 8;
> @@ -1639,12 +1657,14 @@ static void dce_v6_0_afmt_setmode(struct drm_enco=
der *encoder,
>         if (!dig || !dig->afmt)
>                 return;
>
> -       list_for_each_entry(connector, &encoder->dev->mode_config.connect=
or_list, head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 if (connector->encoder =3D=3D encoder) {
>                         amdgpu_connector =3D to_amdgpu_connector(connecto=
r);
>                         break;
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>
>         if (!amdgpu_connector) {
>                 DRM_ERROR("Couldn't find encoder's connector\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v8_0.c
> index a16c5e9e610e..e5f50882a51d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -275,9 +275,11 @@ static void dce_v8_0_hpd_init(struct amdgpu_device *=
adev)
>  {
>         struct drm_device *dev =3D adev->ddev;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         u32 tmp;
>
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_c=
onnector(connector);
>
>                 if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hp=
d)
> @@ -303,6 +305,7 @@ static void dce_v8_0_hpd_init(struct amdgpu_device *a=
dev)
>                 dce_v8_0_hpd_set_polarity(adev, amdgpu_connector->hpd.hpd=
);
>                 amdgpu_irq_get(adev, &adev->hpd_irq, amdgpu_connector->hp=
d.hpd);
>         }
> +       drm_connector_list_iter_end(&iter);
>  }
>
>  /**
> @@ -317,9 +320,11 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *=
adev)
>  {
>         struct drm_device *dev =3D adev->ddev;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         u32 tmp;
>
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_c=
onnector(connector);
>
>                 if (amdgpu_connector->hpd.hpd >=3D adev->mode_info.num_hp=
d)
> @@ -331,6 +336,7 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *a=
dev)
>
>                 amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hp=
d.hpd);
>         }
> +       drm_connector_list_iter_end(&iter);
>  }
>
>  static u32 dce_v8_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
> @@ -1157,10 +1163,12 @@ static void dce_v8_0_afmt_audio_select_pin(struct=
 drm_encoder *encoder)
>  static void dce_v8_0_audio_write_latency_fields(struct drm_encoder *enco=
der,
>                                                 struct drm_display_mode *=
mode)
>  {
> -       struct amdgpu_device *adev =3D encoder->dev->dev_private;
> +       struct drm_device *dev =3D encoder->dev;
> +       struct amdgpu_device *adev =3D dev->dev_private;
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
>         struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector =3D NULL;
>         u32 tmp =3D 0, offset;
>
> @@ -1169,12 +1177,14 @@ static void dce_v8_0_audio_write_latency_fields(s=
truct drm_encoder *encoder,
>
>         offset =3D dig->afmt->pin->offset;
>
> -       list_for_each_entry(connector, &encoder->dev->mode_config.connect=
or_list, head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 if (connector->encoder =3D=3D encoder) {
>                         amdgpu_connector =3D to_amdgpu_connector(connecto=
r);
>                         break;
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>
>         if (!amdgpu_connector) {
>                 DRM_ERROR("Couldn't find encoder's connector\n");
> @@ -1214,10 +1224,12 @@ static void dce_v8_0_audio_write_latency_fields(s=
truct drm_encoder *encoder,
>
>  static void dce_v8_0_audio_write_speaker_allocation(struct drm_encoder *=
encoder)
>  {
> -       struct amdgpu_device *adev =3D encoder->dev->dev_private;
> +       struct drm_device *dev =3D encoder->dev;
> +       struct amdgpu_device *adev =3D dev->dev_private;
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
>         struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector =3D NULL;
>         u32 offset, tmp;
>         u8 *sadb =3D NULL;
> @@ -1228,12 +1240,14 @@ static void dce_v8_0_audio_write_speaker_allocati=
on(struct drm_encoder *encoder)
>
>         offset =3D dig->afmt->pin->offset;
>
> -       list_for_each_entry(connector, &encoder->dev->mode_config.connect=
or_list, head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 if (connector->encoder =3D=3D encoder) {
>                         amdgpu_connector =3D to_amdgpu_connector(connecto=
r);
>                         break;
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>
>         if (!amdgpu_connector) {
>                 DRM_ERROR("Couldn't find encoder's connector\n");
> @@ -1263,11 +1277,13 @@ static void dce_v8_0_audio_write_speaker_allocati=
on(struct drm_encoder *encoder)
>
>  static void dce_v8_0_audio_write_sad_regs(struct drm_encoder *encoder)
>  {
> -       struct amdgpu_device *adev =3D encoder->dev->dev_private;
> +       struct drm_device *dev =3D encoder->dev;
> +       struct amdgpu_device *adev =3D dev->dev_private;
>         struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encod=
er);
>         struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
>         u32 offset;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct amdgpu_connector *amdgpu_connector =3D NULL;
>         struct cea_sad *sads;
>         int i, sad_count;
> @@ -1292,12 +1308,14 @@ static void dce_v8_0_audio_write_sad_regs(struct =
drm_encoder *encoder)
>
>         offset =3D dig->afmt->pin->offset;
>
> -       list_for_each_entry(connector, &encoder->dev->mode_config.connect=
or_list, head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 if (connector->encoder =3D=3D encoder) {
>                         amdgpu_connector =3D to_amdgpu_connector(connecto=
r);
>                         break;
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>
>         if (!amdgpu_connector) {
>                 DRM_ERROR("Couldn't find encoder's connector\n");
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0a71ed1e7762..73630e2940d4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -896,27 +896,29 @@ static int detect_mst_link_for_all_connectors(struc=
t drm_device *dev)
>  {
>         struct amdgpu_dm_connector *aconnector;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         int ret =3D 0;
>
> -       drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> -
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 aconnector =3D to_amdgpu_dm_connector(connector);
>                 if (aconnector->dc_link->type =3D=3D dc_connection_mst_br=
anch &&
>                     aconnector->mst_mgr.aux) {
>                         DRM_DEBUG_DRIVER("DM_MST: starting TM on aconnect=
or: %p [id: %d]\n",
> -                                       aconnector, aconnector->base.base=
.id);
> +                                        aconnector,
> +                                        aconnector->base.base.id);
>
>                         ret =3D drm_dp_mst_topology_mgr_set_mst(&aconnect=
or->mst_mgr, true);
>                         if (ret < 0) {
>                                 DRM_ERROR("DM_MST: Failed to start MST\n"=
);
> -                               ((struct dc_link *)aconnector->dc_link)->=
type =3D dc_connection_single;
> -                               return ret;
> -                               }
> +                               aconnector->dc_link->type =3D
> +                                       dc_connection_single;
> +                               break;
>                         }
> +               }
>         }
> +       drm_connector_list_iter_end(&iter);
>
> -       drm_modeset_unlock(&dev->mode_config.connection_mutex);
>         return ret;
>  }
>
> @@ -954,14 +956,13 @@ static void s3_handle_mst(struct drm_device *dev, b=
ool suspend)
>  {
>         struct amdgpu_dm_connector *aconnector;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct drm_dp_mst_topology_mgr *mgr;
>         int ret;
>         bool need_hotplug =3D false;
>
> -       drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> -
> -       list_for_each_entry(connector, &dev->mode_config.connector_list,
> -                           head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 aconnector =3D to_amdgpu_dm_connector(connector);
>                 if (aconnector->dc_link->type !=3D dc_connection_mst_bran=
ch ||
>                     aconnector->mst_port)
> @@ -979,8 +980,7 @@ static void s3_handle_mst(struct drm_device *dev, boo=
l suspend)
>                         }
>                 }
>         }
> -
> -       drm_modeset_unlock(&dev->mode_config.connection_mutex);
> +       drm_connector_list_iter_end(&iter);
>
>         if (need_hotplug)
>                 drm_kms_helper_hotplug_event(dev);
> @@ -1162,6 +1162,7 @@ static int dm_resume(void *handle)
>         struct amdgpu_display_manager *dm =3D &adev->dm;
>         struct amdgpu_dm_connector *aconnector;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>         struct drm_crtc *crtc;
>         struct drm_crtc_state *new_crtc_state;
>         struct dm_crtc_state *dm_new_crtc_state;
> @@ -1194,7 +1195,8 @@ static int dm_resume(void *handle)
>         amdgpu_dm_irq_resume_early(adev);
>
>         /* Do detection*/
> -       list_for_each_entry(connector, &ddev->mode_config.connector_list,=
 head) {
> +       drm_connector_list_iter_begin(ddev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 aconnector =3D to_amdgpu_dm_connector(connector);
>
>                 /*
> @@ -1222,6 +1224,7 @@ static int dm_resume(void *handle)
>                 amdgpu_dm_update_connector_after_detect(aconnector);
>                 mutex_unlock(&aconnector->hpd_lock);
>         }
> +       drm_connector_list_iter_end(&iter);
>
>         /* Force mode set in atomic commit */
>         for_each_new_crtc_in_state(dm->cached_state, crtc, new_crtc_state=
, i)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index fa5d503d379c..64445c4cc4c2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -732,8 +732,10 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
>  {
>         struct drm_device *dev =3D adev->ddev;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 struct amdgpu_dm_connector *amdgpu_dm_connector =3D
>                                 to_amdgpu_dm_connector(connector);
>
> @@ -751,6 +753,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
>                                         true);
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>  }
>
>  /**
> @@ -765,8 +768,10 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
>  {
>         struct drm_device *dev =3D adev->ddev;
>         struct drm_connector *connector;
> +       struct drm_connector_list_iter iter;
>
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, =
head) {
> +       drm_connector_list_iter_begin(dev, &iter);
> +       drm_for_each_connector_iter(connector, &iter) {
>                 struct amdgpu_dm_connector *amdgpu_dm_connector =3D
>                                 to_amdgpu_dm_connector(connector);
>                 const struct dc_link *dc_link =3D amdgpu_dm_connector->dc=
_link;
> @@ -779,4 +784,5 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
>                                         false);
>                 }
>         }
> +       drm_connector_list_iter_end(&iter);
>  }
> --
> 2.21.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
