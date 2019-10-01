Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50AA3C3ECB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 19:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfJARjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 13:39:49 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48948 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726063AbfJARjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:39:48 -0400
Received: (qmail 5988 invoked by uid 2102); 1 Oct 2019 13:39:47 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Oct 2019 13:39:47 -0400
Date:   Tue, 1 Oct 2019 13:39:47 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
cc:     Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] tools/memory-model/Documentation: Fix typos in
 explanation.txt
Message-ID: <Pine.LNX.4.44L0.1910011331320.1991-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a few minor typos and improves word usage in a few
places in the Linux Kernel Memory Model's explanation.txt file.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

 tools/memory-model/Documentation/explanation.txt |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: usb-devel/tools/memory-model/Documentation/explanation.txt
===================================================================
--- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
+++ usb-devel/tools/memory-model/Documentation/explanation.txt
@@ -206,7 +206,7 @@ goes like this:
 	P0 stores 1 to buf before storing 1 to flag, since it executes
 	its instructions in order.
 
-	Since an instruction (in this case, P1's store to flag) cannot
+	Since an instruction (in this case, P0's store to flag) cannot
 	execute before itself, the specified outcome is impossible.
 
 However, real computer hardware almost never follows the Sequential
@@ -419,7 +419,7 @@ example:
 
 The object code might call f(5) either before or after g(6); the
 memory model cannot assume there is a fixed program order relation
-between them.  (In fact, if the functions are inlined then the
+between them.  (In fact, if the function calls are inlined then the
 compiler might even interleave their object code.)
 
 
@@ -499,7 +499,7 @@ different CPUs (external reads-from, or
 
 For our purposes, a memory location's initial value is treated as
 though it had been written there by an imaginary initial store that
-executes on a separate CPU before the program runs.
+executes on a separate CPU before the main program runs.
 
 Usage of the rf relation implicitly assumes that loads will always
 read from a single store.  It doesn't apply properly in the presence
@@ -955,7 +955,7 @@ atomic update.  This is what the LKMM's
 THE PRESERVED PROGRAM ORDER RELATION: ppo
 -----------------------------------------
 
-There are many situations where a CPU is obligated to execute two
+There are many situations where a CPU is obliged to execute two
 instructions in program order.  We amalgamate them into the ppo (for
 "preserved program order") relation, which links the po-earlier
 instruction to the po-later instruction and is thus a sub-relation of
@@ -1572,7 +1572,7 @@ and there are events X, Y and a read-sid
 
 	2. X comes "before" Y in some sense (including rfe, co and fr);
 
-	2. Y is po-before Z;
+	3. Y is po-before Z;
 
 	4. Z is the rcu_read_unlock() event marking the end of C;
 


