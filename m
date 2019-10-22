Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40299E036D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 13:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbfJVLwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 07:52:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48961 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388287AbfJVLwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 07:52:18 -0400
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iMshx-0004xI-QE; Tue, 22 Oct 2019 13:52:13 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: prima2: rstc: Make reset_control_ops const
Date:   Tue, 22 Oct 2019 13:52:13 +0200
Message-Id: <20191022115213.19501-1-p.zabel@pengutronix.de>
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

The sirfsoc_rstc_ops structure is never modified. Make it const.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-prima2/rstc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index 9d56606ac87f..1ee405e2dde9 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -53,7 +53,7 @@ static int sirfsoc_reset_module(struct reset_controller_dev *rcdev,
 	return 0;
 }
 
-static struct reset_control_ops sirfsoc_rstc_ops = {
+static const struct reset_control_ops sirfsoc_rstc_ops = {
 	.reset = sirfsoc_reset_module,
 };
 
-- 
2.20.1

