Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9977D1F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 01:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfGaXfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 19:35:42 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39848 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730791AbfGaXfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:35:41 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsy8B-0003W6-Ki; Wed, 31 Jul 2019 17:35:41 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsy89-0001Gz-S1; Wed, 31 Jul 2019 17:35:37 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 31 Jul 2019 17:35:33 -0600
Message-Id: <20190731233534.4841-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731233534.4841-1-logang@deltatee.com>
References: <20190731233534.4841-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me, chaitanya.kulkarni@wdc.com, maxg@mellanox.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v3 3/4] nvmet-file: fix nvmet_file_flush() always returning an error
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently, nvmet_file_flush() always returns a call to
errno_to_nvme_status() but that helper doesn't take into account the
case when errno=0. So nvmet_file_flush() always returns an error code.

All other callers of errno_to_nvme_status() check for success before
calling it.

To fix this, ensure errno_to_nvme_status() returns success if the
errno is zero. This should prevent future mistakes like this from
happening.

Fixes: c6aa3542e010 ("nvmet: add error log support for file backend")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b86a23aa9020..3a67e244e568 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -46,6 +46,9 @@ inline u16 errno_to_nvme_status(struct nvmet_req *req, int errno)
 	u16 status;
 
 	switch (errno) {
+	case 0:
+		status = NVME_SC_SUCCESS;
+		break;
 	case -ENOSPC:
 		req->error_loc = offsetof(struct nvme_rw_command, length);
 		status = NVME_SC_CAP_EXCEEDED | NVME_SC_DNR;
-- 
2.20.1

