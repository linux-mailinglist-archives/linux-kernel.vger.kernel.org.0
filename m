Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABEA286AF1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 21:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390388AbfHHTyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 15:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404391AbfHHTxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:15 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 676312189F;
        Thu,  8 Aug 2019 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565293994;
        bh=3qYlaQUl4rjpzfZVaXqFO7psBcZvQ5hQeGTgLfxda/s=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=CUtpfZxplnU3Bc0I0mg45vDPMoIX/tZNqviM2fOtcgdD/zio45rwhROxQBAPjO3+W
         ZQZgFXnbhweeaK3PTeFSuT3nr1jAjLwH7YtUdf1W6WoTQaRoB2+GOIe/KenAW/FWxs
         p5LrzwKxFjibPlPZYWuxW34b+Q+Lg7dEa5O3mgm0=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 05/19] locking/rwsem: Rename rwsem_rt.h to rwsem-rt.h
Date:   Thu,  8 Aug 2019 14:52:33 -0500
Message-Id: <413840eba0b87756a0bd16b05d4f3ee52f7793ff.1565293934.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit fc7a6bdcce83ce162c32d991f0ac8e56ea260f5b ]

Rename rwsem_rt.h to rwsem-rt.h to remain consistent with rwsem-rt.c.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/{rwsem_rt.h => rwsem-rt.h} | 0
 include/linux/rwsem.h                    | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/{rwsem_rt.h => rwsem-rt.h} (100%)

diff --git a/include/linux/rwsem_rt.h b/include/linux/rwsem-rt.h
similarity index 100%
rename from include/linux/rwsem_rt.h
rename to include/linux/rwsem-rt.h
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 513df11a364e..ac0857d60e04 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -21,7 +21,7 @@
 #endif
 
 #ifdef CONFIG_PREEMPT_RT_FULL
-#include <linux/rwsem_rt.h>
+#include <linux/rwsem-rt.h>
 #else /* PREEMPT_RT_FULL */
 
 struct rw_semaphore;
-- 
2.14.1

