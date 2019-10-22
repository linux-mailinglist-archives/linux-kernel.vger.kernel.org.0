Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1741DE037C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 13:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388908AbfJVLzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 07:55:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57269 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388801AbfJVLzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 07:55:21 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iMskx-0005RP-Nr; Tue, 22 Oct 2019 13:55:19 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>, kernel@pengutronix.de
Subject: [PATCH] reset: zynqmp: Make reset_control_ops const
Date:   Tue, 22 Oct 2019 13:55:17 +0200
Message-Id: <20191022115517.19886-1-p.zabel@pengutronix.de>
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

The zynqmp_reset_ops structure is never modified. Make it const.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index 99e75d92dada..0144075b11a6 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -64,7 +64,7 @@ static int zynqmp_reset_reset(struct reset_controller_dev *rcdev,
 					    PM_RESET_ACTION_PULSE);
 }
 
-static struct reset_control_ops zynqmp_reset_ops = {
+static const struct reset_control_ops zynqmp_reset_ops = {
 	.reset = zynqmp_reset_reset,
 	.assert = zynqmp_reset_assert,
 	.deassert = zynqmp_reset_deassert,
-- 
2.20.1

