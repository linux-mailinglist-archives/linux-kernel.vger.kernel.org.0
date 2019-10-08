Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F24CF771
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 12:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfJHKt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 06:49:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44147 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfJHKt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:49:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id r16so15137453edq.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z3cSnTSGffijIT6vfd/h9PBJ4b/lMd08VLowpFevAu4=;
        b=QRoxTNH8HzlkVmQ672u9tOKBXh7SMaiOCH4YK6w29LIn4LzX5K0l9Au12ZtnVs6ExK
         1Mn+g6XF9uGfCw0lZeJW9TYEsGcCYdcNftwvEjs3SDyT5Tl3aUpkcl3c9/Rwrjx5vZ4W
         oQT+DdHUDVNhlWkkffAh7zVFbh5f+ZDhj9Nxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z3cSnTSGffijIT6vfd/h9PBJ4b/lMd08VLowpFevAu4=;
        b=cJtm+h+0/iASVEzO0MEXX95p5iNfruiMJK+R8ASqDucfYUoSZCxm3T/AJyiwvW7nHb
         Wn3+0RMhMzPXu7aDkYld3zzyES7sXJrYdyx39Uk4/B75c7Jj8OLZBzmBSleVzlblaFbY
         YP9COBnYu2SDP4I21aQrIuK0t7LCbqhEMG7CJj6D+w+8bTZwKPmsmOO/9e0anZ2k4MO3
         dIC/g7ykxw5R5VDZ4ECs7LuHa143thqkrKVnwgQqqx9nmpTVrxULhv6RtwrCTYAgV51m
         8V4wTT+tO9PoBlJBNLy+FtRllSGDDfr5TXZbMr3LWu90XWhUSe7bg5McYsNwd0M6VhyF
         T97g==
X-Gm-Message-State: APjAAAVYqgVCjAH7oRErYFAyz0CtI4p2lq27w5GbiDzWxt/6Ap+QywCj
        Qj6vLuLgNqToqP23a+PW/4GW4eliIpKIUw==
X-Google-Smtp-Source: APXvYqx5xLOiQMySzf/uDFC44YybgXykjhGIC+r5hvjGyZZu5N+mc8U1w+LBtQyDwh+s1rJo/4i80Q==
X-Received: by 2002:a17:906:16cd:: with SMTP id t13mr27794111ejd.153.1570531792476;
        Tue, 08 Oct 2019 03:49:52 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id a22sm2218947ejs.17.2019.10.08.03.49.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 03:49:52 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id m18so2628422wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:49:51 -0700 (PDT)
X-Received: by 2002:a1c:e404:: with SMTP id b4mr3527968wmh.90.1570531791082;
 Tue, 08 Oct 2019 03:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190912094121.228435-1-tfiga@chromium.org> <20190917132305.GV3958@phenom.ffwll.local>
 <CAAFQd5ADmObo1yVnFGaWDU=DHF+tex3tWJxTZLkxv=EdGNNM7A@mail.gmail.com> <20191008100328.GN16989@phenom.ffwll.local>
