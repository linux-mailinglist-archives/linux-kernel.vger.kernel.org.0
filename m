Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8D25EB93
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 20:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGCS2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 14:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGCS2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:28:03 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3429D21881;
        Wed,  3 Jul 2019 18:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562178482;
        bh=eBN4mmk5SO6nzUNbiLEwFOz2XI0YOWn48fJDaCxnD7k=;
        h=From:To:Cc:Subject:Date:From;
        b=ex5vVhMthGRa6AIn+ngehgQ6iAj7cqGauVmiyt7SSm88hrdNt1vDvTaSijYx+KtgE
         Bqq9u7CRckCp0p3+fG3NXDbnAWl/YUWH3cf8jApOL6f/gb62Vnk8kc220ucd5s0rWG
         EZmxL3tgujixznxpDR1dtnIo6xaruvxOfSZ6f3mc=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH] selftests/x86: Don't muck with ftrace in mpx_mini_test
Date:   Wed,  3 Jul 2019 11:28:00 -0700
Message-Id: <b971a6c04687d4ba1a07bae6c455c2313f91acc0.1562178460.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know why mpx_mini_test tries to reprogram ftrace, but it
seems rude and it makes the test crash if run as non-root.  Comment
it out.

Cc: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/mpx-mini-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/mpx-mini-test.c b/tools/testing/selftests/x86/mpx-mini-test.c
index 23ddd453f362..07461ce31d90 100644
--- a/tools/testing/selftests/x86/mpx-mini-test.c
+++ b/tools/testing/selftests/x86/mpx-mini-test.c
@@ -76,9 +76,9 @@ void trace_me(void)
 	write_pid_to("common_pid=", TED "exceptions/filter");
 	write_int_to("", TED "signal/enable", 1);
 	write_int_to("", TED "exceptions/enable", 1);
-*/
 	write_pid_to("", "/sys/kernel/debug/tracing/set_ftrace_pid");
 	write_int_to("", "/sys/kernel/debug/tracing/trace", 0);
+*/
 }
 
 #define test_failed() __test_failed(__FILE__, __LINE__)
-- 
2.21.0

