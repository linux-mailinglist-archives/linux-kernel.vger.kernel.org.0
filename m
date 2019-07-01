Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64C1411940
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 14:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfEBMmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 08:42:00 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:52158 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfEBMl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:41:59 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 7Qhx2000N3XaVaC01QhxVQ; Thu, 02 May 2019 14:41:58 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hMB2D-0007gR-Sf; Thu, 02 May 2019 14:41:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hMB2D-00012o-Qf; Thu, 02 May 2019 14:41:57 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] of: irq: Remove WARN_ON() for kzalloc() failure
Date:   Thu,  2 May 2019 14:40:15 +0200
Message-Id: <20190502124015.3898-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to print a backtrace if kzalloc() fails, as the memory
allocation core already takes care of that.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/of/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index e1f6f392a4c0dde0..7f84bb4903caaf4d 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -500,7 +500,7 @@ void __init of_irq_init(const struct of_device_id *matches)
 		 * pointer, interrupt-parent device_node etc.
 		 */
 		desc = kzalloc(sizeof(*desc), GFP_KERNEL);
-		if (WARN_ON(!desc)) {
+		if (!desc) {
 			of_node_put(np);
 			goto err;
 		}
-- 
2.17.1

