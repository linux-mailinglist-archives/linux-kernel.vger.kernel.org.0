Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 291EE38E2C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfFGO6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 10:58:18 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41268 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbfFGO6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:58:17 -0400
Received: by mail-ua1-f67.google.com with SMTP id n2so723241uad.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g0/NDZFiGf/pjW+kaXK+9xUZTcRrUusj7FU4CtVRPKA=;
        b=LZ0d2pEhggOCaC5mVqrwKspR9FbDkcOwzt9sj8gttE0Vdg73gn8QtJjhJ1IgoHKgpo
         GKftmkBwtFSXl+E+WiaaJpb33Igh1x4VNvH761FPe/6+WquvjhqUb+r5pbbt9/T3SDuV
         2yZJRClXpcezkgwXi0EVz0dyiJDjbilAsgv0vW7fowVkTkObaqq/8+NAEX4GbfisO2iV
         UmsMfeRlrnRayeT1QWL7lMmG76D18jIJ9NwqjxiJN5P/bA6rT5926Mg0qpea8JjkvQQX
         8hfAkE1VT1J3akyuPWTqZVLk9i96HCkCYLJlJVd1FRwDi7PskU4oI3gAesBLhP3DgrhI
         V65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g0/NDZFiGf/pjW+kaXK+9xUZTcRrUusj7FU4CtVRPKA=;
        b=TrMwW2NGC0qRCNos9ev2kU4ffbQTUjLQduzkSiv4eucfL9stUx/RxRAH2XKySuZial
         vmxmydLExo+HFvHEsKaEow3rvtbXVqMjpohqjaICdp0GtQqS4StF9Zplm6igQ3INTP6j
         uy2TsCqzFGtRaGSWqnxqoCBpX+SunOwAQ68WcwldPOtfAzJu2WvheqwAebiv/PzZTEuq
         QqJfTOEyLQV2aL/zg5Kau/OxzokR9O/cVD0yC0lex82o7BdGKPv27zPV9k+UP3udhf5y
         +bF3sbWMp1/1WUiE6Ruc9WYqIWUpZvpgaWgUQx2ZrtARDJGCNjc1eS8Nl/a5a4WaWDQd
         LlEw==
X-Gm-Message-State: APjAAAX6v9qZcOGxzw6ULv9HlM1sUC9TzgXHhOjj41KPnZmR7bd+faUv
        MqEP1aVMqFxJWQmMfkz8KDm7ybZ1ilaqDUGKkw1G07jLzTM=
X-Google-Smtp-Source: APXvYqx+HfvmZjt4zQByA93ZTZg7T3bKIVNdcdFJqDFB5y9bf0KV2TFrDwCl4+C/Xwl7DDZRS2/xno8KXHdIQcHvTfc=
X-Received: by 2002:ab0:2850:: with SMTP id c16mr12707157uaq.128.1559919495680;
 Fri, 07 Jun 2019 07:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559860606.git.rodrigosiqueiramelo@gmail.com>
 <0acd74232d988970668298be0111c485bc68ec87.1559860606.git.rodrigosiqueiramelo@gmail.com>
 <20190607074808.GC21222@phenom.ffwll.local>
