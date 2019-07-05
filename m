Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 228E05FD75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 21:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfGDTeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 15:34:01 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:40758 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbfGDTeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 15:34:00 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 40CC81538A; Thu,  4 Jul 2019 20:33:59 +0100 (BST)
From:   Mans Rullgard <mans@mansr.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] auxdisplay: charlcd: add help text for backlight initial state
Date:   Thu,  4 Jul 2019 20:33:54 +0100
Message-Id: <20190704193354.31617-1-mans@mansr.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the individual CHARLCD_BL_xxx options have help texts, the
menu itself does not.  Fix this.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/auxdisplay/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index c52c738e554a..62bf0ef6ede8 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -448,6 +448,8 @@ config PANEL_BOOT_MESSAGE
 choice
 	prompt "Backlight initial state"
 	default CHARLCD_BL_FLASH
+	---help---
+	  Select the initial backlight state on boot or module load.
 
 	config CHARLCD_BL_OFF
 		bool "Off"
-- 
2.22.0