In-Reply-To: <20191008100328.GN16989@phenom.ffwll.local>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 8 Oct 2019 19:49:39 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CR2YhyNoSv7=nUhPQ7Nap6n36DrtsCfqS+-iWydAqbNA@mail.gmail.com>
Message-ID: <CAAFQd5CR2YhyNoSv7=nUhPQ7Nap6n36DrtsCfqS+-iWydAqbNA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/virtio: Export resource handles via DMA-buf API
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stevensd@chromium.org,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Zach Reizner <zachr@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Pawel Osciak <posciak@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 7:03 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Sat, Oct 05, 2019 at 02:41:54PM +0900, Tomasz Figa wrote:
> > Hi Daniel, Gerd,
> >
> > On Tue, Sep 17, 2019 at 10:23 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Thu, Sep 12, 2019 at 06:41:21PM +0900, Tomasz Figa wrote:
> > > > This patch is an early RFC to judge the direction we are following in
> > > > our virtualization efforts in Chrome OS. The purpose is to start a
> > > > discussion on how to handle buffer sharing between multiple virtio
> > > > devices.
> > > >
> > > > On a side note, we are also working on a virtio video decoder interface
> > > > and implementation, with a V4L2 driver for Linux. Those will be posted
> > > > for review in the near future as well.
> > > >
> > > > Any feedback will be appreciated! Thanks in advance.
> > > >
> > > > ===
> > > >
> > > > With the range of use cases for virtualization expanding, there is going
> > > > to be more virtio devices added to the ecosystem. Devices such as video
> > > > decoders, encoders, cameras, etc. typically work together with the
> > > > display and GPU in a pipeline manner, which can only be implemented
> > > > efficiently by sharing the buffers between producers and consumers.
> > > >
> > > > Existing buffer management framework in Linux, such as the videobuf2
> > > > framework in V4L2, implements all the DMA-buf handling inside generic
> > > > code and do not expose any low level information about the buffers to
> > > > the drivers.
> > > >
> > > > To seamlessly enable buffer sharing with drivers using such frameworks,
> > > > make the virtio-gpu driver expose the resource handle as the DMA address
> > > > of the buffer returned from the DMA-buf mapping operation. Arguably, the
> > > > resource handle is a kind of DMA address already, as it is the buffer
> > > > identifier that the device needs to access the backing memory, which is
> > > > exactly the same role a DMA address provides for native devices.
> > > >
> > > > A virtio driver that does memory management fully on its own would have
> > > > code similar to following. The code is identical to what a regular
> > > > driver for real hardware would do to import a DMA-buf.
> > > >
> > > > static int virtio_foo_get_resource_handle(struct virtio_foo *foo,
> > > >                                         struct dma_buf *dma_buf, u32 *id)
> > > > {
> > > >       struct dma_buf_attachment *attach;
> > > >       struct sg_table *sgt;
> > > >       int ret = 0;
> > > >
> > > >       attach = dma_buf_attach(dma_buf, foo->dev);
> > > >       if (IS_ERR(attach))
> > > >               return PTR_ERR(attach);
> > > >
> > > >       sgt = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
> > > >       if (IS_ERR(sgt)) {
> > > >               ret = PTR_ERR(sgt);
> > > >               goto err_detach;
> > > >       }
> > > >
> > > >       if (sgt->nents != 1) {
> > > >               ret = -EINVAL;
> > > >               goto err_unmap;
> > > >       }
> > > >
> > > >       *id = sg_dma_address(sgt->sgl);
> > >
> > > I agree with Gerd, this looks pretty horrible to me.
> > >
> > > The usual way we've done these kind of special dma-bufs is:
> > >
> > > - They all get allocated at the same place, through some library or
> > >   whatever.
> > >
> > > - You add a dma_buf_is_virtio(dma_buf) function, or maybe something that
> > >   also upcasts or returns NULL, which checks for dma_buf->ops.
> > >
> >
> > Thanks for a lot of valuable feedback and sorry for the late reply.
> >
> > While I agree that stuffing the resource ID in sg_dma_address() is
> > quite ugly (for example, the regular address arithmetic doesn't work),
> > I still believe we need to convey information about these buffers
> > using regular kernel interfaces.
> >
> > Drivers in some subsystems like DRM tend to open code any buffer
> > management and then it wouldn't be any problem to do what you
> > suggested. However, other subsystems have generic frameworks for
> > buffer management, like videobuf2 for V4L2. Those assume regular
> > DMA-bufs that can be handled with regular dma_buf_() API and described
> > using sgtables and/or pfn vectors and/or DMA addresses.
>
> "other subsystem sucks" doesn't sound like a good design paradigm to me.
> Forced midlayers are a bad design decision isn't really new at all ...
>

Sorry, I don't think that's an argument. There are various design
aspects and for the scenarios for which V4L2 was designed, the other
subsystems may actually "suck". Let's not derail the discussion into
judging which subsystems are better or worse.

Those mid layers are not forced, you don't have to use videobuf2, but
it saves you a lot of open coding, potential security issues and so
on.

> > > - Once you've upcasted at runtime by checking for ->ops, you can add
> > >   whatever fancy interfaces you want. Including a real&proper interface to
> > >   get at whatever underlying id you need to for real buffer sharing
> > >   between virtio devices.
> > >
> > > In a way virtio buffer/memory ids are a kind of private bus, entirely
> > > distinct from the dma_addr_t bus. So can't really stuff them under this
> > > same thing like we e.g. do with pci peer2peer.
> >
> > As I mentioned earlier, there is no single "dma_addr_t bus". Each
> > device (as in struct device) can be on its own different DMA bus, with
> > a different DMA address space. There is not even a guarantee that a
> > DMA address obtained for one PCI device will be valid for another if
> > they are on different buses, which could have different address
> > mappings.
> >
> > Putting that aside, we're thinking about a different approach, as Gerd
> > suggested in another thread, the one about the Virtio Video Decoder
> > protocol. I'm going to reply there, making sure to CC everyone
> > involved here.
>
> ok.
> -Daniel
>
> >
> > Best regards,
> > Tomasz
> >
> > > -Daniel
> > >
> > > >
> > > > err_unmap:
> > > >       dma_buf_unmap_attachment(attach, sgt, DMA_BIDIRECTIONAL);
> > > > err_detach:
> > > >       dma_buf_detach(dma_buf, attach);
> > > >
> > > >       return ret;
> > > > }
> > > >
> > > > On the other hand, a virtio driver that uses an existing kernel
> > > > framework to manage buffers would not need to explicitly handle anything
> > > > at all, as the framework part responsible for importing DMA-bufs would
> > > > already do the work. For example, a V4L2 driver using the videobuf2
> > > > framework would just call thee vb2_dma_contig_plane_dma_addr() function
> > > > to get what the above open-coded function would return.
> > > >
> > > > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > > > ---
> > > >  drivers/gpu/drm/virtio/virtgpu_drv.c   |  2 +
> > > >  drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ++
> > > >  drivers/gpu/drm/virtio/virtgpu_prime.c | 81 ++++++++++++++++++++++++++
> > > >  3 files changed, 87 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > > > index 0fc32fa0b3c0..ac095f813134 100644
> > > > --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> > > > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > > > @@ -210,6 +210,8 @@ static struct drm_driver driver = {
> > > >  #endif
> > > >       .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> > > >       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> > > > +     .gem_prime_export = virtgpu_gem_prime_export,
> > > > +     .gem_prime_import = virtgpu_gem_prime_import,
> > > >       .gem_prime_get_sg_table = virtgpu_gem_prime_get_sg_table,
> > > >       .gem_prime_import_sg_table = virtgpu_gem_prime_import_sg_table,
> > > >       .gem_prime_vmap = virtgpu_gem_prime_vmap,
> > > > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > > > index e28829661724..687cfce91885 100644
> > > > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > > > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > > > @@ -367,6 +367,10 @@ void virtio_gpu_object_free_sg_table(struct virtio_gpu_object *bo);
> > > >  int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait);
> > > >
> > > >  /* virtgpu_prime.c */
> > > > +struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
> > > > +                                      int flags);
> > > > +struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
> > > > +                                             struct dma_buf *buf);
> > > >  struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
> > > >  struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
> > > >       struct drm_device *dev, struct dma_buf_attachment *attach,
> > > > diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> > > > index dc642a884b88..562eb1a2ed5b 100644
> > > > --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> > > > +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> > > > @@ -22,6 +22,9 @@
> > > >   * Authors: Andreas Pokorny
> > > >   */
> > > >
> > > > +#include <linux/dma-buf.h>
> > > > +#include <linux/dma-direction.h>
> > > > +
> > > >  #include <drm/drm_prime.h>
> > > >
> > > >  #include "virtgpu_drv.h"
> > > > @@ -30,6 +33,84 @@
> > > >   * device that might share buffers with virtgpu
> > > >   */
> > > >
> > > > +static struct sg_table *
> > > > +virtgpu_gem_map_dma_buf(struct dma_buf_attachment *attach,
> > > > +                     enum dma_data_direction dir)
> > > > +{
> > > > +     struct drm_gem_object *obj = attach->dmabuf->priv;
> > > > +     struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> > > > +     struct sg_table *sgt;
> > > > +     int ret;
> > > > +
> > > > +     sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
> > > > +     if (!sgt)
> > > > +             return ERR_PTR(-ENOMEM);
> > > > +
> > > > +     ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> > > > +     if (ret) {
> > > > +             kfree(sgt);
> > > > +             return ERR_PTR(-ENOMEM);
> > > > +     }
> > > > +
> > > > +     sg_dma_address(sgt->sgl) = bo->hw_res_handle;
> > > > +     sg_dma_len(sgt->sgl) = obj->size;
> > > > +     sgt->nents = 1;
> > > > +
> > > > +     return sgt;
> > > > +}
> > > > +
> > > > +static void virtgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
> > > > +                                   struct sg_table *sgt,
> > > > +                                   enum dma_data_direction dir)
> > > > +{
> > > > +     sg_free_table(sgt);
> > > > +     kfree(sgt);
> > > > +}
> > > > +
> > > > +static const struct dma_buf_ops virtgpu_dmabuf_ops =  {
> > > > +     .cache_sgt_mapping = true,
> > > > +     .attach = drm_gem_map_attach,
> > > > +     .detach = drm_gem_map_detach,
> > > > +     .map_dma_buf = virtgpu_gem_map_dma_buf,
> > > > +     .unmap_dma_buf = virtgpu_gem_unmap_dma_buf,
> > > > +     .release = drm_gem_dmabuf_release,
> > > > +     .mmap = drm_gem_dmabuf_mmap,
> > > > +     .vmap = drm_gem_dmabuf_vmap,
> > > > +     .vunmap = drm_gem_dmabuf_vunmap,
> > > > +};
> > > > +
> > > > +struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
> > > > +                                      int flags)
> > > > +{
> > > > +     struct dma_buf *buf;
> > > > +
> > > > +     buf = drm_gem_prime_export(obj, flags);
> > > > +     if (!IS_ERR(buf))
> > > > +             buf->ops = &virtgpu_dmabuf_ops;
> > > > +
> > > > +     return buf;
> > > > +}
> > > > +
> > > > +struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
> > > > +                                             struct dma_buf *buf)
> > > > +{
> > > > +     struct drm_gem_object *obj;
> > > > +
> > > > +     if (buf->ops == &virtgpu_dmabuf_ops) {
> > > > +             obj = buf->priv;
> > > > +             if (obj->dev == dev) {
> > > > +                     /*
> > > > +                      * Importing dmabuf exported from our own gem increases
> > > > +                      * refcount on gem itself instead of f_count of dmabuf.
> > > > +                      */
> > > > +                     drm_gem_object_get(obj);
> > > > +                     return obj;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     return drm_gem_prime_import(dev, buf);
> > > > +}
> > > > +
> > > >  struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
> > > >  {
> > > >       struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> > > > --
> > > > 2.23.0.237.gc6a4ce50a0-goog
> > > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
