Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30651E08DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732681AbfJVQ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:29:38 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33627 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731277AbfJVQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:29:37 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iMx2O-0002PK-LJ; Tue, 22 Oct 2019 18:29:36 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, kernel@pengutronix.de
Subject: [PATCH] reset: fix reset_control_get_exclusive kerneldoc comment
Date:   Tue, 22 Oct 2019 18:29:36 +0200
Message-Id: <20191022162936.15234-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing parentheses to correctly hyperlink the reference to
reset_control_get_shared().

Fixes: 0b52297f2288 ("reset: Add support for shared reset controls")
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 include/linux/reset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index e7793fc0fa93..eb597e8aa430 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -143,7 +143,7 @@ static inline int device_reset_optional(struct device *dev)
  * If this function is called more than once for the same reset_control it will
  * return -EBUSY.
  *
- * See reset_control_get_shared for details on shared references to
+ * See reset_control_get_shared() for details on shared references to
  * reset-controls.
  *
  * Use of id names is optional.
-- 
2.20.1

