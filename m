Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3DD5719C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 15:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390435AbfGWNvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 09:51:55 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:37583 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390417AbfGWNvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:51:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 0132783777ED;
        Tue, 23 Jul 2019 13:51:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:973:982:988:989:1260:1345:1359:1437:1534:1542:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2895:3138:3139:3140:3141:3142:3354:3865:3866:3867:3868:3871:3873:4321:4605:5007:6119:6261:7903:9121:10004:10848:11026:11232:11658:11914:12043:12109:12296:12297:12555:12679:12895:12986:14096:14181:14394:14721:21080:21451:21627:30034:30054:30070:30090,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: page82_83b617262f530
X-Filterd-Recvd-Size: 3984
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jul 2019 13:51:44 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH V2 2/2] kernel-doc: core-api: Include string.h into core-api
Date:   Tue, 23 Jul 2019 06:51:37 -0700
Message-Id: <29f998b4c1a9d69fbeae70500ba0daa4b340c546.1563889130.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1563889130.git.joe@perches.com>
References: <cover.1563889130.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

core-api should show all the various string functions including the
newly added stracpy and stracpy_pad.

Miscellanea:

o Update the Returns: value for strscpy
o fix a defect with %NUL)

Signed-off-by: Joe Perches <joe@perches.com>
---

V2: Correct return of -E2BIG descriptions

 Documentation/core-api/kernel-api.rst |  3 +++
 include/linux/string.h                |  5 +++--
 lib/string.c                          | 10 ++++++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 08af5caf036d..f77de49b1d51 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -42,6 +42,9 @@ String Manipulation
 .. kernel-doc:: lib/string.c
    :export:
 
+.. kernel-doc:: include/linux/string.h
+   :internal:
+
 .. kernel-doc:: mm/util.c
    :functions: kstrdup kstrdup_const kstrndup kmemdup kmemdup_nul memdup_user
                vmemdup_user strndup_user memdup_user_nul
diff --git a/include/linux/string.h b/include/linux/string.h
index 7572cd78cf9f..3cf684db4bc6 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -519,8 +519,9 @@ static inline void memcpy_and_pad(void *dest, size_t dest_len,
  * But this can lead to bugs due to typos, or if prefix is a pointer
  * and not a constant. Instead use str_has_prefix().
  *
- * Returns: 0 if @str does not start with @prefix
-         strlen(@prefix) if @str does start with @prefix
+ * Returns:
+ * * strlen(@prefix) if @str starts with @prefix
+ * * 0 if @str does not start with @prefix
  */
 static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
 {
diff --git a/lib/string.c b/lib/string.c
index 461fb620f85f..f7bc10da4259 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -173,8 +173,9 @@ EXPORT_SYMBOL(strlcpy);
  * doesn't unnecessarily force the tail of the destination buffer to be
  * zeroed.  If zeroing is desired please use strscpy_pad().
  *
- * Return: The number of characters copied (not including the trailing
- *         %NUL) or -E2BIG if the destination buffer wasn't big enough.
+ * Returns:
+ * * The number of characters copied (not including the trailing %NUL)
+ * * -E2BIG if count is 0 or @src was truncated.
  */
 ssize_t strscpy(char *dest, const char *src, size_t count)
 {
@@ -253,8 +254,9 @@ EXPORT_SYMBOL(strscpy);
  * For full explanation of why you may want to consider using the
  * 'strscpy' functions please see the function docstring for strscpy().
  *
- * Return: The number of characters copied (not including the trailing
- *         %NUL) or -E2BIG if the destination buffer wasn't big enough.
+ * Returns:
+ * * The number of characters copied (not including the trailing %NUL)
+ * * -E2BIG if count is 0 or @src was truncated.
  */
 ssize_t strscpy_pad(char *dest, const char *src, size_t count)
 {
-- 
2.15.0

