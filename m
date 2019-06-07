Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F673891B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 13:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfFGLe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 07:34:28 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:39280 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfFGLe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:34:28 -0400
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id MnaT2000A3XaVaC06naT9n; Fri, 07 Jun 2019 13:34:27 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD8d-0004Fo-1q; Fri, 07 Jun 2019 13:34:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD8d-0003te-0m; Fri, 07 Jun 2019 13:34:27 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] scsi: isci: Grammar s/the its/its/
Date:   Fri,  7 Jun 2019 13:34:26 +0200
Message-Id: <20190607113426.14937-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/scsi/isci/request.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index 1b18cf55167e0a2e..c552b4b59717ae9b 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -224,7 +224,7 @@ static void scu_ssp_request_construct_task_context(
 	idev = ireq->target_device;
 	iport = idev->owning_port;
 
-	/* Fill in the TC with the its required data */
+	/* Fill in the TC with its required data */
 	task_context->abort = 0;
 	task_context->priority = 0;
 	task_context->initiator_request = 1;
@@ -506,7 +506,7 @@ static void scu_sata_request_construct_task_context(
 	idev = ireq->target_device;
 	iport = idev->owning_port;
 
-	/* Fill in the TC with the its required data */
+	/* Fill in the TC with its required data */
 	task_context->abort = 0;
 	task_context->priority = SCU_TASK_PRIORITY_NORMAL;
 	task_context->initiator_request = 1;
@@ -3235,7 +3235,7 @@ sci_io_request_construct_smp(struct device *dev,
 	iport = idev->owning_port;
 
 	/*
-	 * Fill in the TC with the its required data
+	 * Fill in the TC with its required data
 	 * 00h
 	 */
 	task_context->priority = 0;
-- 
2.17.1

