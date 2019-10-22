Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAFD7E08C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbfJVQ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:27:03 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33279 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731277AbfJVQ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:27:02 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iMwzt-00025E-Dd; Tue, 22 Oct 2019 18:27:01 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [PATCH] reset: fix of_reset_simple_xlate kerneldoc comment
Date:   Tue, 22 Oct 2019 18:27:00 +0200
Message-Id: <20191022162700.8060-1-p.zabel@pengutronix.de>
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

The flags parameter never made it into the API, but was erroneously
included in the kerneldoc comment. Remove it to fix a documentation
build warning:

  ./drivers/reset/core.c:86: warning: Excess function parameter 'flags' description in 'of_reset_simple_xlate'

Fixes: 61fc41317666 ("reset: Add reset controller API")
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 213ff40dda11..7c95cafcdf08 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -76,7 +76,6 @@ static const char *rcdev_name(struct reset_controller_dev *rcdev)
  * of_reset_simple_xlate - translate reset_spec to the reset line number
  * @rcdev: a pointer to the reset controller device
  * @reset_spec: reset line specifier as found in the device tree
- * @flags: a flags pointer to fill in (optional)
  *
  * This simple translation function should be used for reset controllers
  * with 1:1 mapping, where reset lines can be indexed by number without gaps.
-- 
2.20.1

