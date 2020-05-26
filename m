Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5DC199F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 21:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbgCaTaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 15:30:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38091 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727708AbgCaTaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585683019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UpUD1JgEMbiTeKuDtcfbarlvunPYOvi5RMSv8hFzL24=;
        b=NuNNZXCOfnqIOG8Y/irZcU9m3mtsp7wSnnp49t2FLRX/QRkzyId93iiWPrm5zOzdMbokLv
        4X1Gk6d0i2Oe8eOG66oyASdu6qL/HWPicuDAextEP3Yy6A696nSxQaDIs1zkj+5xPiY8pF
        DnBM1C4Sy8e+P239x9w53inLyy506Y4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-ttKFWcf2NeqFWqmo0SnrsQ-1; Tue, 31 Mar 2020 15:30:16 -0400
X-MC-Unique: ttKFWcf2NeqFWqmo0SnrsQ-1
Received: by mail-lf1-f70.google.com with SMTP id l3so8970464lfe.22
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UpUD1JgEMbiTeKuDtcfbarlvunPYOvi5RMSv8hFzL24=;
        b=Wh1sqC5GO8Hw0LY/EkJK3jhfUJYBsTsOex9A48i302wIEyrm70Z6d27xS78Cpu+ubB
         3OcwtRMk8mAGxDzYvlyDpw2BSLUNlPa+vu2wfiqiQ/SNUZsM9G9XESjU6TRJhj+kQyb5
         7RifamHEcJaqgAIk3OWLwowAeCr9UfKPhsCSuaUaCzF9c8jdAKNMK0/4BzDAXpli93KI
         xFjmOVdGzxTpGeKeFVmgL246bfB372zISdW8omzX/gO1X/iT8g1ENE+WB87mo2yFqzKh
         vMKzVmyojDN4fqbanKCsM2nedfPbvKEnfr5cEeFgk//W61CCCAew/DzUakQSUFmxznlq
         kquQ==
X-Gm-Message-State: AGi0PubMzkUQFm3uGW+jmm8gjGuwn1LxHgFP3eYVtRLsv34UIXaXiMX/
        LreriYvN7cv8ZWclUqhjQa+62TJM4ItILJxYTXBhKuwlM7pfMxIOw/+aOM4eNzF/jjz9XNTOgQs
        uvhkxRR2A7TvhDFqztkArU9f1eSOdxLWvRGQpxzbz
X-Received: by 2002:ac2:4199:: with SMTP id z25mr12316653lfh.90.1585683014301;
        Tue, 31 Mar 2020 12:30:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypJhWHR1e3yFKlW02voYvvq7yPGRxklHTLnYsbNB5eexsLfQZB5Gq+0Qo0MSOyWCKWui5xHhfhrh7QYm8fcFEMM=
X-Received: by 2002:ac2:4199:: with SMTP id z25mr12316641lfh.90.1585683014001;
 Tue, 31 Mar 2020 12:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200331180006.25829-1-eperezma@redhat.com> <20200331180006.25829-2-eperezma@redhat.com>
 <20200331141244-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200331141244-mutt-send-email-mst@kernel.org>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 31 Mar 2020 21:29:37 +0200
