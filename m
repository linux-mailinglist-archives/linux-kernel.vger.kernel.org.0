Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0C74B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 12:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfGYKZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 06:25:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37765 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfGYKZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:25:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PAPFtZ958563
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 03:25:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PAPFtZ958563
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564050315;
        bh=3VmaafQMX69052rZTCEMnFZherDDtPLEYB3ZW7XCFPM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TUVu/4crwu1uCDmyZqT0Ps67R9orgIK3toYFja2QxJq7VNCW2PUUt0DaLakpZml6Z
         ZXND/RxaKfccyFHQZOfZDkOudsjyNO3jdhBy9aD6Ebgg5kJsBUvBbbxJnNszjpz6zu
         gceUhRDPO3n+chN3xA9FFJg9U4mmnMV/xmSJMSqb53vXnW+P/S/ThCEbqy2iE1ghM0
         OaG7Vk2op3c2wEuRY2AdfFcJOzWVdIUKgrPjPXLO/9vWknDRX8rQyu1JHWgFetbUDG
         Ddm6xEYtLV0ceU9dyKSyVRi/gtGR05yPf/63SDg0+egEzI73fwDnlWq5nZAOdj1xhh
         VlrBHpyBmZtDA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PAPEhE958560;
        Thu, 25 Jul 2019 03:25:14 -0700
Date:   Thu, 25 Jul 2019 03:25:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-643d83f0a3518d6fbcf88f970de0340a5aa6b5a2@git.kernel.org>
Cc:     rsalvaterra@gmail.com, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          rsalvaterra@gmail.com, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <alpine.DEB.2.21.1907250810530.1791@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907250810530.1791@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/hpet: Undo the early counter is counting check
Git-Commit-ID: 643d83f0a3518d6fbcf88f970de0340a5aa6b5a2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=1.8 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  643d83f0a3518d6fbcf88f970de0340a5aa6b5a2
Gitweb:     https://git.kernel.org/tip/643d83f0a3518d6fbcf88f970de0340a5aa6b5a2
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Jul 2019 08:28:45 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 12:21:32 +0200

x86/hpet: Undo the early counter is counting check

Rui reported that on a Pentium D machine which has HPET forced enabled
because it is not advertised by ACPI, the early counter is counting check
leads to a silent boot hang.

The reason is that the ordering of checking the counter first and then
reconfiguring the HPET fails to work on that machine. As the HPET is not
advertised and presumably not initialized by the BIOS the early enable and
the following reconfiguration seems to bring it into a broken state. Adding
clocksource=jiffies to the command line results in the following
clocksource watchdog warning:

  clocksource: timekeeping watchdog on CPU1:
  Marking clocksource 'tsc-early' as unstable because the skew is too large:
  clocksource:  'hpet' wd_now: 33 wd_last: 33 mask: ffffffff

That clearly shows that the HPET is not counting after it got reconfigured
and reenabled. If the counter is not working then the HPET timer is not
expiring either, which explains the boot hang.

Move the counter is counting check after the full configuration again to
unbreak these systems.

Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
Fixes: 3222daf970f3 ("x86/hpet: Separate counter check out of clocksource register code")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1907250810530.1791@nanos.tec.linutronix.de

---
 arch/x86/kernel/hpet.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index c43e96a938d0..c6f791bc481e 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -827,10 +827,6 @@ int __init hpet_enable(void)
 	if (!hpet_cfg_working())
 		goto out_nohpet;
 
-	/* Validate that the counter is counting */
-	if (!hpet_counting())
-		goto out_nohpet;
-
 	/*
 	 * Read the period and check for a sane value:
 	 */
@@ -896,6 +892,14 @@ int __init hpet_enable(void)
 	}
 	hpet_print_config();
 
+	/*
+	 * Validate that the counter is counting. This needs to be done
+	 * after sanitizing the config registers to properly deal with
+	 * force enabled HPETs.
+	 */
+	if (!hpet_counting())
+		goto out_nohpet;
+
 	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
 
 	if (id & HPET_ID_LEGSUP) {
