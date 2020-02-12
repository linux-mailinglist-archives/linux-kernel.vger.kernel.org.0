Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7756415A5DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 11:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgBLKMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 05:12:32 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:40476 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgBLKMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:12:32 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id 1mCW220015USYZQ01mCWoT; Wed, 12 Feb 2020 11:12:30 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1p0Q-0001JH-06; Wed, 12 Feb 2020 11:12:30 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1p0P-0001j0-Ug; Wed, 12 Feb 2020 11:12:29 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] microblaze: Replace <linux/clk-provider.h> by <linux/of_clk.h>
Date:   Wed, 12 Feb 2020 11:12:29 +0100
Message-Id: <20200212101229.6165-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MicroBlaze platform code is not a clock provider, and just needs to
call of_clk_init().

Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/microblaze/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index 511c1ab7f57f573c..96dbfa12b14719bc 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/init.h>
-#include <linux/clk-provider.h>
+#include <linux/of_clk.h>
 #include <linux/clocksource.h>
 #include <linux/string.h>
 #include <linux/seq_file.h>
-- 
2.17.1

