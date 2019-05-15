Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA121E817
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 08:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfEOGCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 02:02:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56365 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOGCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:02:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4F62B3i166122
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 14 May 2019 23:02:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4F62B3i166122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557900132;
        bh=zHQYZBWI+UdjEXZ9Mz1cMpJ3XVTkUk6izcRaaZYRy5w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Yprz12CUn60tyChl9iw04WF4jp/LCb9lNbsvLbX945VUHBxSTKdMCGX1F8k1BkeoA
         txP6iwEvPWyS0TdNfYS+JM3RFysj7Ni8GBNB0lIQOMYulzcGWo77QcI4ngZ2C70pmU
         CCBFbW5pSNmkOZCMK59KZEtynM7nviO/mwWDQgFpURhQBfAusSiTAX4+HfSGOcq8qH
         n+9HoswUAVtODcCNkZmxFx+SkPwNNSrzVjN4iAYEsiyxWH3gT4XHUuMwAwhnh4sq0D
         17pALd5XdyfUFBhy49AK3CtOwbqbNJU+LYh+PwXavjQqo6G4kE0I/AU0mMkoIafXg6
         zDW0neHweql/w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4F62B5j166119;
        Tue, 14 May 2019 23:02:11 -0700
Date:   Tue, 14 May 2019 23:02:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Raphael Gault <tipbot@zytor.com>
Message-ID: <tip-2decec48b0fd28ffdbf4cc684bd04e735f0839dd@git.kernel.org>
Cc:     hpa@zytor.com, torvalds@linux-foundation.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, jpoimboe@redhat.com,
        raphael.gault@arm.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
          peterz@infradead.org, mingo@kernel.org, jpoimboe@redhat.com,
          raphael.gault@arm.com, linux-kernel@vger.kernel.org
In-Reply-To: <522362a1b934ee39d0af0abb231f68e160ecf1a8.1557874043.git.jpoimboe@redhat.com>
References: <522362a1b934ee39d0af0abb231f68e160ecf1a8.1557874043.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Fix whitelist documentation typo
Git-Commit-ID: 2decec48b0fd28ffdbf4cc684bd04e735f0839dd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        T_DATE_IN_FUTURE_96_Q autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2decec48b0fd28ffdbf4cc684bd04e735f0839dd
Gitweb:     https://git.kernel.org/tip/2decec48b0fd28ffdbf4cc684bd04e735f0839dd
Author:     Raphael Gault <raphael.gault@arm.com>
AuthorDate: Tue, 14 May 2019 17:47:46 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 15 May 2019 07:57:50 +0200

objtool: Fix whitelist documentation typo

The directive specified in the documentation to add an exception
for a single file in a Makefile was inverted.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/522362a1b934ee39d0af0abb231f68e160ecf1a8.1557874043.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/Documentation/stack-validation.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
index 3995735a878f..cd17ee022072 100644
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -306,7 +306,7 @@ ignore it:
 
 - To skip validation of a file, add
 
-    OBJECT_FILES_NON_STANDARD_filename.o := n
+    OBJECT_FILES_NON_STANDARD_filename.o := y
 
   to the Makefile.
 
