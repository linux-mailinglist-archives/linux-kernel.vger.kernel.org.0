Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680191148ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 22:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbfLEVxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 16:53:13 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36276 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730318AbfLEVwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:12 -0500
Received: by mail-il1-f193.google.com with SMTP id b15so4423142iln.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 13:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ds4ZVlPOzvwTUXxm8CWmPR/78xRX0JHc5Iyf+QRVEvs=;
        b=Q91GhkCGW+ye3okkqCQSAoPuzHPUn0SNToCW4VqLC0ycmbjVQSwghiWhFR6gT+Mirw
         JPnKvnogYwqTYmPxJm+xbgt61yj9SjuMr9qlY7/ytcKHChDHhxqomgxhuN29Sg5CSa8v
         TrAZ7hNExjtiURYWXE/a4+B44XmjVrprWT674G+2UZjcKTQBIwi+/8GLsnR3rNuRyUqH
         ayXzSnnXlMWuRrIGdnDdeNfaXcyYfIDcZQ8MLx7AI0Pd7y0PRDiABT6QoQt80v/7v79M
         YyHSjVnRAHMEpKMD0dtNfQut8DXymEscR40MhwqaZW9ODYiVWpvf/Kt3TFSp4QUh5flj
         uXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ds4ZVlPOzvwTUXxm8CWmPR/78xRX0JHc5Iyf+QRVEvs=;
        b=hmumB8ATfR/Hh/vVJwziqrXuisqMGT+TWYrsq18b92neVtODIhsSa3GINjwjrySUgq
         mWpEqTDHYEs0oTMsaH/hIsrvMJdxp6xNZFkJk8OIG335CVPoE+cEeycgSvq1Wn5Wkkrk
         ttZvKkL5V4LtbL7SLkb9eLpELcDg4gxwQz6rYjH1SRb+49ZDLtDH7NoXv8Fxo4TelnUg
         Ie+8iSqR9AzJWnwIW3pYcpMLO7xlgre/aQi/h2ssyyKk0BgRaClh1wOP50VVtQpuQrfE
         RzKSINZMsLwgu/pIqH9NCstfEktv80lZNaS0ioW4u4+Mce8gBICIaGMppF1F/BOVdbqy
         834A==
X-Gm-Message-State: APjAAAWUoHfHTVToZm6tZeKiR0hwqqNrOE5RpXsHEWHQyUzxKbhnHM2S
        95mrEPw9NR6Czpxn07Mvz4Q=
X-Google-Smtp-Source: APXvYqzadDMlPBimaW1K7DSBV8+sF0tEhX8lR2LwDCfXnLhm7DOdWWmTiAUDoq63AkUIApdrEw7tYg==
X-Received: by 2002:a92:660e:: with SMTP id a14mr11065037ilc.235.1575582731466;
        Thu, 05 Dec 2019 13:52:11 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:10 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 05/18] dyndbg: fix overcounting of ram used by dyndbg
Date:   Thu,  5 Dec 2019 14:51:36 -0700
Message-Id: <20191205215151.421926-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

during dyndbg init, verbose logging prints its ram overhead.  It
counted strlens of struct _ddebug's 4 string members, in all callsite
entries, which would be approximately correct if each had been
mallocd.  But they are pointers into shared .rodata; for example, all
10 kobject callsites have identical filename, module values.

Its best not to count that memory at all, since we cannot know they
were linked in because of CONFIG_DYNAMIC_DEBUG=y, and we want to
report a number that reflects what ram is saved by deconfiguring it.

Also fix wording and size under-reporting of the __dyndbg section.

Heres my overhead, on a virtme-run VM on a fedora-31 laptop:

  dynamic_debug:dynamic_debug_init: 260 modules, 2479 entries \
    and 10400 bytes in ddebug tables, 138824 bytes in __dyndbg section

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0a4588fe342e..b5fb0aa0fbc3 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1008,7 +1008,6 @@ static int __init dynamic_debug_init(void)
 	char *cmdline;
 	int ret = 0;
 	int n = 0, entries = 0, modct = 0;
-	int verbose_bytes = 0;
 
 	if (__start___dyndbg == __stop___dyndbg) {
 		pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
@@ -1019,9 +1018,6 @@ static int __init dynamic_debug_init(void)
 	iter_start = iter;
 	for (; iter < __stop___dyndbg; iter++) {
 		entries++;
-		verbose_bytes += strlen(iter->modname) + strlen(iter->function)
-			+ strlen(iter->filename) + strlen(iter->format);
-
 		if (strcmp(modname, iter->modname)) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
@@ -1038,9 +1034,9 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",
+	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 verbose_bytes + (int)(__stop___dyndbg - __start___dyndbg));
+		 (int)(entries * sizeof(struct _ddebug)));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.23.0

