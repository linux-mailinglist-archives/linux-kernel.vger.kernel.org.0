Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E783B17BAD8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 11:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgCFKzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 05:55:41 -0500
Received: from foss.arm.com ([217.140.110.172]:59588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgCFKzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:55:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2A7431B;
        Fri,  6 Mar 2020 02:55:40 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E648F3F6C4;
        Fri,  6 Mar 2020 02:55:39 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH] drivers: virtio: Make out_del_vqs dependent on BALLOON_COMPACTION
Date:   Fri,  6 Mar 2020 10:55:28 +0000
Message-Id: <20200306105528.5272-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

out_del_vqs label is currently used only when BALLOON_COMPACTION
configuration option is enabled. Having it disabled triggers the
following warning at compile time:

drivers/virtio/virtio_balloon.c: In function ‘virtballoon_probe’:
drivers/virtio/virtio_balloon.c:963:1: warning: label ‘out_del_vqs’
defined but not used [-Wunused-label]
  963 | out_del_vqs:
      | ^~~~~~~~~~~

Make out_del_vqs dependent on BALLOON_COMPACTION to address the
issue.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7bfe365d9372..341458fd95ca 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -959,8 +959,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	iput(vb->vb_dev_info.inode);
 out_kern_unmount:
 	kern_unmount(balloon_mnt);
-#endif
 out_del_vqs:
+#endif
 	vdev->config->del_vqs(vdev);
 out_free_vb:
 	kfree(vb);
-- 
2.25.1

