Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD2AB1C614
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 11:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfENJdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 05:33:04 -0400
Received: from foss.arm.com ([217.140.101.70]:52914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfENJdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:33:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2EC2374;
        Tue, 14 May 2019 02:33:03 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FC633F703;
        Tue, 14 May 2019 02:33:02 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        Raphael Gault <raphael.gault@arm.com>
Subject: [PATCH] objtool: doc: Fix one-file exception Makefile directive
Date:   Tue, 14 May 2019 10:32:43 +0100
Message-Id: <20190514093243.17356-1-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The directive specified in the documentation to add an exception
for a single file in a Makefile was inverted.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
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
2.17.1

