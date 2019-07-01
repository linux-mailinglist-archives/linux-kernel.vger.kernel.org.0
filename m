Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74DF5B11B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2019 20:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfF3SVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jun 2019 14:21:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41600 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfF3SVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 14:21:04 -0400
Received: by mail-io1-f66.google.com with SMTP id w25so23564075ioc.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjEfTnnvI4w267ybze9u38d7bxDYLYnqBslBW1G/hGA=;
        b=Ewvm7bptNWsPrvRfFzDms/Lb8PBSO7XxdkLIkVL7CEuG0IwqasZAybaGMl0qgIVpm8
         m2vOrp0KiohRCtPVTzDjY1YQp1jvePY4ZeXkaCRfJ1CXMAlUI/mG53YncwWhRDTrrqQp
         R8rpkWCE9bPtiVZ19+bMFwlGExHQKpsOjJCzXvKrpm/5siwgg5IAFvBJ5PQ88lQ7zYBf
         W4F7//pHtaY4JlzJ4v6kKcg+LIaRzLlPQ6LopP5x4PRtIeiSZMqiJpi0watHgxP79Gw+
         bBV7Z+NG4j8Iun9EiKPAjFTeTzs2q6xNgOTxT79hH7O3K844Q8pXSKIJq00ev47lMkF4
         BYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjEfTnnvI4w267ybze9u38d7bxDYLYnqBslBW1G/hGA=;
        b=DMYvEj36iRMpxPC3ochxHSOQNCy4vik2a5Ja243LCRrfYVf6dHuEe8L5TJSScTHsAe
         SY5IkpkcKw3I644IB964TBb7nk9ypq/DDMYW/iwZKGEqbh8O6mHAfYaiJp5K0o/dhgrP
         lSDKnOPMpWw0IDAp8njsWhvnGXJP/8DMUQU/dX6F5yRdYp3i7KGQY2T9oH4y/iwaNGVX
         BKxMU6OyiORjx2g6wAloNDRMsw2SEXPmzuXtg5PRhezxPwrDxIsb8Jzdgor/02W4VCgE
         k/wMFa1H8AB8mZtcp/pFWWxgFLspqq1dIjnyYA4niDFywIBS4BCD2y7idukrYwDH58dC
         sGjA==
X-Gm-Message-State: APjAAAX46A9HLyEDBjd5MM6ECSAHpkxG7TRC/gd3B/v0vsfVYch98b6E
        9XcmRsP2l8Nnel+qDG8t9VbA2BMM1XyYuZG/nMVFYsnU
X-Google-Smtp-Source: APXvYqxuwR2wyYqB18x+C2UYL9YmLPI39BQmuBIj9Bz8MZXOWG15Mllg0/VgLtpRaMngylyoCFXm3p+cMHHa3g9RrjU=
X-Received: by 2002:a6b:9257:: with SMTP id u84mr21513199iod.278.1561918863258;
 Sun, 30 Jun 2019 11:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190628121338.24398-1-kraxel@redhat.com> <20190628121338.24398-9-kraxel@redhat.com>
In-Reply-To: <20190628121338.24398-9-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Sun, 30 Jun 2019 11:20:52 -0700
Message-ID: <CAPaKu7RRf3T3RCYXJ466xt7U1dAxRx++Ln+ey50a=yjdXpZw6g@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] drm/virtio: rework virtio_gpu_execbuffer_ioctl fencing
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 5:13 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Use gem reservation helpers and direct reservation_object_* calls
> instead of ttm.
>
> v5: fix fencing (Chia-I Wu).
> v3: Also attach the array of gem objects to the virtio command buffer,
> so we can drop the object references in the completion callback.  Needed
> because ttm fence helpers grab a reference for us, but gem helpers
> don't.
There are other places
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  6 ++-
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 62 +++++++++++---------------
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 17 ++++---
>  3 files changed, 43 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 98d646789d23..356d27132388 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -120,9 +120,9 @@ struct virtio_gpu_vbuffer {
>
>         char *resp_buf;
>         int resp_size;
> -
>         virtio_gpu_resp_cb resp_cb;
>
> +       struct virtio_gpu_object_array *objs;
>         struct list_head list;
>  };
>
> @@ -311,7 +311,9 @@ void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device *vgdev,
>                                             uint32_t resource_id);
>  void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
>                            void *data, uint32_t data_size,
> -                          uint32_t ctx_id, struct virtio_gpu_fence *fence);
> +                          uint32_t ctx_id,
> +                          struct virtio_gpu_object_array *objs,
> +                          struct virtio_gpu_fence *fence);
>  void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
>                                           uint32_t resource_id, uint32_t ctx_id,
>                                           uint64_t offset, uint32_t level,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 0caff3fa623e..ae6830aa38c9 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -105,14 +105,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         struct drm_virtgpu_execbuffer *exbuf = data;
>         struct virtio_gpu_device *vgdev = dev->dev_private;
>         struct virtio_gpu_fpriv *vfpriv = drm_file->driver_priv;
> -       struct drm_gem_object *gobj;
>         struct virtio_gpu_fence *out_fence;
> -       struct virtio_gpu_object *qobj;
>         int ret;
>         uint32_t *bo_handles = NULL;
>         void __user *user_bo_handles = NULL;
> -       struct list_head validate_list;
> -       struct ttm_validate_buffer *buflist = NULL;
> +       struct virtio_gpu_object_array *buflist = NULL;
>         int i;
>         struct ww_acquire_ctx ticket;
>         struct sync_file *sync_file;
> @@ -155,15 +152,10 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>                         return out_fence_fd;
>         }
>
> -       INIT_LIST_HEAD(&validate_list);
>         if (exbuf->num_bo_handles) {
> -
>                 bo_handles = kvmalloc_array(exbuf->num_bo_handles,
> -                                          sizeof(uint32_t), GFP_KERNEL);
> -               buflist = kvmalloc_array(exbuf->num_bo_handles,
> -                                          sizeof(struct ttm_validate_buffer),
> -                                          GFP_KERNEL | __GFP_ZERO);
> -               if (!bo_handles || !buflist) {
> +                                           sizeof(uint32_t), GFP_KERNEL);
> +               if (!bo_handles) {
>                         ret = -ENOMEM;
>                         goto out_unused_fd;
>                 }
> @@ -175,25 +167,22 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>                         goto out_unused_fd;
>                 }
>
> -               for (i = 0; i < exbuf->num_bo_handles; i++) {
> -                       gobj = drm_gem_object_lookup(drm_file, bo_handles[i]);
> -                       if (!gobj) {
> -                               ret = -ENOENT;
> -                               goto out_unused_fd;
> -                       }
> -
> -                       qobj = gem_to_virtio_gpu_obj(gobj);
> -                       buflist[i].bo = &qobj->tbo;
> -
> -                       list_add(&buflist[i].head, &validate_list);
> +               buflist = virtio_gpu_array_from_handles(drm_file, bo_handles,
> +                                                       exbuf->num_bo_handles);
> +               if (!buflist) {
> +                       ret = -ENOENT;
> +                       goto out_unused_fd;
>                 }
>                 kvfree(bo_handles);
>                 bo_handles = NULL;
>         }
>
> -       ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
> -       if (ret)
> -               goto out_free;
> +       if (buflist) {
> +               ret = drm_gem_lock_reservations(buflist->objs, buflist->nents,
> +                                               &ticket);
> +               if (ret)
> +                       goto out_unused_fd;
> +       }
>
>         buf = memdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
>         if (IS_ERR(buf)) {
> @@ -219,25 +208,28 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>                 fd_install(out_fence_fd, sync_file->file);
>         }
>
> +       if (buflist)
> +               for (i = 0; i < exbuf->num_bo_handles; i++)
> +                       reservation_object_add_excl_fence(buflist->objs[i]->resv,
> +                                                         &out_fence->f);
> +
Another module can see the semi-initialized fence after this.  We
should move this after virtio_gpu_cmd_submit.

