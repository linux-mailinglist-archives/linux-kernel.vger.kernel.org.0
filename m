Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8252E145FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 10:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfEFIUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 04:20:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41641 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfEFIUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3so2386553pgp.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gwGyhQTcOWIi3KiN6SpFfHsSobNA+w5/u1qWdgTp7UQ=;
        b=npsaFU9WXA59NTCLcX0Wjx+OQV/XcxiWKTrM72/wE8hfV1H6dGaMHFSeuq8w5vhqyc
         d2zNN8WL8ERVwM1V8h1EKENcDdX+/+pWOv0gONIS1JGtORj53i+n2zflib108QKqwqdW
         UVzki3T7QgKbxT8gAHdkntc5c8ig+rvJWZQ8coya0TfgzGdsRyHZnhXa3q1DVOAHZ/vE
         irDjOjwKi2AqMhSMoo39u3FlZHRjSQyoCZmmjVGqOWSX39nxmVV4QoXrYtGf//0d6Sup
         EXE130jRxh3e0WUdt5UTYvUDxiGKiDv+H1Asqb8nLEX11e6JajX6KQFdEDkuhTd0YCSQ
         1dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwGyhQTcOWIi3KiN6SpFfHsSobNA+w5/u1qWdgTp7UQ=;
        b=jnIF5ErHtbhRq7GgXOABN5VSK5UeejovENOlNqxfa1Ez70KPkKMyJk2b4hnRB8Saz3
         RoNH/gIJSE5oW9Ecu+Tmlxy//+fdpALxWV4v+/RlTGdvLvc2YdT/H6BseCmxr9u8MZbn
         qi6UVBfwfDZc45ME4/QCoSIRJJlDrA+sCI4qekKw9O21jfuWKGveLQ97UDOa+ANabzp9
         siuqKnvbRRk1M8r97CDI2NV0jCw98A+MSCsTuZSa2TKuJQyDxgvP55lT6BvTsuWeIVM6
         Cb3ZKF4Y77iaRPkcUwxuF1obSg/SYqUHIhFPTdsTPcX/PgA2h650buhHXtuJe2EkLWtp
         8skA==
X-Gm-Message-State: APjAAAX3lNjhjfn4qLi6CfaKaZ0zVMG2284g+8CuuIwtFWfl60q/ldJv
        5leqReQLgjfBy2oqa8A/FExXb9yAU7pLqw==
X-Google-Smtp-Source: APXvYqyPbsb6PtgHg/qzZ9VI9woH7nTYQwIALD+zcoEDh3YG59tVevKYfPFpY4Y5dFu/Y1txxuFX/w==
X-Received: by 2002:a63:3fc1:: with SMTP id m184mr30002102pga.222.1557130824473;
        Mon, 06 May 2019 01:20:24 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:23 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 11/23] locking/lockdep: Update comment
Date:   Mon,  6 May 2019 16:19:27 +0800
Message-Id: <20190506081939.74287-12-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A leftover comment is removed. While at it, add more explanatory
comments. Such a trivial patch!

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index aa36502..b8e6ba3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2806,10 +2806,16 @@ static int validate_chain(struct task_struct *curr,
 		 * - is softirq-safe, if this lock is hardirq-unsafe
 		 *
 		 * And check whether the new lock's dependency graph
-		 * could lead back to the previous lock.
+		 * could lead back to the previous lock:
 		 *
-		 * any of these scenarios could lead to a deadlock. If
-		 * All validations
+		 * - within the current held-lock stack
+		 * - across our accumulated lock dependency records
+		 *
+		 * any of these scenarios could lead to a deadlock.
+		 */
+		/*
+		 * The simple case: does the current hold the same lock
+		 * already?
 		 */
 		int ret = check_deadlock(curr, hlock, hlock->read);
 
-- 
1.8.3.1

