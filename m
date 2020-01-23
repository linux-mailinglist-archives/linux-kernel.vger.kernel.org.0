Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A8C146BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 15:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgAWOx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 09:53:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36244 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgAWOx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:53:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id w2so1662161pfd.3;
        Thu, 23 Jan 2020 06:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gx1EwHhSeFAygAuuMCDt/vxczuYsXqL8AapATfNX7y8=;
        b=VFUCclZbsvs3ZYUE86h0BVB6542Nh/HbW0yALhQI9boAo07OpF99xuKWuhlGDBTVxq
         mX7S38mG1dVdVZ4scl37EJFo06E1JlA+w5S67OIBhcOcj99mA6/WXvnaA7qwLOomD7zX
         LxP/fa1TGRCaYGqYGXZTFJhaXd0YPTXYIhH2ycGMovnVFf5lZrJlCknZ2tlvCAHh1mXD
         KySUmdepz5hkHoGY24P8TtSto5IsSsMlDPJmjnxcyFU89hMKaryDZMBMSzDYVZvcHpEZ
         Nu4WsFHqPSa7/i1MMK636JOHUwJFlvT1q5Pnf667EQcLC485+XsaNE/uIRLFGODYxMAy
         VeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gx1EwHhSeFAygAuuMCDt/vxczuYsXqL8AapATfNX7y8=;
        b=Y2eh+0QFTgEzQOgzA7sFSsvve4gL7+N8hLzZijYW5jIDQokNm27rFzX+DJr3C7cufV
         GsfUvF/9+Pkuq+awjDqb69L8gF7xhBnmOsDKlqQ0QLQ086hpZ0ChFTWCT2wCDQwtsZqB
         JhpHIgGX+P0UQZqD4sA8JbRO2ADcdf9wZS7uvbnjIlYa3KdCiLbsYAcpd4KJRSrNgLEa
         /rG9ui9Gy9TM/LsTuozwcxilQtGlrlhvPputGgVXo2KB0g+a2lVkVIUbIS+UUf+f7jZY
         wOvPMb/UwIi42jRv6O5/Aq73F6IbsHX2NUY9zX0xNCzYQnGzlZlgmGP4utLp0TEOKwiB
         l9Mg==
X-Gm-Message-State: APjAAAV9rTXqg1pyiRApu4/bY/Tn9moEHNaZYOYJFapY7G+mlKL0PIc0
        HIkH7AzlanrpjNJjXvd7ZQ==
X-Google-Smtp-Source: APXvYqzuuPGh4gpKk33IILFsa7XJBoe6la2FVwOIjW02LC/QfoGe4XDCFdwUi/OzBda0oBPz4ggbWQ==
X-Received: by 2002:a63:213:: with SMTP id 19mr4382178pgc.160.1579791236088;
        Thu, 23 Jan 2020 06:53:56 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee5:f6bd:65db:7abb:c28f:eeed])
        by smtp.gmail.com with ESMTPSA id o184sm3206955pgo.62.2020.01.23.06.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 06:53:55 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, ebiederm@xmission.com,
        christian.brauner@ubuntu.com, oleg@redhat.com, paulmck@kernel.org
Cc:     joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com, rcu@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] sched.h: Annotate sighand_struct with __rcu
Date:   Thu, 23 Jan 2020 20:23:05 +0530
Message-Id: <20200123145305.10652-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch fixes the following sparse errors by annotating the
sighand_struct with __rcu

kernel/fork.c:1511:9: error: incompatible types in comparison expression
kernel/exit.c:100:19: error: incompatible types in comparison expression
kernel/signal.c:1370:27: error: incompatible types in comparison expression

This fix introduces the following sparse error in signal.c due to
checking the sighand pointer without rcu primitives:

kernel/signal.c:1386:21: error: incompatible types in comparison expression

This new sparse error is also addressed in this patch.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 include/linux/sched.h | 2 +-
 kernel/signal.c       | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b511e178a89f..7a351360ad54 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -918,7 +918,7 @@ struct task_struct {
 
 	/* Signal handlers: */
 	struct signal_struct		*signal;
-	struct sighand_struct		*sighand;
+	struct sighand_struct __rcu		*sighand;
 	sigset_t			blocked;
 	sigset_t			real_blocked;
 	/* Restored if set_restore_sigmask() was used: */
diff --git a/kernel/signal.c b/kernel/signal.c
index bcd46f547db3..1272def37462 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1383,7 +1383,8 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
 		 * must see ->sighand == NULL.
 		 */
 		spin_lock_irqsave(&sighand->siglock, *flags);
-		if (likely(sighand == tsk->sighand))
+		if (likely(sighand == rcu_dereference_protected(tsk->sighand,
+						lockdep_is_held(&sighand->siglock))))
 			break;
 		spin_unlock_irqrestore(&sighand->siglock, *flags);
 	}
-- 
2.17.1

