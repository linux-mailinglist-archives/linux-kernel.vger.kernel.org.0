Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D60F05F620
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfGDJ5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 05:57:13 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:20621 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfGDJ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:57:12 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5d1dcd67ee3-c95f7; Thu, 04 Jul 2019 17:56:56 +0800 (CST)
X-RM-TRANSID: 2eeb5d1dcd67ee3-c95f7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45d1dcd67f95-a5dd7;
        Thu, 04 Jul 2019 17:56:55 +0800 (CST)
X-RM-TRANSID: 2ee45d1dcd67f95-a5dd7
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: Remove unreachable code
Date:   Thu,  4 Jul 2019 17:55:56 +0800
Message-Id: <1562234156-11945-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return code after switch default is unreachable,
so remove it.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/scsi/scsi_error.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index bfa569f..12180f0 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1909,7 +1909,6 @@ int scsi_decide_disposition(struct scsi_cmnd *scmd)
 	default:
 		return FAILED;
 	}
-	return FAILED;
 
 maybe_retry:
 
-- 
1.9.1



