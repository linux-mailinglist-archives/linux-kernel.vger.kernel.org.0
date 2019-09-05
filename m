Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2C9AAC2C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 21:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391338AbfIETog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 15:44:36 -0400
Received: from fieldses.org ([173.255.197.46]:56694 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389301AbfIETof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:44:35 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id B444114DA; Thu,  5 Sep 2019 15:44:34 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/9] thunderbolt: show key using %*s not %*pE
Date:   Thu,  5 Sep 2019 15:44:26 -0400
Message-Id: <1567712673-1629-2-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567712673-1629-1-git-send-email-bfields@redhat.com>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

%*pEp (without "h" or "o") is a no-op.  This string could contain
arbitrary (non-NULL) characters, so we do want escaping.  Use %*pE like
every other caller.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 drivers/thunderbolt/xdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 5118d46702d5..4e17a7c7bf0a 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -636,7 +636,7 @@ static ssize_t key_show(struct device *dev, struct device_attribute *attr,
 	 * It should be null terminated but anything else is pretty much
 	 * allowed.
 	 */
-	return sprintf(buf, "%*pEp\n", (int)strlen(svc->key), svc->key);
+	return sprintf(buf, "%*pE\n", (int)strlen(svc->key), svc->key);
 }
 static DEVICE_ATTR_RO(key);
 
-- 
2.21.0

