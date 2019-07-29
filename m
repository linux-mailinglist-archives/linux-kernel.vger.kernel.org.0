Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B7578EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfG2PP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 11:15:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34380 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbfG2PP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:15:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so28199142pfo.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=koA2wZvY1xMhA3KsE1/9Z0pBqrsMdAu4nwh2NZ9LbVk=;
        b=e4rzKkb2RcZY6CXq6oqa9fgnPRCiI/und8SOuBoGXaRlBhhEJbekWH21nMrMJ8OqE5
         nEcmwMn3FhROJt7eKaKQT9XxBjoqDQplHcQrPCYsnKjTo7pFQ8vQ8ESUdRvooqw2f49J
         EQIrBIbb1mlsWJI3sem1xKhmYQoiU51Kn7twObObN0/m4TCagI+wQOUIjXOUq3voR9Ni
         /K8PtiyKvPfMb3e+EVYVqbMBfkFaXurEfZDJcDPPGB7YkZG7qtLZNZmV87RNGDp942dD
         L3W5C83yrBxG5nBWdQRPC4KcCPvB+j4yMxVdYXp3FhXPIfOHAVS0BsNzxhmmj/zXCQML
         /66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=koA2wZvY1xMhA3KsE1/9Z0pBqrsMdAu4nwh2NZ9LbVk=;
        b=HicXIjGdvEm8xgRo+FPHVNRkzLk/AIO9fVDZXxHj+oFHKroxaTDKV5epar1DRjq5p0
         hLwhXl77lR5HkJ9rHP0D1/iDwuEpm6cTRYjhFp/Hm2FqDHjnyOg0Fe9VH13fu6+/vw5G
         gNGRZFfQEjqnwYq52eGe7i5A2oXtkGjhXUnQMIWzxdaArGevGNFENUuN6pZpMHvsyj2m
         4PnI0Y9mu1DikJOwAzmdPFGUOu51Z/PQnNzeNqvlLLGoTE62fCOIWzOxUp3QE0ty3fh5
         708fJAZgZib8CcSp53933QVzAbKvopUSCZWicFqpgEL7uuQM5sBKeUBbwFIUfik+JcvK
         Py2w==
X-Gm-Message-State: APjAAAW9tGbQUhXVwImbiPilfoWtn/uKJE/3pOsTJx7HH5NWrUSXfNtF
        cba+mxg2HVpP6+BlFpyBENWIK2XPv4E=
X-Google-Smtp-Source: APXvYqyB3jEiUjeBfqg1+3Yu/roidjNXiYN99hvJxwu3FlxQzIprglzNWcCjcFFd3YGe78AkBfeaLA==
X-Received: by 2002:a63:20d:: with SMTP id 13mr94245627pgc.253.1564413325640;
        Mon, 29 Jul 2019 08:15:25 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id o128sm67667764pfb.42.2019.07.29.08.15.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:15:25 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 10/12] sched: Replace strncmp with str_has_prefix
Date:   Mon, 29 Jul 2019 23:15:21 +0800
Message-Id: <20190729151521.9768-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone.
We had better use newly introduced
str_has_prefix() instead of it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 kernel/sched/debug.c     | 2 +-
 kernel/sched/isolation.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f7e4579e746c..6a77bf51e4d3 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -103,7 +103,7 @@ static int sched_feat_set(char *cmp)
 	int i;
 	int neg = 0;
 
-	if (strncmp(cmp, "NO_", 3) == 0) {
+	if (str_has_prefix(cmp, "NO_")) {
 		neg = 1;
 		cmp += 3;
 	}
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index ccb28085b114..cd5dfa93095d 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -143,13 +143,13 @@ static int __init housekeeping_isolcpus_setup(char *str)
 	unsigned int flags = 0;
 
 	while (isalpha(*str)) {
-		if (!strncmp(str, "nohz,", 5)) {
+		if (str_has_prefix(str, "nohz,")) {
 			str += 5;
 			flags |= HK_FLAG_TICK;
 			continue;
 		}
 
-		if (!strncmp(str, "domain,", 7)) {
+		if (str_has_prefix(str, "domain,")) {
 			str += 7;
 			flags |= HK_FLAG_DOMAIN;
 			continue;
-- 
2.20.1

