Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7007E7A5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 03:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbfHBBrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 21:47:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38985 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfHBBrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:47:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so33021833pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+vxHc5RDDwEK17Sr2QrAPRn0RxhaEPU9AZ0VMzC7/4Q=;
        b=Kzsp8LaptraISsN7glqbkoD3sG8HXBmBzcgk0faMRd8we7GGrKKtNPsAIpSXCjW8I1
         mfbVpQQ9+QrJV9HsZrF9T+loqXhtMP7C7Hu+n0vfJHCMBnMs+43c+qsYHfIrD3hwKmH3
         GhsGGXmKW5V5YG0rwsmq/hO4qqHdGc/FvhQ/qA4WQnYa6aDr3cGeuBDkEvnMdKwAzhji
         /x9f5gt5b4AzFlv9IqBK3j9uOtl7PWbVvRAgWq0ckzxYzGUYTGOsIwcWaI9PgFr10Zc2
         j1cGjTz8py/7MijjdYXjqTP4JTfdtcZgL4hUrFAOcCyXldouPJp4BK+d6iAB5AT7WUCi
         RYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+vxHc5RDDwEK17Sr2QrAPRn0RxhaEPU9AZ0VMzC7/4Q=;
        b=lqcewdrn8q7XuEqKlbgcK+BP6qCCPjUO+69ow0L60cU4e3BizBzs1Md6nHcha6k3/u
         7jgSnW7yROcBupmENBf/oz/BUUmAb17cjFMkaemwoQK7pZf1ViWF6YHBzGPVs6r05pI4
         AP4FKEpnaWD8DCrtNq9rod0HLEfb6ipfGkArDlrvlF03ZO9+WkHHBMgloUbjcrKikCr7
         hublHuuR2kHvSesTgxydBMUnArrUTQJphEBs/3yfi5Imu05+RHzIW/pfR433A1F+M0/t
         JFD6Fhq1qDfyYTQYVXoknorDd1sE8kmXmkZDbeFIDjilzkNhGOkjjW4WB+RkM2qIyKZ0
         HBvg==
X-Gm-Message-State: APjAAAUv8ZJK5pkpegalPgrxAhSpUur0d4WAu43rbRGjKOSJkV9Qe31i
        kLdw3NPtvtBG/2QsDVO1FNNs6DVj59f51A==
X-Google-Smtp-Source: APXvYqzXmJ1JTz0zsD4fDJwa7iMlziBCJl2DXub2B04VBdnTEAbHK5yxFt2bp6xYSgCQm2ziO7mFeA==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr91477383ply.261.1564710443269;
        Thu, 01 Aug 2019 18:47:23 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id q126sm78872796pfq.123.2019.08.01.18.47.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:47:22 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2 06/10] printk: Replace strncmp with str_has_prefix
Date:   Fri,  2 Aug 2019 09:47:18 +0800
Message-Id: <20190802014718.8952-1-hslester96@gmail.com>
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
So we prefer using newly introduced str_has_prefix
to substitute such strncmp.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Revise the description.
  - Utilize str_has_prefix's return value to
    eliminate some hard codes.

 kernel/printk/braille.c | 10 ++++++----
 kernel/printk/printk.c  | 14 ++++++++------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
index 1d21ebacfdb8..e451b8b1d3d5 100644
--- a/kernel/printk/braille.c
+++ b/kernel/printk/braille.c
@@ -11,11 +11,13 @@
 
 int _braille_console_setup(char **str, char **brl_options)
 {
-	if (!strncmp(*str, "brl,", 4)) {
+	size_t len;
+
+	if ((len = str_has_prefix(*str, "brl,"))) {
 		*brl_options = "";
-		*str += 4;
-	} else if (!strncmp(*str, "brl=", 4)) {
-		*brl_options = *str + 4;
+		*str += len;
+	} else if ((len = str_has_prefix(*str, "brl="))) {
+		*brl_options = *str + len;
 		*str = strchr(*brl_options, ',');
 		if (!*str) {
 			pr_err("need port name after brl=\n");
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1888f6a3b694..21b28c7dd18f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -118,18 +118,20 @@ static unsigned int __read_mostly devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
 
 static int __control_devkmsg(char *str)
 {
+	size_t len;
+
 	if (!str)
 		return -EINVAL;
 
-	if (!strncmp(str, "on", 2)) {
+	if ((len = str_has_prefix(str, "on"))) {
 		devkmsg_log = DEVKMSG_LOG_MASK_ON;
-		return 2;
-	} else if (!strncmp(str, "off", 3)) {
+		return len;
+	} else if ((len = str_has_prefix(str, "off"))) {
 		devkmsg_log = DEVKMSG_LOG_MASK_OFF;
-		return 3;
-	} else if (!strncmp(str, "ratelimit", 9)) {
+		return len;
+	} else if ((len = str_has_prefix(str, "ratelimit"))) {
 		devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
-		return 9;
+		return len;
 	}
 	return -EINVAL;
 }
-- 
2.20.1

