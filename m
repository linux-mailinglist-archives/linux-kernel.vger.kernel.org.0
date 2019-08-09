Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE7A872C2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 09:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405767AbfHIHKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 03:10:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34008 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405700AbfHIHKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:10:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so39176644pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a5eAdforJPfI5AutgpY5E1bO5+BesI2S6rA/D6o6CCg=;
        b=mDpqdxWDR7UvCn1miherHFNhhyu2Kkby2aYHMvu/Z6T2H4gQWGSJfK6hIWYjRSBfQn
         KDyu0PLfk59UXPoaYBJ2xI1gqYX5k5UgZMgxshPGV3THmYfGTH3rf+vKRKdSHXSMJv77
         4m/zBzvWu8+I0NqnXCGSL8xi6xIAShYizPpHugV6SoyAUtLntF0C75dw4YuDkmt7xYIT
         n072RcSqR9vMBpZzWyHWMBdv9Rko+v2uuUpJfyYx18I1xhtFPti0gIxyOMyn+PFUSgey
         Px+OGtHKtB0JH8RK/9AFfJlhCBeiD6Ba3S58ZpD7IrD+LSZTwEtBCUrNV68BCW7rMr9d
         CZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a5eAdforJPfI5AutgpY5E1bO5+BesI2S6rA/D6o6CCg=;
        b=ZhsYHU0nTTPTjsLF4tRHJQ0ZBYdntsbOYWVUHlR5TJx3O9AFjrNdxYHmtSHG6GkV/J
         37psQliZWsjOgrpRPxwX7fHiGmxIT65G4QTPUyMjSX1Jt3udnYa5dEcTkQuHmiKLVRbC
         zpSb7tDSuz5djDR4WS/z0pPU0I10vxmqsMs6Yn6DU67OWdNP4g6GDxTCdNS93TCryNra
         2dm1tHQeJpuMhUHN1YynnjvrUqjwln4rsH/ijbBx2Q9G1xJfvcKfgaW4wNtiD0cOKMvZ
         8hJ1b3CClzOqm11D4oITVTLNSmNB8WipukNvXmxSHqbjrjGJHjpSCyASHykr2KWR3baK
         EHZw==
X-Gm-Message-State: APjAAAVPDiuaRJFeFjxZnPOmOWi4qkp440TZbzD+lCafviwxvpVvSriu
        kVokXVOOzLKMhVkgNTrOckc=
X-Google-Smtp-Source: APXvYqxuZQXlgouixG8Pwov2oZwIMRepy53nKGcS1bzzPx5sYz+Mga8r1S/1irrQAxELbQPd1OBJHw==
X-Received: by 2002:a65:43c2:: with SMTP id n2mr16339061pgp.110.1565334639457;
        Fri, 09 Aug 2019 00:10:39 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id k25sm82073711pgt.53.2019.08.09.00.10.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 00:10:38 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v4 4/8] printk: Replace strncmp with str_has_prefix
Date:   Fri,  9 Aug 2019 15:10:34 +0800
Message-Id: <20190809071034.17279-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone because len
is easy to have typo.
The example is the hard-coded len has counting error
or sizeof(const) forgets - 1.
So we prefer using newly introduced str_has_prefix()
to substitute such strncmp to make code better.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v4:
  - Eliminate assignments in if conditions.

 kernel/printk/braille.c | 15 +++++++++++----
 kernel/printk/printk.c  | 22 ++++++++++++++++------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
index 1d21ebacfdb8..17a9591e54ff 100644
--- a/kernel/printk/braille.c
+++ b/kernel/printk/braille.c
@@ -11,11 +11,18 @@
 
 int _braille_console_setup(char **str, char **brl_options)
 {
-	if (!strncmp(*str, "brl,", 4)) {
+	size_t len;
+
+	len = str_has_prefix(*str, "brl,");
+	if (len) {
 		*brl_options = "";
-		*str += 4;
-	} else if (!strncmp(*str, "brl=", 4)) {
-		*brl_options = *str + 4;
+		*str += len;
+		return 0;
+	}
+
+	len = str_has_prefix(*str, "brl=");
+	if (len) {
+		*brl_options = *str + len;
 		*str = strchr(*brl_options, ',');
 		if (!*str) {
 			pr_err("need port name after brl=\n");
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1888f6a3b694..43a31015ec93 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -118,19 +118,29 @@ static unsigned int __read_mostly devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
 
 static int __control_devkmsg(char *str)
 {
+	size_t len;
+
 	if (!str)
 		return -EINVAL;
 
-	if (!strncmp(str, "on", 2)) {
+	len = str_has_prefix(str, "on");
+	if (len) {
 		devkmsg_log = DEVKMSG_LOG_MASK_ON;
-		return 2;
-	} else if (!strncmp(str, "off", 3)) {
+		return len;
+	}
+
+	len = str_has_prefix(str, "off");
+	if (len) {
 		devkmsg_log = DEVKMSG_LOG_MASK_OFF;
-		return 3;
-	} else if (!strncmp(str, "ratelimit", 9)) {
+		return len;
+	}
+
+	len = str_has_prefix(str, "ratelimit");
+	if (len) {
 		devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
-		return 9;
+		return len;
 	}
+
 	return -EINVAL;
 }
 
-- 
2.20.1

