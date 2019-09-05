Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D14AAC2E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 21:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391454AbfIETpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 15:45:06 -0400
Received: from fieldses.org ([173.255.197.46]:56754 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390112AbfIETog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:44:36 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id ED8896850; Thu,  5 Sep 2019 15:44:34 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 8/9] minor kstrdup_quotable simplification
Date:   Thu,  5 Sep 2019 15:44:32 -0400
Message-Id: <1567712673-1629-8-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567712673-1629-1-git-send-email-bfields@redhat.com>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

---
 lib/string_helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 47f40406f9d4..6f553f893fda 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -518,8 +518,8 @@ char *kstrdup_quotable(const char *src, gfp_t gfp)
 {
 	size_t slen, dlen;
 	char *dst;
-	const int flags = ESCAPE_STYLE_HEX;
-	const char esc[] = "\f\n\r\t\v\a\e\\\"";
+	const int flags = ESCAPE_SPECIAL|ESCAPE_STYLE_HEX;
+	const char esc[] = "\"";
 
 	if (!src)
 		return NULL;
-- 
2.21.0

