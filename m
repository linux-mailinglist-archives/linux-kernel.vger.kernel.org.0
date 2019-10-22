Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E2CE08E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389408AbfJVQac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:30:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50133 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbfJVQab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:30:31 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iMx3F-0002Yx-Mr; Tue, 22 Oct 2019 18:30:29 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH] reset: improve of_xlate documentation
Date:   Tue, 22 Oct 2019 18:30:24 +0200
Message-Id: <20191022163024.17005-1-p.zabel@pengutronix.de>
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

Mention of_reset_simple_xlate as the default if of_xlate is not set.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/core.c             | 6 ++++--
 include/linux/reset-controller.h | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 660e0b07feca..3066f12f70db 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -77,8 +77,10 @@ static const char *rcdev_name(struct reset_controller_dev *rcdev)
  * @rcdev: a pointer to the reset controller device
  * @reset_spec: reset line specifier as found in the device tree
  *
- * This simple translation function should be used for reset controllers
- * with 1:1 mapping, where reset lines can be indexed by number without gaps.
+ * This static translation function is be used by default if of_xlate in
+ * :c:type:`reset_controller_dev` is not set. It is useful for all reset
+ * controllers with 1:1 mapping, where reset lines can be indexed by number
+ * without gaps.
  */
 static int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
 			  const struct of_phandle_args *reset_spec)
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index 984f625d5593..c53626c07e87 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -62,7 +62,8 @@ struct reset_control_lookup {
  * @of_node: corresponding device tree node as phandle target
  * @of_reset_n_cells: number of cells in reset line specifiers
  * @of_xlate: translation function to translate from specifier as found in the
- *            device tree to id as given to the reset control ops
+ *            device tree to id as given to the reset control ops, defaults
+ *            to :c:func:`of_reset_simple_xlate`.
  * @nr_resets: number of reset controls in this reset controller device
  */
 struct reset_controller_dev {
-- 
2.20.1

