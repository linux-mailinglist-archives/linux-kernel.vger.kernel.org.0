Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 271F7523D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 08:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfFYG62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 02:58:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55471 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbfFYG62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:58:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P6wCOE3496750
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 24 Jun 2019 23:58:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P6wCOE3496750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561445893;
        bh=VicCD+YhGWt7dt6kzCcZbVFrAmoQ6Lc/o1obQlqTo+o=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LoIoa1kCJBp0XtltZiYsVZgsfLHDuq2xMuh4KIgFQdHvt/qlPP2KT52s9NweyvuDt
         k/RF0h7SUSc9u0FrOzF866s7Svlcp7fRdwkQaAMKiDfH4E33hVaKDWQMJ8b8j886ao
         9bOKnFhZ0psHKm7+X2aj5RVLny7GgYODxUGL8LFplrjJy1n9dRtuW+Udah7/Vc5PFg
         Dkp2pyzEQ3sj///vSrDyiI8i1OP8T8/pJ8GaP/6S37aPmZIiXAMHeBHHdsN0SUTwvX
         x2LvlvT1Gb0WyUm5gX2BJmfgTe/lRawQjGvaLc2EbDevkTxflQObAwZB46eTQpNhOk
         nEcM/4W5bqTTA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P6wCMa3496747;
        Mon, 24 Jun 2019 23:58:12 -0700
Date:   Mon, 24 Jun 2019 23:58:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Jason A. Donenfeld" <tipbot@zytor.com>
Message-ID: <tip-d48e0cd8fcaf314175a15d3076d7a1e71bd4e628@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, Jason@zx2c4.com,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: arnd@arndb.de, linux-kernel@vger.kernel.org, Jason@zx2c4.com,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190624091539.13512-1-Jason@zx2c4.com>
References: <20190624091539.13512-1-Jason@zx2c4.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timekeeping: Boot should be boottime for coarse
 ns accessor
Git-Commit-ID: d48e0cd8fcaf314175a15d3076d7a1e71bd4e628
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d48e0cd8fcaf314175a15d3076d7a1e71bd4e628
Gitweb:     https://git.kernel.org/tip/d48e0cd8fcaf314175a15d3076d7a1e71bd4e628
Author:     Jason A. Donenfeld <Jason@zx2c4.com>
AuthorDate: Mon, 24 Jun 2019 11:15:39 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 25 Jun 2019 08:54:51 +0200

timekeeping: Boot should be boottime for coarse ns accessor

Somewhere in all the patchsets before, this cleanup got lost.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/20190624091539.13512-1-Jason@zx2c4.com

---
 Documentation/core-api/timekeeping.rst | 2 +-
 include/linux/timekeeping.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
index 15fc58e85ef9..20ee447a50f3 100644
--- a/Documentation/core-api/timekeeping.rst
+++ b/Documentation/core-api/timekeeping.rst
@@ -105,7 +105,7 @@ Some additional variants exist for more specialized cases:
 		ktime_t ktime_get_coarse_clocktai( void )
 
 .. c:function:: u64 ktime_get_coarse_ns( void )
-		u64 ktime_get_coarse_boot_ns( void )
+		u64 ktime_get_coarse_boottime_ns( void )
 		u64 ktime_get_coarse_real_ns( void )
 		u64 ktime_get_coarse_clocktai_ns( void )
 
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index dcffc00755f2..b27e2ffa96c1 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -131,7 +131,7 @@ static inline u64 ktime_get_coarse_real_ns(void)
 	return ktime_to_ns(ktime_get_coarse_real());
 }
 
-static inline u64 ktime_get_coarse_boot_ns(void)
+static inline u64 ktime_get_coarse_boottime_ns(void)
 {
 	return ktime_to_ns(ktime_get_coarse_boottime());
 }
