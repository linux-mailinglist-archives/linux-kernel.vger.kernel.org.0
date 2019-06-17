Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05690485B0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfFQOjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 10:39:04 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:45608 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFQOjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:39:04 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id Rqf2200033XaVaC01qf2aq; Mon, 17 Jun 2019 16:39:02 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsmk-0002K6-1K; Mon, 17 Jun 2019 16:39:02 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsmj-0001NB-VK; Mon, 17 Jun 2019 16:39:01 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] parport: Add missing newline at end of file
Date:   Mon, 17 Jun 2019 16:39:01 +0200
Message-Id: <20190617143901.5228-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"git diff" says:

    \ No newline at end of file

after modifying the file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/parport/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/Makefile b/drivers/parport/Makefile
index 6fa41f8173b63e74..022c566c0f327713 100644
--- a/drivers/parport/Makefile
+++ b/drivers/parport/Makefile
@@ -19,4 +19,4 @@ obj-$(CONFIG_PARPORT_ATARI)	+= parport_atari.o
 obj-$(CONFIG_PARPORT_SUNBPP)	+= parport_sunbpp.o
 obj-$(CONFIG_PARPORT_GSC)	+= parport_gsc.o
 obj-$(CONFIG_PARPORT_AX88796)	+= parport_ax88796.o
-obj-$(CONFIG_PARPORT_IP32)	+= parport_ip32.o
\ No newline at end of file
+obj-$(CONFIG_PARPORT_IP32)	+= parport_ip32.o
-- 
2.17.1