Message-ID: <CAJaqyWe2xxSR5GpV8c-mPoOizwe8nw-HrKPdjvr4ykOL_garKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] vhost: Create accessors for virtqueues private_data
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 8:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Mar 31, 2020 at 07:59:59PM +0200, Eugenio P=C3=A9rez wrote:
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vhost/net.c   | 28 +++++++++++++++-------------
> >  drivers/vhost/vhost.h | 28 ++++++++++++++++++++++++++++
> >  drivers/vhost/vsock.c | 14 +++++++-------
> >  3 files changed, 50 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index e158159671fa..6c5e7a6f712c 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -424,7 +424,7 @@ static void vhost_net_disable_vq(struct vhost_net *=
n,
> >       struct vhost_net_virtqueue *nvq =3D
> >               container_of(vq, struct vhost_net_virtqueue, vq);
> >       struct vhost_poll *poll =3D n->poll + (nvq - n->vqs);
> > -     if (!vq->private_data)
> > +     if (!vhost_vq_get_backend_opaque(vq))
> >               return;
> >       vhost_poll_stop(poll);
> >  }
> > @@ -437,7 +437,7 @@ static int vhost_net_enable_vq(struct vhost_net *n,
> >       struct vhost_poll *poll =3D n->poll + (nvq - n->vqs);
> >       struct socket *sock;
> >
> > -     sock =3D vq->private_data;
> > +     sock =3D vhost_vq_get_backend_opaque(vq);
> >       if (!sock)
> >               return 0;
> >
> > @@ -524,7 +524,7 @@ static void vhost_net_busy_poll(struct vhost_net *n=
et,
> >               return;
> >
> >       vhost_disable_notify(&net->dev, vq);
> > -     sock =3D rvq->private_data;
> > +     sock =3D vhost_vq_get_backend_opaque(rvq);
> >
> >       busyloop_timeout =3D poll_rx ? rvq->busyloop_timeout:
> >                                    tvq->busyloop_timeout;
> > @@ -570,8 +570,10 @@ static int vhost_net_tx_get_vq_desc(struct vhost_n=
et *net,
> >
> >       if (r =3D=3D tvq->num && tvq->busyloop_timeout) {
> >               /* Flush batched packets first */
> > -             if (!vhost_sock_zcopy(tvq->private_data))
> > -                     vhost_tx_batch(net, tnvq, tvq->private_data, msgh=
dr);
> > +             if (!vhost_sock_zcopy(vhost_vq_get_backend_opaque(tvq)))
> > +                     vhost_tx_batch(net, tnvq,
> > +                                    vhost_vq_get_backend_opaque(tvq),
> > +                                    msghdr);
> >
> >               vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, false);
> >
> > @@ -685,7 +687,7 @@ static int vhost_net_build_xdp(struct vhost_net_vir=
tqueue *nvq,
> >       struct vhost_virtqueue *vq =3D &nvq->vq;
> >       struct vhost_net *net =3D container_of(vq->dev, struct vhost_net,
> >                                            dev);
> > -     struct socket *sock =3D vq->private_data;
> > +     struct socket *sock =3D vhost_vq_get_backend_opaque(vq);
> >       struct page_frag *alloc_frag =3D &net->page_frag;
> >       struct virtio_net_hdr *gso;
> >       struct xdp_buff *xdp =3D &nvq->xdp[nvq->batched_xdp];
> > @@ -952,7 +954,7 @@ static void handle_tx(struct vhost_net *net)
> >       struct socket *sock;
> >
> >       mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_TX);
> > -     sock =3D vq->private_data;
> > +     sock =3D vhost_vq_get_backend_opaque(vq);
> >       if (!sock)
> >               goto out;
> >
> > @@ -1121,7 +1123,7 @@ static void handle_rx(struct vhost_net *net)
> >       int recv_pkts =3D 0;
> >
> >       mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
> > -     sock =3D vq->private_data;
> > +     sock =3D vhost_vq_get_backend_opaque(vq);
> >       if (!sock)
> >               goto out;
> >
> > @@ -1344,9 +1346,9 @@ static struct socket *vhost_net_stop_vq(struct vh=
ost_net *n,
> >               container_of(vq, struct vhost_net_virtqueue, vq);
> >
> >       mutex_lock(&vq->mutex);
> > -     sock =3D vq->private_data;
> > +     sock =3D vhost_vq_get_backend_opaque(vq);
> >       vhost_net_disable_vq(n, vq);
> > -     vq->private_data =3D NULL;
> > +     vhost_vq_set_backend_opaque(vq, NULL);
> >       vhost_net_buf_unproduce(nvq);
> >       nvq->rx_ring =3D NULL;
> >       mutex_unlock(&vq->mutex);
> > @@ -1528,7 +1530,7 @@ static long vhost_net_set_backend(struct vhost_ne=
t *n, unsigned index, int fd)
> >       }
> >
> >       /* start polling new socket */
> > -     oldsock =3D vq->private_data;
> > +     oldsock =3D vhost_vq_get_backend_opaque(vq);
> >       if (sock !=3D oldsock) {
> >               ubufs =3D vhost_net_ubuf_alloc(vq,
> >                                            sock && vhost_sock_zcopy(soc=
k));
> > @@ -1538,7 +1540,7 @@ static long vhost_net_set_backend(struct vhost_ne=
t *n, unsigned index, int fd)
> >               }
> >
> >               vhost_net_disable_vq(n, vq);
> > -             vq->private_data =3D sock;
> > +             vhost_vq_set_backend_opaque(vq, sock);
> >               vhost_net_buf_unproduce(nvq);
> >               r =3D vhost_vq_init_access(vq);
> >               if (r)
> > @@ -1575,7 +1577,7 @@ static long vhost_net_set_backend(struct vhost_ne=
t *n, unsigned index, int fd)
> >       return 0;
> >
> >  err_used:
> > -     vq->private_data =3D oldsock;
> > +     vhost_vq_set_backend_opaque(vq, oldsock);
> >       vhost_net_enable_vq(n, vq);
> >       if (ubufs)
> >               vhost_net_ubuf_put_wait_and_free(ubufs);
> > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > index a123fd70847e..0808188f7e8f 100644
> > --- a/drivers/vhost/vhost.h
> > +++ b/drivers/vhost/vhost.h
> > @@ -244,6 +244,34 @@ enum {
> >                        (1ULL << VIRTIO_F_VERSION_1)
> >  };
> >
> > +/**
> > + * vhost_vq_set_backend_opaque - Set backend opaque.
> > + *
> > + * @vq            Virtqueue.
> > + * @private_data  The private data.
> > + *
> > + * Context: Need to call with vq->mutex acquired.
> > + */
> > +static inline void vhost_vq_set_backend_opaque(struct vhost_virtqueue =
*vq,
> > +                                            void *private_data)
> > +{
> > +     vq->private_data =3D private_data;
> > +}
> > +
> > +/**
> > + * vhost_vq_get_backend_opaque - Get backend opaque.
> > + *
> > + * @vq            Virtqueue.
> > + * @private_data  The private data.
> > + *
> > + * Context: Need to call with vq->mutex acquired.
> > + * Return: Opaque previously set with vhost_vq_set_backend_opaque.
> > + */
> > +static inline void *vhost_vq_get_backend_opaque(struct vhost_virtqueue=
 *vq)
> > +{
> > +     return vq->private_data;
> > +}
> > +
> >  static inline bool vhost_has_feature(struct vhost_virtqueue *vq, int b=
it)
> >  {
> >       return vq->acked_features & (1ULL << bit);
>
>
> I think I prefer vhost_vq_get_backend and vhost_vq_set_backend.
>
> "opaque" just means that it's void * that is clear from the signature
> anyway.
>

I agree. Changed in sent v3.

Thanks!

>
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index c2d7d57e98cf..6e20dbe14acd 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -91,7 +91,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock=
,
> >
> >       mutex_lock(&vq->mutex);
> >
> > -     if (!vq->private_data)
> > +     if (!vhost_vq_get_backend_opaque(vq))
> >               goto out;
> >
> >       /* Avoid further vmexits, we're already processing the virtqueue =
*/
> > @@ -440,7 +440,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost=
_work *work)
> >
> >       mutex_lock(&vq->mutex);
> >
> > -     if (!vq->private_data)
> > +     if (!vhost_vq_get_backend_opaque(vq))
> >               goto out;
> >
> >       vhost_disable_notify(&vsock->dev, vq);
> > @@ -533,8 +533,8 @@ static int vhost_vsock_start(struct vhost_vsock *vs=
ock)
> >                       goto err_vq;
> >               }
> >
> > -             if (!vq->private_data) {
> > -                     vq->private_data =3D vsock;
> > +             if (!vhost_vq_get_backend_opaque(vq)) {
> > +                     vhost_vq_set_backend_opaque(vq, vsock);
> >                       ret =3D vhost_vq_init_access(vq);
> >                       if (ret)
> >                               goto err_vq;
> > @@ -547,14 +547,14 @@ static int vhost_vsock_start(struct vhost_vsock *=
vsock)
> >       return 0;
> >
> >  err_vq:
> > -     vq->private_data =3D NULL;
> > +     vhost_vq_set_backend_opaque(vq, NULL);
> >       mutex_unlock(&vq->mutex);
> >
> >       for (i =3D 0; i < ARRAY_SIZE(vsock->vqs); i++) {
> >               vq =3D &vsock->vqs[i];
> >
> >               mutex_lock(&vq->mutex);
> > -             vq->private_data =3D NULL;
> > +             vhost_vq_set_backend_opaque(vq, NULL);
> >               mutex_unlock(&vq->mutex);
> >       }
> >  err:
> > @@ -577,7 +577,7 @@ static int vhost_vsock_stop(struct vhost_vsock *vso=
ck)
> >               struct vhost_virtqueue *vq =3D &vsock->vqs[i];
> >
> >               mutex_lock(&vq->mutex);
> > -             vq->private_data =3D NULL;
> > +             vhost_vq_set_backend_opaque(vq, NULL);
> >               mutex_unlock(&vq->mutex);
> >       }
> >
> > --
> > 2.18.1
>

