Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6482E569ED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 15:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfFZNCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 09:02:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52869 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfFZNCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:02:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QD1wb94112599
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 06:01:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QD1wb94112599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561554119;
        bh=yMmk8ykP/C1JWXtn85RFTmjDLXSuOAk8SWFSlCS4M6w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gCari+FqnJJjk+eY18kg/RmsJDgXdEhX1vabzMAPVGkAIDzwHLhaRpFlmEFeyBQ5W
         lE33zzcpsHGdX0rYKbZ739bxWeApqdAJES58XF7gGPnDoXyDgdy/9tTK3QXA6bW/Vr
         Y5iDmDqGF0tauXbcpmdhsFFMvSC0Q/DeMhAZB2TWS4LSxnJkW3AtwuLwt5TCmSL5bb
         lRe5wpxdZorv4tYj1D3jRBPDvvphHBBF8KAGaPXNv4L7v4YqZtyLHAU9npf84F5rwr
         dwpn7REpuWFz8DtK1xCPOXwyx9mEyuTrO3a2NkMF86ae7mrXKaXJ2nLiexD41Xd0iZ
         L0DBpYct8gCmw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QD1w464112596;
        Wed, 26 Jun 2019 06:01:58 -0700
Date:   Wed, 26 Jun 2019 06:01:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ferdinand Blomqvist <tipbot@zytor.com>
Message-ID: <tip-2034a42d1747fc1e1eeef2c6f1789c4d0762cb9c@git.kernel.org>
Cc:     mingo@kernel.org, ferdinand.blomqvist@gmail.com,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
          ferdinand.blomqvist@gmail.com, tglx@linutronix.de,
          mingo@kernel.org
In-Reply-To: <20190620141039.9874-3-ferdinand.blomqvist@gmail.com>
References: <20190620141039.9874-3-ferdinand.blomqvist@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rslib] rslib: Fix decoding of shortened codes
Git-Commit-ID: 2034a42d1747fc1e1eeef2c6f1789c4d0762cb9c
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

Commit-ID:  2034a42d1747fc1e1eeef2c6f1789c4d0762cb9c
Gitweb:     https://git.kernel.org/tip/2034a42d1747fc1e1eeef2c6f1789c4d0762cb9c
Author:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
AuthorDate: Thu, 20 Jun 2019 17:10:34 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 14:55:45 +0200

rslib: Fix decoding of shortened codes

The decoding of shortenend codes is broken. It only works as expected if
there are no erasures.

When decoding with erasures, Lambda (the error and erasure locator
polynomial) is initialized from the given erasure positions. The pad
parameter is not accounted for by the initialisation code, and hence
Lambda is initialized from incorrect erasure positions.

The fix is to adjust the erasure positions by the supplied pad.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190620141039.9874-3-ferdinand.blomqvist@gmail.com

---
 lib/reed_solomon/decode_rs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 1db74eb098d0..3313bf944ff1 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -99,9 +99,9 @@
 	if (no_eras > 0) {
 		/* Init lambda to be the erasure locator polynomial */
 		lambda[1] = alpha_to[rs_modnn(rs,
-					      prim * (nn - 1 - eras_pos[0]))];
+					prim * (nn - 1 - (eras_pos[0] + pad)))];
 		for (i = 1; i < no_eras; i++) {
-			u = rs_modnn(rs, prim * (nn - 1 - eras_pos[i]));
+			u = rs_modnn(rs, prim * (nn - 1 - (eras_pos[i] + pad)));
 			for (j = i + 1; j > 0; j--) {
 				tmp = index_of[lambda[j - 1]];
 				if (tmp != nn) {
