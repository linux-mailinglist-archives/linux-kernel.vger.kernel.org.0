Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDE573F06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 22:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbfGXTdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 15:33:10 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:55668 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388227AbfGXTdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:33:05 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from asmaa@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 24 Jul 2019 22:33:03 +0300
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x6OJX1lD016753;
        Wed, 24 Jul 2019 15:33:01 -0400
Received: (from asmaa@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x6OJX1NR010431;
        Wed, 24 Jul 2019 15:33:01 -0400
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     minyard@acm.org
Cc:     Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org,
        asmaa@mellanox.com
Subject: [PATCH v1 1/1] Fix uninitialized variable in ipmb_dev_int.c
Date:   Wed, 24 Jul 2019 15:32:57 -0400
Message-Id: <571dbb67cf58411d567953d9fb3739eb4789238b.1563996586.git.Asmaa@mellanox.com>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <cover.1563996586.git.Asmaa@mellanox.com>
References: <cover.1563996586.git.Asmaa@mellanox.com>
In-Reply-To: <cover.1563996586.git.Asmaa@mellanox.com>
References: <cover.1563996586.git.Asmaa@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret at line 112 of ipmb_dev_int.c is uninitialized which
results in a warning during build regressions.
This warning was found by build regression/improvement
testing for v5.3-rc1.

Reported-by: build regression/improvement testing for v5.3-rc1.
Fixes: 51bd6f291583 ("Add support for IPMB driver")
Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>
---
 drivers/char/ipmi/ipmb_dev_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index 5720433..285e0b8 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -76,7 +76,7 @@ static ssize_t ipmb_read(struct file *file, char __user *buf, size_t count,
 	struct ipmb_dev *ipmb_dev = to_ipmb_dev(file);
 	struct ipmb_request_elem *queue_elem;
 	struct ipmb_msg msg;
-	ssize_t ret;
+	ssize_t ret = 0;
 
 	memset(&msg, 0, sizeof(msg));
 
-- 
2.1.2

