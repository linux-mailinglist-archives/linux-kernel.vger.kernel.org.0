Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1885569F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 15:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfFZNEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 09:04:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47389 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZNEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:04:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QD49si4114606
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 06:04:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QD49si4114606
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561554249;
        bh=KtxY5Wka3hwoP3Ovfl3Ckf4YVnAZn5qUfm69TgUEqPo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=vMI4r8pk/yB2/V1BNPuMsfAUjM3CguuSTnMl63KOD8Y1xLtVgO/Ihl5qT1WBvVSQH
         avF+nnZbTrlLGlw/exdDd49Yruw48Y0QebVqB+cd6FbwlzFeWQidfFEMaxEXOiLq9k
         cKJlND323KumSNbrA5KJC5CHbkVtaHJQ9R4joFFsnV9TaTvR1/e2wr2mSvHrnjScN0
         bSBYX5kK/NwEDTPgCrQhqdBWOkj/S71jUyMOx8wg8fhsR8epOUe+d0rgXuItQi6/lF
         E1J2MyeP8U/hVnL/T0LMUOk7F+L5vDMtLs5ne13QAreli2IPoorWGAZPz7FAyfPlwe
         ANpJC0eqYb89g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QD49f14114603;
        Wed, 26 Jun 2019 06:04:09 -0700
Date:   Wed, 26 Jun 2019 06:04:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ferdinand Blomqvist <tipbot@zytor.com>
Message-ID: <tip-ef4d6a8556b637ad27c8c2a2cff1dda3da38e9a9@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        ferdinand.blomqvist@gmail.com, mingo@kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          ferdinand.blomqvist@gmail.com, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20190620141039.9874-6-ferdinand.blomqvist@gmail.com>
References: <20190620141039.9874-6-ferdinand.blomqvist@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rslib] rslib: Fix handling of of caller provided syndrome
Git-Commit-ID: ef4d6a8556b637ad27c8c2a2cff1dda3da38e9a9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=2.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no
        version=3.4.2
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ef4d6a8556b637ad27c8c2a2cff1dda3da38e9a9
Gitweb:     https://git.kernel.org/tip/ef4d6a8556b637ad27c8c2a2cff1dda3da38e9a9
Author:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
AuthorDate: Thu, 20 Jun 2019 17:10:37 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 14:55:47 +0200

rslib: Fix handling of of caller provided syndrome

Check if the syndrome provided by the caller is zero, and act
accordingly.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190620141039.9874-6-ferdinand.blomqvist@gmail.com

---
 lib/reed_solomon/decode_rs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 78629bbe6590..b7264a712d46 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -42,8 +42,18 @@
 	BUG_ON(pad < 0 || pad >= nn - nroots);
 
 	/* Does the caller provide the syndrome ? */
-	if (s != NULL)
-		goto decode;
+	if (s != NULL) {
+		for (i = 0; i < nroots; i++) {
+			/* The syndrome is in index form,
+			 * so nn represents zero
+			 */
+			if (s[i] != nn)
+				goto decode;
+		}
+
+		/* syndrome is zero, no errors to correct  */
+		return 0;
+	}
 
 	/* form the syndromes; i.e., evaluate data(x) at roots of
 	 * g(x) */
