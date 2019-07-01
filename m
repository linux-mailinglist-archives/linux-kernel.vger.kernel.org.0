Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 721BD1E54C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 00:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfENWsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 18:48:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfENWsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:48:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECA7681F11;
        Tue, 14 May 2019 22:48:06 +0000 (UTC)
Received: from treble.redhat.com (ovpn-123-166.rdu2.redhat.com [10.10.123.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF894608A7;
        Tue, 14 May 2019 22:48:05 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Raphael Gault <raphael.gault@arm.com>
Subject: [PATCH] objtool: Fix whitelist documentation typo
Date:   Tue, 14 May 2019 17:47:46 -0500
Message-Id: <522362a1b934ee39d0af0abb231f68e160ecf1a8.1557874043.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 14 May 2019 22:48:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

The directive specified in the documentation to add an exception
for a single file in a Makefile was inverted.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
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
 
-- 
2.17.2

