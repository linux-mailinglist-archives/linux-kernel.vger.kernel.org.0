Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FAA16EF87
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 21:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbgBYUBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 15:01:50 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:10403 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731214AbgBYUBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582660909; x=1614196909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=h4sGEbKL2BfyOYFPk4o3ZidZGMzs/+yLuzx6u+LWF+c=;
  b=OWRgrzRS7tSOKJfla87OKsmcDMLLYnNwp0HOu7dFAs+V6hrZK8cj2kxz
   PNn/dNAzUtGUA/EAZEz0OnV5bw07/x3sr+PqE6Bb+rQYFVLYEjhQ+/yeZ
   rDGFpf4fn4yUUOrhsSC8X9EI9p/LOoDNRwN+obPK1nVOyoSiQIjLgk7JD
   I=;
IronPort-SDR: PIcXLS6IdDwar29q1JwczS7BaXlePUp9+XEqqYnB09xUPN2199xfoVyhtsa8IMpr9vhSAd2a86
 jXf8ao08QJ1A==
X-IronPort-AV: E=Sophos;i="5.70,485,1574121600"; 
   d="scan'208";a="28822857"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 25 Feb 2020 20:01:46 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id CF115A06F1;
        Tue, 25 Feb 2020 20:01:42 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 20:01:42 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Feb 2020 20:01:41 +0000
Received: from localhost (10.2.75.237) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 25 Feb 2020 20:01:41 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <Chaitanya.Kulkarni@wdc.com>, <mst@redhat.com>,
        <jejb@linux.ibm.com>, <hch@lst.de>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v2 3/5] drivers/block/xen-blkfront.c: Convert to use set_capacity_revalidate_and_notify
Date:   Tue, 25 Feb 2020 20:01:27 +0000
Message-ID: <20200225200129.6687-4-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200225200129.6687-1-sblbir@amazon.com>
References: <20200225200129.6687-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

block/genhd provides set_capacity_revalidate_and_notify() for
sending RESIZE notifications via uevents.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/block/xen-blkfront.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index e2ad6bba2281..2f7cd842d6ce 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2335,7 +2335,6 @@ static void blkfront_connect(struct blkfront_info *info)
 	unsigned long sector_size;
 	unsigned int physical_sector_size;
 	unsigned int binfo;
-	char *envp[] = { "RESIZE=1", NULL };
 	int err, i;
 
 	switch (info->connected) {
@@ -2350,10 +2349,7 @@ static void blkfront_connect(struct blkfront_info *info)
 			return;
 		printk(KERN_INFO "Setting capacity to %Lu\n",
 		       sectors);
-		set_capacity(info->gd, sectors);
-		revalidate_disk(info->gd);
-		kobject_uevent_env(&disk_to_dev(info->gd)->kobj,
-				   KOBJ_CHANGE, envp);
+		set_capacity_revalidate_and_notify(info->gd, sectors, true);
 
 		return;
 	case BLKIF_STATE_SUSPENDED:
-- 
2.16.6