>         virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
> -                             vfpriv->ctx_id, out_fence);
> +                             vfpriv->ctx_id, buflist, out_fence);
>
> -       ttm_eu_fence_buffer_objects(&ticket, &validate_list, &out_fence->f);
> -
> -       /* fence the command bo */
> -       virtio_gpu_unref_list(&validate_list);
> -       kvfree(buflist);
> +       if (buflist)
> +               drm_gem_unlock_reservations(buflist->objs, buflist->nents,
> +                                           &ticket);
When virtio_gpu_cmd_submit progresses really fast, buflist might have
been freed.

>         return 0;
>
>  out_memdup:
>         kfree(buf);
>  out_unresv:
> -       ttm_eu_backoff_reservation(&ticket, &validate_list);
> -out_free:
> -       virtio_gpu_unref_list(&validate_list);
> +       if (buflist)
> +               drm_gem_unlock_reservations(buflist->objs, buflist->nents, &ticket);
>  out_unused_fd:
>         kvfree(bo_handles);
> -       kvfree(buflist);
> +       if (buflist)
> +               virtio_gpu_array_put_free(buflist);
>
>         if (out_fence_fd >= 0)
>                 put_unused_fd(out_fence_fd);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 6c1a90717535..0c87c3e086f8 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -191,7 +191,7 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
>         } while (!virtqueue_enable_cb(vgdev->ctrlq.vq));
>         spin_unlock(&vgdev->ctrlq.qlock);
>
> -       list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
> +       list_for_each_entry(entry, &reclaim_list, list) {
>                 resp = (struct virtio_gpu_ctrl_hdr *)entry->resp_buf;
>
>                 trace_virtio_gpu_cmd_response(vgdev->ctrlq.vq, resp);
> @@ -218,14 +218,18 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
>                 }
>                 if (entry->resp_cb)
>                         entry->resp_cb(vgdev, entry);
> -
> -               list_del(&entry->list);
> -               free_vbuf(vgdev, entry);
>         }
>         wake_up(&vgdev->ctrlq.ack_queue);
>
>         if (fence_id)
>                 virtio_gpu_fence_event_process(vgdev, fence_id);
> +
> +       list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
> +               if (entry->objs)
> +                       virtio_gpu_array_put_free(entry->objs);
> +               list_del(&entry->list);
> +               free_vbuf(vgdev, entry);
> +       }
>  }
>
>  void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
> @@ -939,7 +943,9 @@ void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
>
>  void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
>                            void *data, uint32_t data_size,
> -                          uint32_t ctx_id, struct virtio_gpu_fence *fence)
> +                          uint32_t ctx_id,
> +                          struct virtio_gpu_object_array *objs,
> +                          struct virtio_gpu_fence *fence)
>  {
>         struct virtio_gpu_cmd_submit *cmd_p;
>         struct virtio_gpu_vbuffer *vbuf;
> @@ -949,6 +955,7 @@ void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
>
>         vbuf->data_buf = data;
>         vbuf->data_size = data_size;
> +       vbuf->objs = objs;
>
>         cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_SUBMIT_3D);
>         cmd_p->hdr.ctx_id = cpu_to_le32(ctx_id);
> --
> 2.18.1
>