In-Reply-To: <20190607074808.GC21222@phenom.ffwll.local>
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Date:   Fri, 7 Jun 2019 11:58:04 -0300
Message-ID: <CADKXj+6uBWtk2X5eSz=ce4Rb7USnkEPtUkBBefORHJGuemptwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/vkms: Add support for writeback
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 4:48 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Thu, Jun 06, 2019 at 07:41:01PM -0300, Rodrigo Siqueira wrote:
> > This patch implements the necessary functions to add writeback support
> > for vkms. This feature is useful for testing compositors if you don=E2=
=80=99t
> > have hardware with writeback support.
> >
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > ---
> >  drivers/gpu/drm/vkms/Makefile         |   9 +-
> >  drivers/gpu/drm/vkms/vkms_crtc.c      |   5 +
> >  drivers/gpu/drm/vkms/vkms_drv.c       |  10 ++
> >  drivers/gpu/drm/vkms/vkms_drv.h       |  12 ++
> >  drivers/gpu/drm/vkms/vkms_output.c    |   6 +
> >  drivers/gpu/drm/vkms/vkms_writeback.c | 165 ++++++++++++++++++++++++++
> >  6 files changed, 206 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/gpu/drm/vkms/vkms_writeback.c
> >
> > diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makef=
ile
> > index 89f09bec7b23..90eb7acd618d 100644
> > --- a/drivers/gpu/drm/vkms/Makefile
> > +++ b/drivers/gpu/drm/vkms/Makefile
> > @@ -1,4 +1,11 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -vkms-y :=3D vkms_drv.o vkms_plane.o vkms_output.o vkms_crtc.o vkms_gem=
.o vkms_crc.o
> > +vkms-y :=3D \
> > +     vkms_drv.o \
> > +     vkms_plane.o \
> > +     vkms_output.o \
> > +     vkms_crtc.o \
> > +     vkms_gem.o \
> > +     vkms_crc.o \
> > +     vkms_writeback.o
> >
> >  obj-$(CONFIG_DRM_VKMS) +=3D vkms.o
> > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vk=
ms_crtc.c
> > index 1bbe099b7db8..ce797e265b1b 100644
> > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > @@ -23,6 +23,11 @@ static enum hrtimer_restart vkms_vblank_simulate(str=
uct hrtimer *timer)
> >       if (!ret)
> >               DRM_ERROR("vkms failure on handling vblank");
> >
> > +     if (output->writeback_status =3D=3D WB_START) {
> > +             drm_writeback_signal_completion(&output->wb_connector, 0)=
;
> > +             output->writeback_status =3D WB_STOP;
> > +     }
> > +
> >       if (state && output->crc_enabled) {
> >               u64 frame =3D drm_crtc_accurate_vblank_count(crtc);
> >
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkm=
s_drv.c
> > index 92296bd8f623..d5917d5a45e3 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > @@ -29,6 +29,10 @@ bool enable_cursor;
> >  module_param_named(enable_cursor, enable_cursor, bool, 0444);
> >  MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
> >
> > +int enable_writeback;
> > +module_param_named(enable_writeback, enable_writeback, int, 0444);
> > +MODULE_PARM_DESC(enable_writeback, "Enable/Disable writeback connector=
");
> > +
> >  static const struct file_operations vkms_driver_fops =3D {
> >       .owner          =3D THIS_MODULE,
> >       .open           =3D drm_open,
> > @@ -123,6 +127,12 @@ static int __init vkms_init(void)
> >               goto out_fini;
> >       }
> >
> > +     vkms_device->output.writeback_status =3D WB_DISABLED;
> > +     if (enable_writeback) {
> > +             vkms_device->output.writeback_status =3D WB_STOP;
> > +             DRM_INFO("Writeback connector enabled");
> > +     }
> > +
> >       ret =3D vkms_modeset_init(vkms_device);
> >       if (ret)
> >               goto out_fini;
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkm=
s_drv.h
> > index e81073dea154..ca1f9ee63ec8 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -7,6 +7,7 @@
> >  #include <drm/drm.h>
> >  #include <drm/drm_gem.h>
> >  #include <drm/drm_encoder.h>
> > +#include <drm/drm_writeback.h>
> >  #include <linux/hrtimer.h>
> >
> >  #define XRES_MIN    20
> > @@ -60,14 +61,22 @@ struct vkms_crtc_state {
> >       u64 frame_end;
> >  };
> >
> > +enum wb_status {
> > +     WB_DISABLED,
> > +     WB_START,
> > +     WB_STOP,
> > +};
> > +
> >  struct vkms_output {
> >       struct drm_crtc crtc;
> >       struct drm_encoder encoder;
> >       struct drm_connector connector;
> > +     struct drm_writeback_connector wb_connector;
> >       struct hrtimer vblank_hrtimer;
> >       ktime_t period_ns;
> >       struct drm_pending_vblank_event *event;
> >       bool crc_enabled;
> > +     enum wb_status writeback_status;
> >       /* ordered wq for crc_work */
> >       struct workqueue_struct *crc_workq;
> >       /* protects concurrent access to crc_data */
> > @@ -141,4 +150,7 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, c=
onst char *source_name,
> >                          size_t *values_cnt);
> >  void vkms_crc_work_handle(struct work_struct *work);
> >
> > +/* Writeback */
> > +int enable_writeback_connector(struct vkms_device *vkmsdev);
> > +
> >  #endif /* _VKMS_DRV_H_ */
> > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/=
vkms_output.c
> > index 1442b447c707..1fc1d4e9585c 100644
> > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > @@ -91,6 +91,12 @@ int vkms_output_init(struct vkms_device *vkmsdev, in=
t index)
> >               goto err_attach;
> >       }
> >
> > +     if (vkmsdev->output.writeback_status !=3D WB_DISABLED) {
> > +             ret =3D enable_writeback_connector(vkmsdev);
> > +             if (ret)
> > +                     DRM_ERROR("Failed to init writeback connector\n")=
;
> > +     }
> > +
> >       drm_mode_config_reset(dev);
> >
> >       return 0;
> > diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vk=
ms/vkms_writeback.c
> > new file mode 100644
> > index 000000000000..f7b962ae5646
> > --- /dev/null
> > +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> > @@ -0,0 +1,165 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include "vkms_drv.h"
> > +#include <drm/drm_writeback.h>
> > +#include <drm/drm_probe_helper.h>
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_gem_framebuffer_helper.h>
> > +
> > +static const struct drm_connector_funcs vkms_wb_connector_funcs =3D {
> > +     .fill_modes =3D drm_helper_probe_single_connector_modes,
> > +     .destroy =3D drm_connector_cleanup,
> > +     .reset =3D drm_atomic_helper_connector_reset,
> > +     .atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate=
_state,
> > +     .atomic_destroy_state =3D drm_atomic_helper_connector_destroy_sta=
te,
> > +};
> > +
> > +static int vkms_wb_encoder_atomic_check(struct drm_encoder *encoder,
> > +                                     struct drm_crtc_state *crtc_state=
,
> > +                                     struct drm_connector_state *conn_=
state)
> > +{
> > +     struct drm_framebuffer *fb;
> > +     const struct drm_display_mode *mode =3D &crtc_state->mode;
> > +
> > +     if (!conn_state->writeback_job || !conn_state->writeback_job->fb)
> > +             return 0;
> > +
> > +     fb =3D conn_state->writeback_job->fb;
> > +     if (fb->width !=3D mode->hdisplay || fb->height !=3D mode->vdispl=
ay) {
> > +             DRM_DEBUG_KMS("Invalid framebuffer size %ux%u\n",
> > +                           fb->width, fb->height);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (fb->format->format !=3D DRM_FORMAT_XRGB8888) {
> > +             struct drm_format_name_buf format_name;
> > +
> > +             DRM_DEBUG_KMS("Invalid pixel format %s\n",
> > +                           drm_get_format_name(fb->format->format,
> > +                                               &format_name));
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct drm_encoder_helper_funcs vkms_wb_encoder_helper_fu=
ncs =3D {
> > +     .atomic_check =3D vkms_wb_encoder_atomic_check,
> > +};
> > +
> > +static int vkms_wb_connector_get_modes(struct drm_connector *connector=
)
> > +{
> > +     struct drm_device *dev =3D connector->dev;
> > +
> > +     return drm_add_modes_noedid(connector, dev->mode_config.max_width=
,
> > +                                 dev->mode_config.max_height);
> > +}
> > +
> > +static int vkms_wb_prepare_job(struct drm_writeback_connector *wb_conn=
ector,
> > +                            struct drm_writeback_job *job)
> > +{
> > +     struct vkms_gem_object *vkms_obj;
> > +     struct drm_gem_object *gem_obj;
> > +     int ret;
> > +
> > +     if (!job->fb)
> > +             return 0;
> > +
> > +     gem_obj =3D drm_gem_fb_get_obj(job->fb, 0);
> > +     ret =3D vkms_gem_vmap(gem_obj);
> > +     if (ret) {
> > +             DRM_ERROR("vmap failed: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     vkms_obj =3D drm_gem_to_vkms_gem(gem_obj);
> > +     job->priv =3D vkms_obj->vaddr;
> > +
> > +     return 0;
> > +}
> > +
> > +static void vkms_wb_cleanup_job(struct drm_writeback_connector *connec=
tor,
> > +                             struct drm_writeback_job *job)
> > +{
> > +     struct drm_gem_object *gem_obj;
> > +
> > +     if (!job->fb)
> > +             return;
> > +
> > +     gem_obj =3D drm_gem_fb_get_obj(job->fb, 0);
> > +     vkms_gem_vunmap(gem_obj);
> > +}
> > +
> > +static void vkms_wb_atomic_commit(struct drm_connector *conn,
> > +                               struct drm_connector_state *state)
> > +{
> > +     struct vkms_device *vkmsdev =3D drm_device_to_vkms_device(conn->d=
ev);
> > +     struct vkms_output *output =3D &vkmsdev->output;
> > +     struct drm_writeback_connector *wb_conn =3D &output->wb_connector=
;
> > +     struct drm_connector_state *conn_state =3D wb_conn->base.state;
> > +     void *priv_data =3D conn_state->writeback_job->priv;
> > +     struct vkms_crc_data *primary_data =3D NULL;
> > +     struct drm_framebuffer *fb =3D NULL;
> > +     struct vkms_gem_object *vkms_obj;
> > +     struct drm_gem_object *gem_obj;
> > +     struct drm_plane *plane;
> > +
> > +     if (!conn_state)
> > +             return;
> > +
> > +     if (!conn_state->writeback_job || !conn_state->writeback_job->fb)=
 {
> > +             output->writeback_status =3D WB_STOP;
> > +             DRM_DEBUG_DRIVER("Disable writeback\n");
> > +             return;
> > +     }
> > +
> > +     drm_for_each_plane(plane, &vkmsdev->drm) {
> > +             struct vkms_plane_state *vplane_state;
> > +             struct vkms_crc_data *plane_data;
> > +
> > +             vplane_state =3D to_vkms_plane_state(plane->state);
> > +             plane_data =3D vplane_state->crc_data;
> > +
> > +             if (drm_framebuffer_read_refcount(&plane_data->fb) =3D=3D=
 0)
> > +                     continue;
> > +
> > +             if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY)
> > +                     primary_data =3D plane_data;
> > +     }
> > +
> > +     if (!primary_data)
> > +             return;
> > +
> > +     fb =3D &primary_data->fb;
> > +     gem_obj =3D drm_gem_fb_get_obj(fb, 0);
> > +     vkms_obj =3D drm_gem_to_vkms_gem(gem_obj);
> > +
> > +     if (!vkms_obj->vaddr || !priv_data)
> > +             return;
> > +
> > +     memcpy(priv_data, vkms_obj->vaddr, vkms_obj->gem.size);
> > +     drm_writeback_queue_job(wb_conn, state);
> > +     output->writeback_status =3D WB_START;
>
> Hm, if this passes the current writeback tests then I guess those tests
> are a bit too simple. Or maybe the test can't use the cursor plane, and
> that's why it doesn't notice that we only write back the primary plane.

Hi,

Sorry, I knew about that, and I should have highlighted this
information in the cover letter. In my original plan, I wanted to land
a basic version of writeback in the vkms to try to upstream the
kms_writeback; then I wish that I could improve vkms and the tests in
parallel.

In summary, the kms_writeback is not upstream yet, and it needs some
improvements. IHMO, we should try to upstream the current version and
improve it step-by-step by using VKMS. If Brian and Liviu agree, I
would like to try to send a new version of their patchset. What do you
think?

Daniel, about your patchset (drm/vkms: rework crc worker), just give
me a time to go through your patchset. After that, I'll make the
required changes and update the writeback.

Thank you all for the feedback. I'll prepare a V2 with all the suggestions.

> Writeback is supposed to write back the same image you'd see on the
> screen, i.e. with cursor, other planes, any color correction applied and
> anything else really. That means vkms writeback needs to be integrated
> into the crc computation. We need to run that work either when there's a
> writeback job or when we need a crc. Crc would be only computed when
> needed, and for writeback we need to put the entire composited/blended
> buffer into the writeback buffer.
>
> That's why I said yesterday that your work will conflict with my work to
> reorg crc work handling, aside from the final step it needs to do all the
> same things.
>
> I guess would be good to improve igt and add a cursor testcase for write
> (similar to the crc cursor tests we have), or maybe create support in igt
> to use writeback instead of crc, so that we could better check this.
> -Daniel
>
> > +}
> > +
> > +static const struct drm_connector_helper_funcs vkms_wb_conn_helper_fun=
cs =3D {
> > +     .get_modes =3D vkms_wb_connector_get_modes,
> > +     .prepare_writeback_job =3D vkms_wb_prepare_job,
> > +     .cleanup_writeback_job =3D vkms_wb_cleanup_job,
> > +     .atomic_commit =3D vkms_wb_atomic_commit,
> > +};
> > +
> > +int enable_writeback_connector(struct vkms_device *vkmsdev)
> > +{
> > +     struct drm_writeback_connector *wb =3D &vkmsdev->output.wb_connec=
tor;
> > +
> > +     vkmsdev->output.wb_connector.encoder.possible_crtcs =3D 1;
> > +     drm_connector_helper_add(&wb->base, &vkms_wb_conn_helper_funcs);
> > +
> > +     return drm_writeback_connector_init(&vkmsdev->drm, wb,
> > +                                         &vkms_wb_connector_funcs,
> > +                                         &vkms_wb_encoder_helper_funcs=
,
> > +                                         vkms_formats,
> > +                                         ARRAY_SIZE(vkms_formats));
> > +}
> > +
> > --
> > 2.21.0
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



--=20

Rodrigo Siqueira
https://siqueira.tech
