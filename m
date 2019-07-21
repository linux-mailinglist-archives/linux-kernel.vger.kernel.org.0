Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2666A6F435
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 18:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfGUQwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 12:52:12 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:49199 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfGUQwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 12:52:11 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d01 with ME
        id fUs72000e4n7eLC03Us8GN; Sun, 21 Jul 2019 18:52:09 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2019 18:52:09 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     tony.luck@intel.com, fenghua.yu@intel.com, david@redhat.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ia64: perfmon: Fix a typo
Date:   Sun, 21 Jul 2019 18:51:44 +0200
Message-Id: <20190721165144.3152-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/permfon.h/perfmon.h/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The reference to perfmon.h should maybe be just removed because I've found
no information about the increasing order to respect.
This is maybe now in another file?
---
 arch/ia64/kernel/perfmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index 58a6337c0690..22795b420b10 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -4550,7 +4550,7 @@ pfm_exit_thread(struct task_struct *task)
 }
 
 /*
- * functions MUST be listed in the increasing order of their index (see permfon.h)
+ * functions MUST be listed in the increasing order of their index (see perfmon.h)
  */
 #define PFM_CMD(name, flags, arg_count, arg_type, getsz) { name, #name, flags, arg_count, sizeof(arg_type), getsz }
 #define PFM_CMD_S(name, flags) { name, #name, flags, 0, 0, NULL }
-- 
2.20.1

