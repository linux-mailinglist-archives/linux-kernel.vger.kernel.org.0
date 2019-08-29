Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08543A13C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 10:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfH2IdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 04:33:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42921 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfH2IdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:33:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so1199939pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xf/qP44Xad5ckcoPN2iL2Ca0vpHNbzwhsmJj6GKRiPk=;
        b=oEZuWNL7UgI2X4O9sz08SnIjRMXMj0gAFY5oGVS/qskBr+9x/OlT2qlYpdY+6KcMbc
         e7q/Lsnv/i84aFDcvaNluv1EUXuaDoHWJbZXsupHHuQ0iJHdTdaomKCJgfxmWJDTDD+v
         cWoi4kBL0oLdzsUQtiRrnNTMHB0bWWb2en/k0Szoq4heibwsVq28G9M3k9AmAmYbsj5f
         esomZsqwSDXqB9ggRU1Umr0w/+FbEpZBCVuQpiS1ffJhikVDNIAdBosk5uhC0q2r4twu
         tltCSLsHBmaUhhAU0VHgz4rtUzOdzRlt9I2lrbB/yIDzxxlX5LhnPeJpRsMdQAHOuW8P
         2Gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xf/qP44Xad5ckcoPN2iL2Ca0vpHNbzwhsmJj6GKRiPk=;
        b=Fl/IH+RJmWxAT7uhIQB/vOUd0e62dgXHtRePU0gKKXunwZ0gveWk/nTKwsOrAmlxo9
         wk1WImIYYGFLmfnm+9xtnupwxw29IGz2tw8HRBBSNLWNQIBhvx0OsLM8sixfDMbwcd0v
         I5Co7KTyth6E9OsDjzMn4NakqqyOCIQlAhcVXhqBg2FdMOy8Q18w8/jtf8CYRQVqsNLh
         SaTd7495wsS/W7I0GV+NMWnyjzzSU13Ff8V+KNkQogfpMNI5z2ZJT2G5QuU9XLJ3ZSBZ
         KGbNxNXswBbjZczDAZTPAPOUL3m9TmgvKgT1X5T4ITU2kpFbqV1EyHnk80UWXLlEhJrb
         K9hw==
X-Gm-Message-State: APjAAAVT5QDti+Ox6CzttyF8syaLx/48bocwXnpdmOxrv2q/+jIgLa3U
        np8HpeCdReNybN0s+237gX0=
X-Google-Smtp-Source: APXvYqxuDUPFA6Y1uhUpkxGT+VhLAmwYLqrj0dzkYi1zCtBSr0WEZLA9d/VMaha4qvNqZvo0Jp6HxQ==
X-Received: by 2002:a17:90a:24cc:: with SMTP id i70mr8915565pje.12.1567067586998;
        Thu, 29 Aug 2019 01:33:06 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:33:06 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 21/30] locking/lockdep: Introduce chain_hlocks_type for held lock's read-write type
Date:   Thu, 29 Aug 2019 16:31:23 +0800
Message-Id: <20190829083132.22394-22-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock chain needs to include information about the read-write lock type. To
that end, introduce:

	chain_hlocks_type[MAX_LOCKDEP_CHAIN_HLOCKS]

in tandem with:

	chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS]

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index eb88314..1166262 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -950,6 +950,7 @@ static bool class_lock_list_valid(struct lock_class *c, int forward)
 
 #ifdef CONFIG_PROVE_LOCKING
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+static u16 chain_hlocks_type[MAX_LOCKDEP_CHAIN_HLOCKS];
 #endif
 
 static bool check_lock_chain_key(struct lock_chain *chain)
@@ -2669,6 +2670,7 @@ static inline void inc_chains(void)
 static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 int nr_chain_hlocks;
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+static u16 chain_hlocks_type[MAX_LOCKDEP_CHAIN_HLOCKS];
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
 {
@@ -2872,9 +2874,13 @@ static inline struct lock_chain *add_chain_cache(struct task_struct *curr,
 		chain->base = nr_chain_hlocks;
 		for (j = 0; j < chain->depth - 1; j++, i++) {
 			int lock_id = curr->held_locks[i].class_idx;
+			int lock_type = curr->held_locks[i].read;
+
 			chain_hlocks[chain->base + j] = lock_id;
+			chain_hlocks_type[chain->base + j] = lock_type;
 		}
 		chain_hlocks[chain->base + j] = class - lock_classes;
+		chain_hlocks_type[chain->base + j] = hlock->read;
 		nr_chain_hlocks += chain->depth;
 	} else {
 		if (!debug_locks_off_graph_unlock())
@@ -4886,6 +4892,9 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 			memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
 				(chain->base + chain->depth - i) *
 				sizeof(chain_hlocks[0]));
+			memmove(&chain_hlocks_type[i], &chain_hlocks_type[i + 1],
+				(chain->base + chain->depth - i) *
+				sizeof(chain_hlocks_type[0]));
 		}
 		/*
 		 * Each lock class occurs at most once in a lock chain so once
@@ -5356,6 +5365,7 @@ void __init lockdep_init(void)
 		+ sizeof(lock_chains_in_use)
 		+ sizeof(lock_chains_in_dep)
 		+ sizeof(chain_hlocks)
+		+ sizeof(chain_hlocks_type)
 #endif
 		) / 1024
 		);
-- 
1.8.3.1

