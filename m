Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80A42F82F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 23:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfKKWfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 17:35:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60075 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfKKWft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:35:49 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUIHj-0000vD-Gs; Mon, 11 Nov 2019 23:35:47 +0100
Message-Id: <20191111223052.697071210@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 23:03:26 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [patch V2 12/16] selftests/x86/ioperm: Extend testing so the shared
 bitmap is exercised
References: <20191111220314.519933535@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add code to the fork path which forces the shared bitmap to be duplicated
and the reference count to be dropped. Verify that the child modifications
did not affect the parent.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 tools/testing/selftests/x86/ioperm.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/x86/ioperm.c
+++ b/tools/testing/selftests/x86/ioperm.c
@@ -131,6 +131,17 @@ int main(void)
 		printf("[RUN]\tchild: check that we inherited permissions\n");
 		expect_ok(0x80);
 		expect_gp(0xed);
+		printf("[RUN]\tchild: Extend permissions to 0x81\n");
+		if (ioperm(0x81, 1, 1) != 0) {
+			printf("[FAIL]\tioperm(0x81, 1, 1) failed (%d)", errno);
+			return 1;
+		}
+		printf("[RUN]\tchild: Drop permissions to 0x80\n");
+		if (ioperm(0x80, 1, 0) != 0) {
+			printf("[FAIL]\tioperm(0x80, 1, 0) failed (%d)", errno);
+			return 1;
+		}
+		expect_gp(0x80);
 		return 0;
 	} else {
 		int status;
@@ -146,8 +157,11 @@ int main(void)
 		}
 	}
 
-	/* Test the capability checks. */
+	/* Verify that the child dropping 0x80 did not affect the parent */
+	printf("\tVerify that unsharing the bitmap worked\n");
+	expect_ok(0x80);
 
+	/* Test the capability checks. */
 	printf("\tDrop privileges\n");
 	if (setresuid(1, 1, 1) != 0) {
 		printf("[WARN]\tDropping privileges failed\n");


