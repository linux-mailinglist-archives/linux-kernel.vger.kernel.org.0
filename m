Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53B215A60D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 11:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgBLKQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 05:16:55 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:44784 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgBLKQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:16:54 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id 1mGs2200R5USYZQ01mGskR; Wed, 12 Feb 2020 11:16:53 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1p4e-0001NS-Gp; Wed, 12 Feb 2020 11:16:52 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1p4e-0002M5-FI; Wed, 12 Feb 2020 11:16:52 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] nds32: Replace <linux/clk-provider.h> by <linux/of_clk.h>
Date:   Wed, 12 Feb 2020 11:16:51 +0100
Message-Id: <20200212101651.9010-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Andes platform code is not a clock provider, and just needs to call
of_clk_init().

Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/nds32/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/time.c b/arch/nds32/kernel/time.c
index ac9d78ce3a818926..574a3d0a853980a9 100644
--- a/arch/nds32/kernel/time.c
+++ b/arch/nds32/kernel/time.c
@@ -2,7 +2,7 @@
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
 #include <linux/clocksource.h>
-#include <linux/clk-provider.h>
+#include <linux/of_clk.h>
 
 void __init time_init(void)
 {
-- 
2.17.1

