Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 942B2DD0D3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 23:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406398AbfJRVFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 17:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406201AbfJRVFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 17:05:06 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A130820869
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 21:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571432705;
        bh=gVcqcmiIDnqoMZaTTSiiW5uXIzEgvd+75fvXmzDPO7U=;
        h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
         References:In-Reply-To:From;
        b=hT+v61Jl2GdqX9yqY0JEY8doQw96Z+0Cp2mj6CQKJ2AkcAZd3zJD34Ypnownxp6w0
         Isr1NS+5q+DRAa4BOEqKjbVIBPBG9XbCv29GB91y/Kc8nXGetUuBABtgq0LhBilgFN
         5j5e9mkjWOR5hLYS/84p7FYSyhFAVEVpnO7cS+bQ=
Date:   Fri, 18 Oct 2019 21:58:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@lists.infradead.org, paulmck@kernel.org,
        peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: read_barrier_depends() usage in vhost.c
Message-ID: <20191018205814.nbawp3btlpr5p2rf@willie-the-truck>
References: <20191016233340.djrr7o7dwueqccac@willie-the-truck>
 <2429dbbc-ec80-3a76-82ff-481c0523f68a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2429dbbc-ec80-3a76-82ff-481c0523f68a@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:17:18AM +0800, Jason Wang wrote:
> On 2019/10/17 上午7:33, Will Deacon wrote:
> > In an attempt to remove the remaining traces of [smp_]read_barrier_depends()
> > following my previous patches to strengthen READ_ONCE() for Alpha [1], I
> > ended up trying to decipher the read_barrier_depends() usage in the vhost
> > driver:
> > 
> > --->8
> > 
> > // drivers/vhost/vhost.c
> > static int get_indirect(struct vhost_virtqueue *vq,
> > 			struct iovec iov[], unsigned int iov_size,
> > 			unsigned int *out_num, unsigned int *in_num,
> > 			struct vhost_log *log, unsigned int *log_num,
> > 			struct vring_desc *indirect)
> > {
> > 	[...]
> > 
> > 	/* We will use the result as an address to read from, so most
> > 	 * architectures only need a compiler barrier here. */
> > 	read_barrier_depends();
> > 
> > --->8
> > 
> > Unfortunately, although the barrier is commented (hurrah!), it's not
> > particularly enlightening about the accesses making up the dependency
> > chain, and I don't understand the supposed need for a compiler barrier
> > either (read_barrier_depends() doesn't generally provide this).
> > 
> > Does anybody know which accesses are being ordered here? Usually you'd need
> > a READ_ONCE()/rcu_dereference() beginning the chain, but I haven't managed
> > to find one...
> > 
> 
> I guess it was because we will read from the address stored in the iov like:
> 
> 1) trasnlate_desc() that stores the userspace buffer pointer in the iov
> 
> 2) copy_from_iter() that reads from those pointers

Isn't that exactly the same flow as vhost_copy_from_user(), which doesn't
have the barrier? Staring at the code some more, my best bet at the moment
is that the load of 'indirect->addr' is probably the one to worry about,
since it's part of the vring and can be updated concurrently.

> So we need a data dependency barrier in the middle as explained in the
> memory-barriers.txt? (since READ_ONCE is not used in iov iterator).

If the barrier is actually required, then there must be a concurrent access
involved, in which case READ_ONCE should also be used. So I would propose
something like the diff below, but I'd still be glad to hear whether I'm
barking up the wrong tree.

Will

--->8

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 36ca2cf419bf..2e370a229fea 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2107,6 +2107,7 @@ static int get_indirect(struct vhost_virtqueue *vq,
 {
 	struct vring_desc desc;
 	unsigned int i = 0, count, found = 0;
+	__virtio64 addr = READ_ONCE(indirect->addr);
 	u32 len = vhost32_to_cpu(vq, indirect->len);
 	struct iov_iter from;
 	int ret, access;
@@ -2120,7 +2121,7 @@ static int get_indirect(struct vhost_virtqueue *vq,
 		return -EINVAL;
 	}
 
-	ret = translate_desc(vq, vhost64_to_cpu(vq, indirect->addr), len, vq->indirect,
+	ret = translate_desc(vq, vhost64_to_cpu(vq, addr), len, vq->indirect,
 			     UIO_MAXIOV, VHOST_ACCESS_RO);
 	if (unlikely(ret < 0)) {
 		if (ret != -EAGAIN)
@@ -2129,10 +2130,6 @@ static int get_indirect(struct vhost_virtqueue *vq,
 	}
 	iov_iter_init(&from, READ, vq->indirect, ret, len);
 
-	/* We will use the result as an address to read from, so most
-	 * architectures only need a compiler barrier here. */
-	read_barrier_depends();
-
 	count = len / sizeof desc;
 	/* Buffers are chained via a 16 bit next field, so
 	 * we can have at most 2^16 of these. */
@@ -2152,12 +2149,12 @@ static int get_indirect(struct vhost_virtqueue *vq,
 		}
 		if (unlikely(!copy_from_iter_full(&desc, sizeof(desc), &from))) {
 			vq_err(vq, "Failed indirect descriptor: idx %d, %zx\n",
-			       i, (size_t)vhost64_to_cpu(vq, indirect->addr) + i * sizeof desc);
+			       i, (size_t)vhost64_to_cpu(vq, addr) + i * sizeof desc);
 			return -EINVAL;
 		}
 		if (unlikely(desc.flags & cpu_to_vhost16(vq, VRING_DESC_F_INDIRECT))) {
 			vq_err(vq, "Nested indirect descriptor: idx %d, %zx\n",
-			       i, (size_t)vhost64_to_cpu(vq, indirect->addr) + i * sizeof desc);
+			       i, (size_t)vhost64_to_cpu(vq, addr) + i * sizeof desc);
 			return -EINVAL;
 		}
 
