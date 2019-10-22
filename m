Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8C2E08EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbfJVQbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:31:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41049 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbfJVQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:31:09 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iMx3r-0002hu-Uu; Tue, 22 Oct 2019 18:31:07 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH] reset: document (devm_)reset_control_get_optional variants
Date:   Tue, 22 Oct 2019 18:31:05 +0200
Message-Id: <20191022163105.18734-1-p.zabel@pengutronix.de>
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

Add kerneldoc comments for the optional reset_control_get variants.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 include/linux/reset.h | 46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index eb597e8aa430..df10703351a9 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -203,12 +203,34 @@ static inline struct reset_control *reset_control_get_shared(
 	return __reset_control_get(dev, id, 0, true, false, false);
 }
 
+/**
+ * reset_control_get_optional_exclusive - optional reset_control_get_exclusive()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Optional variant of reset_control_get_exclusive(). If the requested reset
+ * is not specified in the device tree, this function returns NULL instead of
+ * an error.
+ *
+ * See :c:func:`reset_control_get_exclusive` for more information.
+ */
 static inline struct reset_control *reset_control_get_optional_exclusive(
 					struct device *dev, const char *id)
 {
 	return __reset_control_get(dev, id, 0, false, true, true);
 }
 
+/**
+ * reset_control_get_optional_shared - optional reset_control_get_shared()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Optional variant of reset_control_get_shared(). If the requested reset
+ * is not specified in the device tree, this function returns NULL instead of
+ * an error.
+ *
+ * See :c:func:`reset_control_get_shared` for more information.
+ */
 static inline struct reset_control *reset_control_get_optional_shared(
 					struct device *dev, const char *id)
 {
@@ -354,12 +376,36 @@ static inline struct reset_control *devm_reset_control_get_shared(
 	return __devm_reset_control_get(dev, id, 0, true, false, false);
 }
 
+/**
+ * devm_reset_control_get_optional_exclusive - resource managed
+ *                                             reset_control_get_optional_exclusive()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Managed reset_control_get_optional_exclusive(). For reset controllers
+ * returned from this function, reset_control_put() is called automatically on
+ * driver detach.
+ *
+ * See :c:func:`reset_control_get_optional_exclusive` for more information.
+ */
 static inline struct reset_control *devm_reset_control_get_optional_exclusive(
 					struct device *dev, const char *id)
 {
 	return __devm_reset_control_get(dev, id, 0, false, true, true);
 }
 
+/**
+ * devm_reset_control_get_optional_shared - resource managed
+ *                                          reset_control_get_optional_shared()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Managed reset_control_get_optional_shared(). For reset controllers returned
+ * from this function, reset_control_put() is called automatically on driver
+ * detach.
+ *
+ * See :c:func:`reset_control_get_optional_shared` for more information.
+ */
 static inline struct reset_control *devm_reset_control_get_optional_shared(
 					struct device *dev, const char *id)
 {
-- 
2.20.1

