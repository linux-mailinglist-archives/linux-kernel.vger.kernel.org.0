Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5880569EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 15:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfFZNDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 09:03:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43235 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZNDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:03:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QD3Qql4112955
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 06:03:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QD3Qql4112955
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561554206;
        bh=YsA/35nUq1Spshero43DkEYwlVhYY1/6CwSQgPbXGc0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nJmy2ntPPZwcS2Yv5O4Qm5pNO/f9tOV4lWkw2S3kFexmZqkNgRtOaDxvAWWutDu5a
         07p6/ZawvzfZ7yDj0MO5239n7xKtDOYLcrNt7FzgfHKpuql3LATu5y0tF5GGoyfYkI
         YUsdvq+2EKefnd1V+5tBjffoCa8TumzhSxSdfhRHOoChV2YZ75JX2dg2oF4rAMJMR+
         rn3rZqaeYrMiDsK002tuBcPbpJeZ19gNDKG+F17ttQggW1lsveb23Y4cGwsQyGf1Yp
         OM+ZCgHugJDsIzLUvmF9QnsUX1MbtipE9lH4oUbFBirYy5g1+J2/1EhViCC/MsuNxL
         NbbrK0/VQHpkg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QD3Pb44112945;
        Wed, 26 Jun 2019 06:03:25 -0700
Date:   Wed, 26 Jun 2019 06:03:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ferdinand Blomqvist <tipbot@zytor.com>
Message-ID: <tip-647cc9ece63fdba573a31bdafa54fb2d388c3c83@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, ferdinand.blomqvist@gmail.com
Reply-To: hpa@zytor.com, ferdinand.blomqvist@gmail.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190620141039.9874-5-ferdinand.blomqvist@gmail.com>
References: <20190620141039.9874-5-ferdinand.blomqvist@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rslib] rslib: decode_rs: Code cleanup
Git-Commit-ID: 647cc9ece63fdba573a31bdafa54fb2d388c3c83
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

Commit-ID:  647cc9ece63fdba573a31bdafa54fb2d388c3c83
Gitweb:     https://git.kernel.org/tip/647cc9ece63fdba573a31bdafa54fb2d388c3c83
Author:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
AuthorDate: Thu, 20 Jun 2019 17:10:36 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 14:55:46 +0200

rslib: decode_rs: Code cleanup

Nothing useful was done after the finish label when count is negative so
return directly instead of jumping to finish.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190620141039.9874-5-ferdinand.blomqvist@gmail.com

---
 lib/reed_solomon/decode_rs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 22006eaa41e6..78629bbe6590 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -88,8 +88,7 @@
 		/* if syndrome is zero, data[] is a codeword and there are no
 		 * errors to correct. So return data[] unmodified
 		 */
-		count = 0;
-		goto finish;
+		return 0;
 	}
 
  decode:
@@ -202,8 +201,7 @@
 		 * deg(lambda) unequal to number of roots => uncorrectable
 		 * error detected
 		 */
-		count = -EBADMSG;
-		goto finish;
+		return -EBADMSG;
 	}
 	/*
 	 * Compute err+eras evaluator poly omega(x) = s(x)*lambda(x) (modulo
@@ -261,7 +259,6 @@
 		}
 	}
 
-finish:
 	if (eras_pos != NULL) {
 		for (i = 0; i < count; i++)
 			eras_pos[i] = loc[i] - pad;
