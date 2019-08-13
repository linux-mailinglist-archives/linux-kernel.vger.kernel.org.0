Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A220A8BB1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 16:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfHMOFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 10:05:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbfHMOFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:05:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A965308FC22;
        Tue, 13 Aug 2019 14:05:39 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (unknown [10.65.16.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 799926092F;
        Tue, 13 Aug 2019 14:05:36 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     mst@redhat.com, amit@kernel.org
Cc:     virtualization@lists.linux-foundation.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, pagupta@redhat.com
Subject: [PATCH v4 1/2] virtio: decrement avail idx with buffer detach for packed ring
Date:   Tue, 13 Aug 2019 19:35:28 +0530
Message-Id: <20190813140529.12939-2-pagupta@redhat.com>
In-Reply-To: <20190813140529.12939-1-pagupta@redhat.com>
References: <20190813140529.12939-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 13 Aug 2019 14:05:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch decrements 'next_avail_idx' count when detaching a buffer
from vq for packed ring code. Split ring code already does this in
virtqueue_detach_unused_buf_split function. This updates the
'next_avail_idx' to the previous correct index after an unused buffer
is detatched from the vq.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/virtio/virtio_ring.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c8be1c4f5b55..7c69181113e2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1537,6 +1537,12 @@ static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
 		/* detach_buf clears data, so grab it now. */
 		buf = vq->packed.desc_state[i].data;
 		detach_buf_packed(vq, i, NULL);
+		vq->packed.next_avail_idx--;
+		if (vq->packed.next_avail_idx < 0) {
+			vq->packed.next_avail_idx = vq->packed.vring.num - 1;
+			vq->packed.avail_wrap_counter ^= 1;
+		}
+
 		END_USE(vq);
 		return buf;
 	}
-- 
2.20.1

