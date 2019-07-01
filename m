Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 385F030A13
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 10:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfEaISa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 04:18:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36763 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfEaIS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:18:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so2816299wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 01:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BIz1bv11HMjHB1Hu4xZnOc0yPIRdRCqcQguEpfnn82A=;
        b=IPpOIB2j4h05T0bqw8davcq8UNTyLy1tAqhqrbeyrEpBQ+NavRHrImKdzlfZZ8XIza
         uMmZVrIMKybqK2T9zz6DqLQoMpnV3uMyL+S5RUU9rm9+8xk616XW37gVO1V3FpZtWNKJ
         9pqJJuS27NrvFZVWHYsvFrPSert9YF3rLgHW3OXpnfFex7AeRpfY9hMKe4focWv+NEHg
         ERdaVjMjK6DEHmYKxDnKLOOsGjwEYeOBtVREuEwcQb9cUJutE5nxdhwGQgD4agJmzde/
         gqRUr0WgixyMGlc0BOHymD86wftUFp8URwawYMn4v85NYRqwSnGB+9B2hw0OnI/UFEMT
         uuMw==
X-Gm-Message-State: APjAAAX/YlikyeIVar3QeIbqgBemXVWVXs54WSzGHNUCQWVL6hk4y/Lr
        vCZi5CH/6x4yCPBqAI5LOqA2wA==
X-Google-Smtp-Source: APXvYqye/QQLh7SIvvpoJvA/hOy1L+4fNdxw49tgzQO5LNakbcjr0yAiG43fF/BFitqAfrP4xKJycg==
X-Received: by 2002:adf:ff88:: with SMTP id j8mr5685635wrr.317.1559290707447;
        Fri, 31 May 2019 01:18:27 -0700 (PDT)
Received: from steredhat (host253-229-dynamic.248-95-r.retail.telecomitalia.it. [95.248.229.253])
        by smtp.gmail.com with ESMTPSA id n7sm3575495wrw.64.2019.05.31.01.18.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 01:18:26 -0700 (PDT)
Date:   Fri, 31 May 2019 10:18:24 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 3/4] vsock/virtio: fix flush of works during the .remove()
Message-ID: <20190531081824.p6ylsgvkrbckhqpx@steredhat>
References: <20190528105623.27983-1-sgarzare@redhat.com>
 <20190528105623.27983-4-sgarzare@redhat.com>
 <9ac9fc4b-5c39-2503-dfbb-660a7bdcfbfd@redhat.com>
 <20190529105832.oz3sagbne5teq3nt@steredhat>
 <8c9998c8-1b9c-aac6-42eb-135fcb966187@redhat.com>
 <20190530101036.wnjphmajrz6nz6zc@steredhat.homenet.telecomitalia.it>
 <4c881585-8fee-0a53-865c-05d41ffb8ed1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c881585-8fee-0a53-865c-05d41ffb8ed1@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 07:59:14PM +0800, Jason Wang wrote:
