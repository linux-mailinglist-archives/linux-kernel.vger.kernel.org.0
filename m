Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 319524D28A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 17:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfFTPzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 11:55:37 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:44850 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726551AbfFTPzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:55:37 -0400
Received: (qmail 4690 invoked by uid 2102); 20 Jun 2019 11:55:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Jun 2019 11:55:36 -0400
Date:   Thu, 20 Jun 2019 11:55:36 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
cc:     Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] tools: memory-model: Expand definition of barrier
Message-ID: <Pine.LNX.4.44L0.1906201151210.1512-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 66be4e66a7f4 ("rcu: locking and unlocking need to always be at
least barriers") added compiler barriers back into rcu_read_lock() and
rcu_read_unlock().  Furthermore, srcu_read_lock() and
srcu_read_unlock() have always contained compiler barriers.

The Linux Kernel Memory Model ought to know about these barriers.
This patch adds them into the memory model.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---


 tools/memory-model/linux-kernel.cat |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: usb-devel/tools/memory-model/linux-kernel.cat
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.cat
+++ usb-devel/tools/memory-model/linux-kernel.cat
@@ -47,7 +47,8 @@ let strong-fence = mb | gp
 let nonrw-fence = strong-fence | po-rel | acq-po
 let fence = nonrw-fence | wmb | rmb
 let barrier = fencerel(Barrier | Rmb | Wmb | Mb | Sync-rcu | Sync-srcu |
-		Before-atomic | After-atomic | Acquire | Release) |
+		Before-atomic | After-atomic | Acquire | Release |
+		Rcu-lock | Rcu-unlock | Srcu-lock | Srcu-unlock) |
 	(po ; [Release]) | ([Acquire] ; po)
 
 (**********************************)

