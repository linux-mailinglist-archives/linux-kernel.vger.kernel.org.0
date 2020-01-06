Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E29131259
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 13:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgAFMzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 07:55:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36564 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726467AbgAFMzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 07:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578315306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhPHPLkCZ8lM3SxpsRZPADXb9w62jCJdaNx5uMlL9bE=;
        b=FFCAnCx9owovULn/g3G9mOA1t2WDXXQAiug+GuV8EsDCspUBDvTWkQ8DkBs+5hOMmvqox0
        pju9Z+PDRuP+IU1igRgHWBUePud2XJP1c937R0r58/cphVIktFiGEIj1j8GrKzrnkJJSJE
        v+OZw1eSwECCy4yFrVWGzZEkKA64P2g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-mD9HBtSZP9CECu14JOp73A-1; Mon, 06 Jan 2020 07:54:59 -0500
X-MC-Unique: mD9HBtSZP9CECu14JOp73A-1
Received: by mail-qv1-f70.google.com with SMTP id e14so4310672qvr.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 04:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yhPHPLkCZ8lM3SxpsRZPADXb9w62jCJdaNx5uMlL9bE=;
        b=OCtq7+88qsxNUzdybpsjo7RoaTnEtFkJM4ttGa2FpZRJObThGsVDDxbx543iT72UGT
         84igHXKGjopIOUX8EXH5LLJeHhkhsih/f96yKbnTIzY6K9cLYcHsW4u9wROHPasEz0Xz
         9xnnW4r1In3EIHcZ6Cegcg16MJcEr/fFmt4JfaMvrjLF/0A4opRbRUv4rTQs5FgV6n7O
         nRs/NbTyg9d9K5Hip+OBEVajVOhBa62b/lyx9K+YYahuOjFUk1bPL4Ev2a7qljidk2Al
         O7dO7F8tLtA6UIsQj80/x7+/eb68mS4nUI8BusBPElAZNj1+FK5ykhbfU+BoQYWidjgC
         unwQ==
X-Gm-Message-State: APjAAAVAWtbhK6HqQD/cjgzooaDEzyHY6rc1KTBItF5kqeebQAGrU34I
        Rp7PxzXF7Y+TAX+Wjz83IoEHF+72kZDRtC1u4MNTfDcRwMoDyfroBx1yvgbjQL1fR3umcS7r8f4
        nr2zVslhGL9tjTssqkQqFvKRV
X-Received: by 2002:ae9:c018:: with SMTP id u24mr82140921qkk.339.1578315299359;
        Mon, 06 Jan 2020 04:54:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxDXcUxpr3THHQDy0ezxTflLL2W1afkjCl20F4fSV1ea/2dz+3q8ot7JpP826jzMXK+20FIoA==
X-Received: by 2002:ae9:c018:: with SMTP id u24mr82140903qkk.339.1578315299104;
        Mon, 06 Jan 2020 04:54:59 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id c3sm20686592qkk.8.2020.01.06.04.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 04:54:58 -0800 (PST)
Date:   Mon, 6 Jan 2020 07:54:53 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] virtio_net: CTRL_GUEST_OFFLOADS depends on CTRL_VQ
Message-ID: <20200106074426-mutt-send-email-mst@kernel.org>
References: <20200105132120.92370-1-mst@redhat.com>
 <2d7053b5-295c-4051-a722-7656350bdb74@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d7053b5-295c-4051-a722-7656350bdb74@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 10:47:35AM +0800, Jason Wang wrote:
> 
> On 2020/1/5 下午9:22, Michael S. Tsirkin wrote:
> > The only way for guest to control offloads (as enabled by
> > VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) is by sending commands
> > through CTRL_VQ. So it does not make sense to
> > acknowledge VIRTIO_NET_F_CTRL_GUEST_OFFLOADS without
> > VIRTIO_NET_F_CTRL_VQ.
> > 
> > The spec does not outlaw devices with such a configuration, so we have
> > to support it. Simply clear VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> > Note that Linux is still crashing if it tries to
> > change the offloads when there's no control vq.
> > That needs to be fixed by another patch.
> > 
> > Reported-by: Alistair Delva <adelva@google.com>
> > Reported-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Fixes: 3f93522ffab2 ("virtio-net: switch off offloads on demand if possible on XDP set")
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Same patch as v1 but update documentation so it's clear it's not
> > enough to fix the crash.
> > 
> >   drivers/net/virtio_net.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 4d7d5434cc5d..7b8805b47f0d 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2971,6 +2971,15 @@ static int virtnet_validate(struct virtio_device *vdev)
> >   	if (!virtnet_validate_features(vdev))
> >   		return -EINVAL;
> > +	/* VIRTIO_NET_F_CTRL_GUEST_OFFLOADS does not work without
> > +	 * VIRTIO_NET_F_CTRL_VQ. Unfortunately spec forgot to
> > +	 * specify that VIRTIO_NET_F_CTRL_GUEST_OFFLOADS depends
> > +	 * on VIRTIO_NET_F_CTRL_VQ so devices can set the later but
> > +	 * not the former.
> > +	 */
> > +	if (!virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
> > +			__virtio_clear_bit(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS);
> 
> 
> If it's just because a bug of spec, should we simply fix the bug and fail
> the negotiation in virtnet_validate_feature()?

One man's bug is another man's feature: arguably leaving the features
independent in the spec might allow reuse of the feature bit without
breaking guests.

And even if we say it's a bug we can't simply fix the bug in the
spec: changing the text for a future version does not change the fact
that devices behaving according to the spec exist.

> Otherwise there would be inconsistency in handling feature dependencies for
> ctrl vq.
> 
> Thanks

That's a cosmetic problem ATM. It might be a good idea to generally
change our handling of dependencies, and clear feature bits instead of
failing probe on a mismatch. It's worth thinking  - at the spec level -
how we can best make the configuration extensible.
But that's not something spec should worry about.


> 
> > +
> >   	if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
> >   		int mtu = virtio_cread16(vdev,
> >   					 offsetof(struct virtio_net_config,

