Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA1764F7F0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 21:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfFVT34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 15:29:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33121 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFVT3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 15:29:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MJTknX2308543
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 12:29:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MJTknX2308543
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561231787;
        bh=LQnPhAu1trmfiG5WmQfr8cwMVeVkwrejCTT1PXU+gIU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UtLV8ZSl4EZZxbYWvzHwQGVIccIXQsvCl462F23DUjH03iK9OjW1I3TnHBDIn494M
         YS5N/vgaFOij8IbM3DF4uBnXc2SJxnUhsULM7PBrVnWWDujTnCiOildQCQXAMjJ0na
         P1EOYOp8AbshTdF0AhijMOSOeYMRMmvthvMw3T5WvUP0Rtgo74IpGd2ZHCVxjQc74V
         2qdM/GVSJf7OZB2TcWqlcR+IioBp1290wpcVDBN0SeLYdy7AsIM05cJTlMHbxwv0KW
         VD428RBxApOglEqttxAgAGgy6yQo6vgMBIEhpmR/FWflNpTYLTH/isFGc7Fe7F/6dd
         NR2illj4D2onA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MJTjvV2308540;
        Sat, 22 Jun 2019 12:29:45 -0700
Date:   Sat, 22 Jun 2019 12:29:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Jason A. Donenfeld" <tipbot@zytor.com>
Message-ID: <tip-4c54294d01e605a9f992361b924c5d8b12822a6d@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        arnd@arndb.de, hpa@zytor.com, Jason@zx2c4.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, arnd@arndb.de,
          mingo@kernel.org, hpa@zytor.com, Jason@zx2c4.com
In-Reply-To: <20190621203249.3909-3-Jason@zx2c4.com>
References: <20190621203249.3909-3-Jason@zx2c4.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timekeeping: Add missing _ns functions for coarse
 accessors
Git-Commit-ID: 4c54294d01e605a9f992361b924c5d8b12822a6d
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

Commit-ID:  4c54294d01e605a9f992361b924c5d8b12822a6d
Gitweb:     https://git.kernel.org/tip/4c54294d01e605a9f992361b924c5d8b12822a6d
Author:     Jason A. Donenfeld <Jason@zx2c4.com>
AuthorDate: Fri, 21 Jun 2019 22:32:49 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 12:11:28 +0200

timekeeping: Add missing _ns functions for coarse accessors

This further unifies the accessors for the fast and coarse functions, so
that the same types of functions are available for each. There was also
a bit of confusion with the documentation, which prior advertised a
function that has never existed. Finally, the vanilla ktime_get_coarse()
was omitted from the API originally, so this fills this oversight.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/20190621203249.3909-3-Jason@zx2c4.com

---
 Documentation/core-api/timekeeping.rst | 10 +++++++---
 include/linux/timekeeping.h            | 28 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
index 4d92b1ac8024..15fc58e85ef9 100644
--- a/Documentation/core-api/timekeeping.rst
+++ b/Documentation/core-api/timekeeping.rst
@@ -99,16 +99,20 @@ Coarse and fast_ns access
 
 Some additional variants exist for more specialized cases:
 
-.. c:function:: ktime_t ktime_get_coarse_boottime( void )
+.. c:function:: ktime_t ktime_get_coarse( void )
+		ktime_t ktime_get_coarse_boottime( void )
 		ktime_t ktime_get_coarse_real( void )
 		ktime_t ktime_get_coarse_clocktai( void )
-		ktime_t ktime_get_coarse_raw( void )
+
+.. c:function:: u64 ktime_get_coarse_ns( void )
+		u64 ktime_get_coarse_boot_ns( void )
+		u64 ktime_get_coarse_real_ns( void )
+		u64 ktime_get_coarse_clocktai_ns( void )
 
 .. c:function:: void ktime_get_coarse_ts64( struct timespec64 * )
 		void ktime_get_coarse_boottime_ts64( struct timespec64 * )
 		void ktime_get_coarse_real_ts64( struct timespec64 * )
 		void ktime_get_coarse_clocktai_ts64( struct timespec64 * )
-		void ktime_get_coarse_raw_ts64( struct timespec64 * )
 
 	These are quicker than the non-coarse versions, but less accurate,
 	corresponding to CLOCK_MONONOTNIC_COARSE and CLOCK_REALTIME_COARSE
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fd6123722ea8..dcffc00755f2 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -113,6 +113,34 @@ static inline ktime_t ktime_get_coarse_clocktai(void)
 	return ktime_get_coarse_with_offset(TK_OFFS_TAI);
 }
 
+static inline ktime_t ktime_get_coarse(void)
+{
+	struct timespec64 ts;
+
+	ktime_get_coarse_ts64(&ts);
+	return timespec64_to_ktime(ts);
+}
+
+static inline u64 ktime_get_coarse_ns(void)
+{
+	return ktime_to_ns(ktime_get_coarse());
+}
+
+static inline u64 ktime_get_coarse_real_ns(void)
+{
+	return ktime_to_ns(ktime_get_coarse_real());
+}
+
+static inline u64 ktime_get_coarse_boot_ns(void)
+{
+	return ktime_to_ns(ktime_get_coarse_boottime());
+}
+
+static inline u64 ktime_get_coarse_clocktai_ns(void)
+{
+	return ktime_to_ns(ktime_get_coarse_clocktai());
+}
+
 /**
  * ktime_mono_to_real - Convert monotonic time to clock realtime
  */
