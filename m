Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C0918224E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 20:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbgCKTaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 15:30:23 -0400
Received: from haggis.mythic-beasts.com ([46.235.224.141]:38709 "EHLO
        haggis.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbgCKTaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:30:23 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Mar 2020 15:30:22 EDT
Received: from 204.33.90.146.dyn.plus.net ([146.90.33.204]:54428 helo=slartibartfast.quignogs.org.uk)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <peter@bikeshed.quignogs.org.uk>)
        id 1jC6wY-0008RB-Vy; Wed, 11 Mar 2020 19:23:03 +0000
From:   peter@bikeshed.quignogs.org.uk
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Lister <peter@bikeshed.quignogs.org.uk>
Subject: [PATCH 1/1] Added double colons and blank lines within kerneldoc to format code snippets as ReST literal blocks.
Date:   Wed, 11 Mar 2020 19:22:56 +0000
Message-Id: <20200311192256.15911-2-peter@bikeshed.quignogs.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200311192256.15911-1-peter@bikeshed.quignogs.org.uk>
References: <20200311192256.15911-1-peter@bikeshed.quignogs.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BlackCat-Spam-Score: 50
X-Spam-Status: No, score=5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Lister <peter@bikeshed.quignogs.org.uk>

This removes the following warnings from the kernel doc build...
./drivers/base/platform.c:134: WARNING: Unexpected indentation.
./drivers/base/platform.c:213: WARNING: Unexpected indentation.

Signed-off-by: Peter Lister <peter@bikeshed.quignogs.org.uk>
---
 drivers/base/platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 7fa654f1288b..7fb5cf847253 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -128,7 +128,8 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
  * request_irq() APIs. This is the same as platform_get_irq(), except that it
  * does not print an error message if an IRQ can not be obtained.
  *
- * Example:
+ * Example: ::
+ *
  *		int irq = platform_get_irq_optional(pdev, 0);
  *		if (irq < 0)
  *			return irq;
@@ -207,7 +208,8 @@ EXPORT_SYMBOL_GPL(platform_get_irq_optional);
  * IRQ fails. Device drivers should check the return value for errors so as to
  * not pass a negative integer value to the request_irq() APIs.
  *
- * Example:
+ * Example: ::
+ *
  *		int irq = platform_get_irq(pdev, 0);
  *		if (irq < 0)
  *			return irq;
-- 
2.24.1

