Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07F944626A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfFNPRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 11:17:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53667 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfFNPRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:17:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5EFGv3C1750214
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 Jun 2019 08:16:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5EFGv3C1750214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560525417;
        bh=le/to/qr3OhOGWicqrSnRrm9q9f8Ta2ZN9Hqy0LMed4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=i+xLvzC7Ri2LEfRWSryQ+MRbdtcagxQdnSnXA7OJpgkOqhVHqi8CLOn2b4kwxpSCd
         75A5cZAy69sNFfbFy5rmtMX47Mt7yDZRykhkgtu7mj87v/6cYco+2PwG50YJxOM5AL
         W9Cl2qeSxRiAktWiVLBQlO3m+sN2yQc3rDfALPiB0KRkWNjaGL9FRm/UGJTcvB3BK2
         0xc4DQqlwynAqKhYMCencCNfosOsut3R4HAaFxPHbWSxF1is9YroCQvcXeba385SLN
         /hw5xlbx9NJEOmVm6aolDq/bZ2ZDoFpFk+RjB8PheaADqv+msG/BGehdhdLP3aeTmQ
         bT4TbXe85xSQw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5EFGthk1750210;
        Fri, 14 Jun 2019 08:16:55 -0700
Date:   Fri, 14 Jun 2019 08:16:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yangtao Li <tipbot@zytor.com>
Message-ID: <tip-141e1ecda356bb0034027a9acb949e97a963ba16@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tiny.windzz@gmail.com,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tiny.windzz@gmail.com,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190525183925.18963-1-tiny.windzz@gmail.com>
References: <20190525183925.18963-1-tiny.windzz@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] alarmtimer: Fix kerneldoc comment for
 alarmtimer_suspend()
Git-Commit-ID: 141e1ecda356bb0034027a9acb949e97a963ba16
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,T_DATE_IN_FUTURE_96_Q autolearn=no
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  141e1ecda356bb0034027a9acb949e97a963ba16
Gitweb:     https://git.kernel.org/tip/141e1ecda356bb0034027a9acb949e97a963ba16
Author:     Yangtao Li <tiny.windzz@gmail.com>
AuthorDate: Sat, 25 May 2019 14:39:25 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 14 Jun 2019 17:04:04 +0200

alarmtimer: Fix kerneldoc comment for alarmtimer_suspend()

This brings the kernel doc in line with the function signature.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: john.stultz@linaro.org
Cc: sboyd@kernel.org
Link: https://lkml.kernel.org/r/20190525183925.18963-1-tiny.windzz@gmail.com

---
 kernel/time/alarmtimer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 0519a8805aab..57518efc3810 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -233,7 +233,6 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
 /**
  * alarmtimer_suspend - Suspend time callback
  * @dev: unused
- * @state: unused
  *
  * When we are going into suspend, we look through the bases
  * to see which is the soonest timer to expire. We then
