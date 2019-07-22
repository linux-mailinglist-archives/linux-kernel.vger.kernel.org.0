Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01ADC70B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 23:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbfGVVhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 17:37:25 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:56641 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfGVVhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:37:24 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d78 with ME
        id fxdM200024n7eLC03xdMiE; Mon, 22 Jul 2019 23:37:22 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 22 Jul 2019 23:37:22 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     nsekhar@ti.com, bgolaszewski@baylibre.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ARM: davinci: dm646x: Fix a typo in the comment
Date:   Mon, 22 Jul 2019 23:36:57 +0200
Message-Id: <20190722213657.27175-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is dedicated to DM646x. So update the description in the top
most comment accordingly.

It must have been derived from dm644x.c, but looks DM646 speecific now.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/arm/mach-davinci/dm646x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 62ca952fe161..4c58510e5792 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -1,5 +1,5 @@
 /*
- * TI DaVinci DM644x chip specific setup
+ * TI DaVinci DM646x chip specific setup
  *
  * Author: Kevin Hilman, Deep Root Systems, LLC
  *
-- 
2.20.1

