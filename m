Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A919D91904
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2019 20:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfHRSqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 14:46:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42688 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRSqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 14:46:52 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hzQCX-0007Vf-Po; Sun, 18 Aug 2019 18:46:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: remove redundant assignment to retval
Date:   Sun, 18 Aug 2019 19:46:49 +0100
Message-Id: <20190818184649.13828-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable retval is initialized to a value that is never read and it
is re-assigned later. The initialization is redundant and can be
removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rts5208/ms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
index 1128eec3bd08..e853fa9cc950 100644
--- a/drivers/staging/rts5208/ms.c
+++ b/drivers/staging/rts5208/ms.c
@@ -3842,7 +3842,7 @@ int mg_set_leaf_id(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 int mg_get_local_EKB(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 {
-	int retval = STATUS_FAIL;
+	int retval;
 	int bufflen;
 	unsigned int lun = SCSI_LUN(srb);
 	u8 *buf = NULL;
-- 
2.20.1

