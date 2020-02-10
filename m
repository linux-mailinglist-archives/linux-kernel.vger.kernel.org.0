Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 744811571BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 10:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgBJJdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 04:33:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50468 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgBJJdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:33:40 -0500
Received: from zn.tnic (p200300EC2F05D4003DBA28C5722DFF0F.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:d400:3dba:28c5:722d:ff0f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 73B301EC0664;
        Mon, 10 Feb 2020 10:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581327219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=VCLFBh9D1PTtDNNjEMEWbYlkj1/32Dza49ERXlI5n9g=;
        b=P6KFzeJ0JTq6ZpM5f+2IP1m06wrA+7IS0Orbtn85J0bDnN9kVXMe1qfoUkkyJJ5Ld5aemo
        3oT0lTFbEaCuT1TVZsS2EckT1o3j36qtdgQO7NWcW0XOSxmvNAkYwv5HOei0BTUwtlwtTk
        LLLVv5yp2VVX3oALeHdL2w+Al5ZKeFo=
From:   Borislav Petkov <bp@alien8.de>
To:     virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH] virtio_balloon: Fix unused label warning
Date:   Mon, 10 Feb 2020 10:33:28 +0100
Message-Id: <20200210093328.15349-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Fix

  drivers/virtio/virtio_balloon.c: In function ‘virtballoon_probe’:
  drivers/virtio/virtio_balloon.c:963:1: warning: label ‘out_del_vqs’ defined but not used [-Wunused-label]
    963 | out_del_vqs:
        | ^~

The CONFIG_BALLOON_COMPACTION ifdeffery should enclose it too.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7bfe365d9372..b6ed5f8bccb1 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -959,9 +959,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	iput(vb->vb_dev_info.inode);
 out_kern_unmount:
 	kern_unmount(balloon_mnt);
-#endif
 out_del_vqs:
 	vdev->config->del_vqs(vdev);
+#endif
 out_free_vb:
 	kfree(vb);
 out:
-- 
2.21.0

