Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF5718408C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 06:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCMFax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 01:30:53 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:46844 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgCMFav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 01:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584077452; x=1615613452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=cWa6Fn7t0zpgUPTzyy7cZ2J7YPrWlvJCca1owelSg8I=;
  b=JfyCqGN1VegCRjZkw4UzzRdKAEHGomObZcZR5vAyIy7gqvffafASP1Yw
   fLDefnavOMTGQJmSbE+6EgYRtume2f5rDnOrxRWwRA4RgkZ301agyQ3O7
   285/krbfIZJwMY90djluK1gs4vQLcDHFskc+IVAvk4J7B+pOTt2Io0DiO
   w=;
IronPort-SDR: Onar0HjUUCMoIfFoSNbSPUmwDc3OK7NGLvHV8VHla/RGs5aX9kzqgF29nvMi6nMozplWJTNQSV
 T9tZzeWVjXqw==
X-IronPort-AV: E=Sophos;i="5.70,547,1574121600"; 
   d="scan'208";a="21324228"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 13 Mar 2020 05:30:51 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id DB3E728338F;
        Fri, 13 Mar 2020 05:30:48 +0000 (UTC)
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Mar 2020 05:30:19 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d01UWA003.ant.amazon.com (10.43.160.107) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 13 Mar 2020 05:30:18 +0000
Received: from localhost (10.2.75.237) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 13 Mar 2020 05:30:18 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <Chaitanya.Kulkarni@wdc.com>, <hch@lst.de>,
        "Balbir Singh" <sblbir@amazon.com>
Subject: [PATCH v3 5/5] scsi: Convert to use set_capacity_revalidate_and_notify
Date:   Fri, 13 Mar 2020 05:30:09 +0000
Message-ID: <20200313053009.19866-6-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200313053009.19866-1-sblbir@amazon.com>
References: <20200313053009.19866-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

block/genhd provides set_capacity_revalidate_and_notify() for sending RESIZE
notifications via uevents. This notification is newly added to scsi sd.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/scsi/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 8ca9299ffd36..707f47c0ec98 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3187,7 +3187,8 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 	sdkp->first_scan = 0;
 
-	set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
+	set_capacity_revalidate_and_notify(disk,
+		logical_to_sectors(sdp, sdkp->capacity), false);
 	sd_config_write_same(sdkp);
 	kfree(buffer);
 
-- 
2.16.6

