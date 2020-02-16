Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C562160397
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 11:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgBPKep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 05:34:45 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:59378 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgBPKep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 05:34:45 -0500
Received: from localhost.localdomain ([93.22.36.246])
        by mwinf5d13 with ME
        id 3Nag220045JeL2d03NaghB; Sun, 16 Feb 2020 11:34:43 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Feb 2020 11:34:43 +0100
X-ME-IP: 93.22.36.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dvhart@infradead.org, andy@infradead.org,
        mchehab+samsung@kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, ayman.bagabas@gmail.com,
        srinivas.pandruvada@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] platform/x86: Kconfig: Fix a typo
Date:   Sun, 16 Feb 2020 11:34:37 +0100
Message-Id: <20200216103437.19500-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'paramaters' should be 'parameters'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 664ead09c7fb..ae75b19e8649 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1213,7 +1213,7 @@ config INTEL_RST
         tristate "Intel Rapid Start Technology Driver"
 	depends on ACPI
 	---help---
-	  This driver provides support for modifying paramaters on systems
+	  This driver provides support for modifying parameters on systems
 	  equipped with Intel's Rapid Start Technology. When put in an ACPI
 	  sleep state, these devices will wake after either a configured
 	  timeout or when the system battery reaches a critical state,
-- 
2.20.1

