Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C851AE3684
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503138AbfJXPYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 11:24:04 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:46564 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503066AbfJXPYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:24:03 -0400
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id HTQ12100F5USYZQ01TQ1aA; Thu, 24 Oct 2019 17:24:01 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNey1-00076Q-Bs; Thu, 24 Oct 2019 17:24:01 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNey1-0007px-9B; Thu, 24 Oct 2019 17:24:01 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] nvme-pci: Spelling s/resdicovered/rediscovered/
Date:   Thu, 24 Oct 2019 17:24:00 +0200
Message-Id: <20191024152400.30082-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspelling of "rediscovered".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 869f462e6b6ea01c..dd4a2ce85e872cd0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2982,7 +2982,7 @@ static int nvme_suspend(struct device *dev)
 
 		/*
 		 * Clearing npss forces a controller reset on resume. The
-		 * correct value will be resdicovered then.
+		 * correct value will be rediscovered then.
 		 */
 		ret = nvme_disable_prepare_reset(ndev, true);
 		ctrl->npss = 0;
-- 
2.17.1

