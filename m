Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF0D64975
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 17:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfGJPWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 11:22:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59149 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfGJPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:22:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6AFMBuv2475328
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Jul 2019 08:22:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6AFMBuv2475328
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562772131;
        bh=bNrjrjy4R5niEjju/4I+idJowXwPnzgihtU7QB7ZbD4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=riGAY/ntE/7YHpRf8Xu67k/+BUeS11lzEn2WvREt1uBKPsU+bJV15Dn4YsVUgIhmv
         kXDjyVzv9AuuOJks660RF/Ud+0PYIPDCV/rInGvaGtVnYGeiYSeraA1Vxs2Vy9wCil
         Zd9mdoKZ5bQtv1WQu6/i1NoMhLvJ4jn3CnrDBedwxvkjB6dlYJt4gTqVoUW4mx9C90
         QP/A8qzfdaMM833UTjWT7bYdsgQCxuTzSGIS3tiQHWGWUtxEWYOaBGUboqN9XOCQrD
         tMtlWFCU1ttgIp/HYQ59fwSDR39LmCezq0KDfiRjY+YI9d7NJ39lmQNIvRbxkf1cmi
         4MQtiBa94CE9A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6AFMAW12475322;
        Wed, 10 Jul 2019 08:22:10 -0700
Date:   Wed, 10 Jul 2019 08:22:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-510c12149954eb9db6a30c2b9f7526af71afb7a4@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, arnd@arndb.de, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190710130206.1670830-1-arnd@arndb.de>
References: <20190710130206.1670830-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] timekeeping/vsyscall: Use __iter_div_u64_rem()
Git-Commit-ID: 510c12149954eb9db6a30c2b9f7526af71afb7a4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  510c12149954eb9db6a30c2b9f7526af71afb7a4
Gitweb:     https://git.kernel.org/tip/510c12149954eb9db6a30c2b9f7526af71afb7a4
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Wed, 10 Jul 2019 15:01:53 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 10 Jul 2019 17:17:49 +0200

timekeeping/vsyscall: Use __iter_div_u64_rem()

On 32-bit x86 when building with clang-9, the 'division' loop gets turned
back into an inefficient division that causes a link error:

kernel/time/vsyscall.o: In function `update_vsyscall':
vsyscall.c:(.text+0xe3): undefined reference to `__udivdi3'

Use the existing __iter_div_u64_rem() function which is used to address the
same issue in other places.

Fixes: 44f57d788e7d ("timekeeping: Provide a generic update_vsyscall() implementation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190710130206.1670830-1-arnd@arndb.de

---
 kernel/time/vsyscall.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index a80893180826..8cf3596a4ce6 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -104,11 +104,7 @@ void update_vsyscall(struct timekeeper *tk)
 	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
 	nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 	nsec		= nsec + tk->wall_to_monotonic.tv_nsec;
-	while (nsec >= NSEC_PER_SEC) {
-		nsec = nsec - NSEC_PER_SEC;
-		vdso_ts->sec++;
-	}
-	vdso_ts->nsec	= nsec;
+	vdso_ts->sec	+= __iter_div_u64_rem(nsec, NSEC_PER_SEC, &vdso_ts->nsec);
 
 	if (__arch_use_vsyscall(vdata))
 		update_vdso_data(vdata, tk);