> 
> On 2019/5/30 下午6:10, Stefano Garzarella wrote:
> > On Thu, May 30, 2019 at 05:46:18PM +0800, Jason Wang wrote:
> > > On 2019/5/29 下午6:58, Stefano Garzarella wrote:
> > > > On Wed, May 29, 2019 at 11:22:40AM +0800, Jason Wang wrote:
> > > > > On 2019/5/28 下午6:56, Stefano Garzarella wrote:
> > > > > > @@ -690,6 +693,9 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
> > > > > >     	vsock->event_run = false;
> > > > > >     	mutex_unlock(&vsock->event_lock);
> > > > > > +	/* Flush all pending works */
> > > > > > +	virtio_vsock_flush_works(vsock);
> > > > > > +
> > > > > >     	/* Flush all device writes and interrupts, device will not use any
> > > > > >     	 * more buffers.
> > > > > >     	 */
> > > > > > @@ -726,6 +732,11 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
> > > > > >     	/* Delete virtqueues and flush outstanding callbacks if any */
> > > > > >     	vdev->config->del_vqs(vdev);
> > > > > > +	/* Other works can be queued before 'config->del_vqs()', so we flush
> > > > > > +	 * all works before to free the vsock object to avoid use after free.
> > > > > > +	 */
> > > > > > +	virtio_vsock_flush_works(vsock);
> > > > > Some questions after a quick glance:
> > > > > 
> > > > > 1) It looks to me that the work could be queued from the path of
> > > > > vsock_transport_cancel_pkt() . Is that synchronized here?
> > > > > 
> > > > Both virtio_transport_send_pkt() and vsock_transport_cancel_pkt() can
> > > > queue work from the upper layer (socket).
> > > > 
> > > > Setting the_virtio_vsock to NULL, should synchronize, but after a careful look
> > > > a rare issue could happen:
> > > > we are setting the_virtio_vsock to NULL at the start of .remove() and we
> > > > are freeing the object pointed by it at the end of .remove(), so
> > > > virtio_transport_send_pkt() or vsock_transport_cancel_pkt() may still be
> > > > running, accessing the object that we are freed.
> > > 
> > > Yes, that's my point.
> > > 
> > > 
> > > > Should I use something like RCU to prevent this issue?
> > > > 
> > > >       virtio_transport_send_pkt() and vsock_transport_cancel_pkt()
> > > >       {
> > > >           rcu_read_lock();
> > > >           vsock = rcu_dereference(the_virtio_vsock_mutex);
> > > 
> > > RCU is probably a way to go. (Like what vhost_transport_send_pkt() did).
> > > 
> > Okay, I'm going this way.
> > 
> > > >           ...
> > > >           rcu_read_unlock();
> > > >       }
> > > > 
> > > >       virtio_vsock_remove()
> > > >       {
> > > >           rcu_assign_pointer(the_virtio_vsock_mutex, NULL);
> > > >           synchronize_rcu();
> > > > 
> > > >           ...
> > > > 
> > > >           free(vsock);
> > > >       }
> > > > 
> > > > Could there be a better approach?
> > > > 
> > > > 
> > > > > 2) If we decide to flush after dev_vqs(), is tx_run/rx_run/event_run still
> > > > > needed? It looks to me we've already done except that we need flush rx_work
> > > > > in the end since send_pkt_work can requeue rx_work.
> > > > The main reason of tx_run/rx_run/event_run is to prevent that a worker
> > > > function is running while we are calling config->reset().
> > > > 
> > > > E.g. if an interrupt comes between virtio_vsock_flush_works() and
> > > > config->reset(), it can queue new works that can access the device while
> > > > we are in config->reset().
> > > > 
> > > > IMHO they are still needed.
> > > > 
> > > > What do you think?
> > > 
> > > I mean could we simply do flush after reset once and without tx_rx/rx_run
> > > tricks?
> > > 
> > > rest();
> > > 
> > > virtio_vsock_flush_work();
> > > 
> > > virtio_vsock_free_buf();
> > My only doubt is:
> > is it safe to call config->reset() while a worker function could access
> > the device?
> > 
> > I had this doubt reading the Michael's advice[1] and looking at
> > virtnet_remove() where there are these lines before the config->reset():
> > 
> > 	/* Make sure no work handler is accessing the device. */
> > 	flush_work(&vi->config_work);
> > 
> > Thanks,
> > Stefano
> > 
> > [1] https://lore.kernel.org/netdev/20190521055650-mutt-send-email-mst@kernel.org
> 
> 
> Good point. Then I agree with you. But if we can use the RCU to detect the
> detach of device from socket for these, it would be even better.
> 

What about checking 'the_virtio_vsock' in the worker functions in a RCU
critical section?
In this way, I can remove the rx_run/tx_run/event_run.

Do you think it's cleaner?

Thank you very much,
Stefano
