Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A85149E43
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 03:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgA0CbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 21:31:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46598 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgA0CbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 21:31:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so9178781wrl.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 18:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8Fl6lZHlyGmeaB+wRmdy/sCfS67BztqJ8Vzq9DWPxw=;
        b=scpBITyjQJH0sozliOqn9QLrgCz2FW59BBft/FQGBdFCI+ZYYjLcGBLm0Jhe43fx+I
         OSvGqWrEpvkVW+LCRKzRFBA3FkFf/ODNmJww0sjj4VOnbgVM8yfGA4RzlYTGis2edl6L
         H9REG71Q1jm3E5aAbpCGw16ex4ziLkIjweGWuFGeZ+sd3g98BhRYlbhzkbOXmOkS9hSv
         7K1aIDrUNOi6/JcykplwFSC833q+civ85aGHFtdokF8LNCgF0qVa6WAMQS8ZTMyWIHgy
         wv69LEeyAIosq+kS/aUV8mLWmF/6UIGLh1krLnsoDCI0lb1fp7JDz4pSWUHx5BuPdXST
         KpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8Fl6lZHlyGmeaB+wRmdy/sCfS67BztqJ8Vzq9DWPxw=;
        b=Z6hQXF8HDLxMu55zKme3Lx9E4WeyPtkPb2RtVEAg/ETM0nY+hi5lAyNpvEWk8jTxvR
         Z8a6j5uWtERo1+YzaF6M3fwDlD5FnplkoBBHrLaHeOIIJ+Xr2BPG1LOFw/nrXG6uopP7
         E9IvtzzHAn4E6sMsF1hJu2aZd9im5QBKZXsyJKrDr16jE2YySYrJRGkBPOBiAtXcTcYS
         q5I63HNY+lnM7sjbxdLjazlEGtNq9uA6eaAorPtwpJ6brREhUy4adxyR0yqKzXoJLiGd
         FtajHDv3x52wt/Ew/hWVwBoh8r6ak8ATax/Q942DJ5nFIINDQoK/IFZMxHEvk8X7magD
         OH3w==
X-Gm-Message-State: APjAAAWXjrcxtN+vr3TIVOTZd8wOdgQzeEa5qsQzx/xd9ruHwiNWCifA
        mERoTiItYHu68NsnDIbp8A==
X-Google-Smtp-Source: APXvYqx8Nn4JA+ih8qfFMqyCphd0gH7k4apZXTfHguVJW87PCnCs6jZ5s4Yz2YKGsvNz8lPDJNG1fA==
X-Received: by 2002:adf:f288:: with SMTP id k8mr19689300wro.301.1580092261276;
        Sun, 26 Jan 2020 18:31:01 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y185sm11326460wmg.2.2020.01.26.18.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 18:31:00 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dvhart@infradead.org, peterz@infradead.org, mingo@redhat.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH v2 2/2] futex: Add missing annotation to wake_futex_pi()
Date:   Mon, 27 Jan 2020 02:30:51 +0000
Message-Id: <20200127023052.87188-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reprts warnings;

warning: context imbalance in wake_futex_pi() - unexpected unlock
warning: context imbalance in futex_unlock_p() - different lock contexts
         for basic block

The root cause is a missing annotation at wake_futex_pi()
which also causes the "different lock contexts for basic block" warning.
To fix these,
a __releases(&pi_state) annotation is added to wake_futex_pi().
Given that wake_futex_pi() does actually call
raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock) at exit,
this fixes the warnings

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/futex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 0cf84c8664f2..dfcb90b47ed6 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1549,7 +1549,8 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 /*
  * Caller must hold a reference on @pi_state.
  */
-static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
+static int wake_futex_pi(u32 __user *uaddr, u32 uval,
+			 struct futex_pi_state *pi_state) __releases(&pi_state)
 {
 	u32 uninitialized_var(curval), newval;
 	struct task_struct *new_owner;
-- 
2.24.1

