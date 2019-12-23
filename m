Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D196A1290B6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 02:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLWBlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Dec 2019 20:41:22 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:59995 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfLWBlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 20:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577065281; x=1608601281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=bFqvuHtUJ2uTuBGE5u3MI0p2QpGGNs+AUqkx0RpdLvY=;
  b=aonEdzgdAY43aq2ejaICq1GPsVEWF8g6Oo7qe85toG2yWjL5gCLfrQly
   H5QrWg5LAmtB32BIDpoPQrmsqPSpjDn8uDWE6gxX4voYMhMl32bXz91KB
   AxrmGDpVHP/O/YTsuMTNxSoZp0sZZ0f+PLNDd8/7r27OosfEeW4twYxIK
   c=;
IronPort-SDR: BmUYN/KT4CukTWURlMR5RKt7lUs2YeLprQarmys0dgraudtB9gaGwwvDTxZdiHF5m0Wva254iV
 QviiXeeUmMGg==
X-IronPort-AV: E=Sophos;i="5.69,345,1571702400"; 
   d="scan'208";a="9641953"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 23 Dec 2019 01:41:20 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id EB2B8A22BC;
        Mon, 23 Dec 2019 01:41:16 +0000 (UTC)
Received: from EX13D11UWC001.ant.amazon.com (10.43.162.151) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Dec 2019 01:41:16 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D11UWC001.ant.amazon.com (10.43.162.151) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Dec 2019 01:41:15 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 23 Dec 2019 01:41:14 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <=linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <mst@redhat.com>, <jejb@linux.ibm.com>,
        <hch@lst.de>, <ssomesh@amazon.com>,
        Balbir Singh <sblbir@amazon.com>
Subject: [RFC PATCH 2/5] drivers/block/virtio_blk.c: Convert to use disk_set_capacity
Date:   Mon, 23 Dec 2019 01:40:53 +0000
Message-ID: <20191223014056.17318-2-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.5
In-Reply-To: <20191223014056.17318-1-sblbir@amazon.com>
References: <20191223014056.17318-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

block/genhd provides disk_set_capacity() for sending
RESIZE notifications via uevents.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/block/virtio_blk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index fbbf18ac1d5d..9848c94a7eb4 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -479,18 +479,16 @@ static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
 		   cap_str_10,
 		   cap_str_2);
 
-	set_capacity(vblk->disk, capacity);
+	disk_set_capacity(vblk->disk, capacity);
 }
 
 static void virtblk_config_changed_work(struct work_struct *work)
 {
 	struct virtio_blk *vblk =
 		container_of(work, struct virtio_blk, config_work);
-	char *envp[] = { "RESIZE=1", NULL };
 
 	virtblk_update_capacity(vblk, true);
 	revalidate_disk(vblk->disk);
-	kobject_uevent_env(&disk_to_dev(vblk->disk)->kobj, KOBJ_CHANGE, envp);
 }
 
 static void virtblk_config_changed(struct virtio_device *vdev)
-- 
2.16.5

