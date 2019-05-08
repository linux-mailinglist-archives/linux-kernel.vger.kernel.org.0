Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF86E16ED1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 04:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfEHCKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 22:10:34 -0400
Received: from mail.windriver.com ([147.11.1.11]:34943 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfEHCKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:10:34 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x482AFAE015100
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 7 May 2019 19:10:15 -0700 (PDT)
Received: from pek-lpggp2.wrs.com (128.224.153.75) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.439.0; Tue, 7 May 2019
 19:10:14 -0700
From:   Wenlin Kang <wenlin.kang@windriver.com>
To:     <jason.wessel@windriver.com>, <daniel.thompson@linaro.org>,
        <prarit@redhat.com>
CC:     <kgdb-bugreport@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] kdb: Fix bound check compiler warning
Date:   Wed, 8 May 2019 09:52:39 +0800
Message-ID: <1557280359-202637-1-git-send-email-wenlin.kang@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() instead.

This fixes the following warning with gcc 8.2:

kernel/debug/kdb/kdb_io.c: In function 'kdb_getstr':
kernel/debug/kdb/kdb_io.c:449:3: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
   strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 kernel/debug/kdb/kdb_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6a4b414..7fd4513 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -446,7 +446,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
 {
 	if (prompt && kdb_prompt_str != prompt)
-		strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
+		strlcpy(kdb_prompt_str, prompt, CMD_BUFLEN);
 	kdb_printf(kdb_prompt_str);
 	kdb_nextline = 1;	/* Prompt and input resets line number */
 	return kdb_read(buffer, bufsize);
-- 
1.9.1

