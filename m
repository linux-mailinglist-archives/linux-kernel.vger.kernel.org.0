Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE18191B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 14:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfHEMX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 08:23:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39059 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHEMXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:23:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so39655959pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KaGTdYqsvTF4u3tp0xDk/NEAitZQsW1ch/nrQc3hayg=;
        b=Yf3Uh6I/HpVtHSBJtybk4rp5TAZTszkCZv4QGefr2HcKlVQ0ggboBU5dY7i2i+thAC
         FdI73/lMsUaH5Jb5aryq2vpoQy8kFJ1ZYtA3BC+kqNs1cjwHzyOMBp4Bra4SsLqX5Vos
         C5K+6FJw4UIy0CUE+v6X4wYckOHiWskz4s9CoVUKGVypo/b75VLuiJMUT1s5lt8P34dX
         xQiK4m8tUIQLyLvxuPY0PN2fAoS/ScyjbHb+0Q+mXRjDcWjvHRNLR8aBAX7lLasrz1yJ
         JsO/bFUpKiQxUoNG5Jn6wBrMK4Esr8Y1Bzau5KvOnUOEBdaV7xho3H1VzIovCWpjm4/H
         HkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KaGTdYqsvTF4u3tp0xDk/NEAitZQsW1ch/nrQc3hayg=;
        b=Gzjp8jnCFP/tdXt5wQSh76tqTTfd7uDgG7YfeghN+3TYXy9jULHEKApX+92PGkbKzl
         Zj3FqMG1uQJL2i712HnzZd2yUAfAg+k5Up/hwH4L3I6Z+++B82JKpqAH8UKAc4H8ALUS
         FlEasU6/QSHsok+2806zG/1o0p19XRaJrHFtqD6/i0kobBKLUSI9G//xGNi4Pfj6NZVR
         WTAeGCUv1UiT0yzpdt5VVwakqxQi46oVWVwX6pFI46zULewgkTAyk1sDBHcDG61jAIGH
         wP0jrjM/5S6sJthcYaBNu5r3jWzihHZXlDcFqaLfZT238TvNepXazFYGL/ydlkuy3qcK
         o7Nw==
X-Gm-Message-State: APjAAAXRaNsQijxiYNrPYhx+Qnd6+q05Nr5cQQhKf8hptUIdd7cwclMZ
        RdCPw7H4u2lkeQ5dTYcugectUQG+NlSXYA==
X-Google-Smtp-Source: APXvYqycFUi/IJDZHi+8x0+U/M/ArAs/B3I59wolnQS8iku+EVPd5IJW1wn4IShy+Rye7vNrjGl2/A==
X-Received: by 2002:a62:2ccc:: with SMTP id s195mr72322673pfs.256.1565007805148;
        Mon, 05 Aug 2019 05:23:25 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id s6sm125102224pfs.122.2019.08.05.05.23.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:23:24 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v3 6/8] sched: Replace strncmp with str_has_prefix
Date:   Mon,  5 Aug 2019 20:23:18 +0800
Message-Id: <20190805122318.13149-1-hslester96@gmail.com>
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
Changes in v3:
  - Revise the description.

 kernel/sched/debug.c     | 5 +++--
 kernel/sched/isolation.c | 9 +++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f7e4579e746c..43983ff325b7 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -102,10 +102,11 @@ static int sched_feat_set(char *cmp)
 {
 	int i;
 	int neg = 0;
+	size_t len;
 
-	if (strncmp(cmp, "NO_", 3) == 0) {
+	if ((len = str_has_prefix(cmp, "NO_"))) {
 		neg = 1;
-		cmp += 3;
+		cmp += len;
 	}
 
 	i = match_string(sched_feat_names, __SCHED_FEAT_NR, cmp);
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index ccb28085b114..f528bb5996f4 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -141,16 +141,17 @@ __setup("nohz_full=", housekeeping_nohz_full_setup);
 static int __init housekeeping_isolcpus_setup(char *str)
 {
 	unsigned int flags = 0;
+	size_t len;
 
 	while (isalpha(*str)) {
-		if (!strncmp(str, "nohz,", 5)) {
-			str += 5;
+		if ((len = str_has_prefix(str, "nohz,"))) {
+			str += len;
 			flags |= HK_FLAG_TICK;
 			continue;
 		}
 
-		if (!strncmp(str, "domain,", 7)) {
-			str += 7;
+		if ((len = str_has_prefix(str, "domain,"))) {
+			str += len;
 			flags |= HK_FLAG_DOMAIN;
 			continue;
 		}
-- 
2.20.1

