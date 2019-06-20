Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F104D28D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 17:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfFTPz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 11:55:59 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:44988 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726551AbfFTPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:55:59 -0400
Received: (qmail 4721 invoked by uid 2102); 20 Jun 2019 11:55:58 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Jun 2019 11:55:58 -0400
Date:   Thu, 20 Jun 2019 11:55:58 -0400 (EDT)
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
cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] tools: memory-model: Improve data-race detection
Message-ID: <Pine.LNX.4.44L0.1906201153470.1512-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu recently reported a problem concerning RCU and compiler
barriers.  In the course of discussing the problem, he put forth a
litmus test which illustrated a serious defect in the Linux Kernel
Memory Model's data-race-detection code.

The defect was that the LKMM assumed visibility and executes-before
ordering of plain accesses had to be mediated by marked accesses.  In
Herbert's litmus test this wasn't so, and the LKMM claimed the litmus
test was allowed and contained a data race although neither is true.

In fact, plain accesses can be ordered by fences even in the absence
of marked accesses.  In most cases this doesn't matter, because most
fences only order accesses within a single thread.  But the rcu-fence
relation is different; it can order (and induce visibility between)
accesses in different threads -- events which otherwise might be
concurrent.  This makes it relevant to data-race detection.

This patch makes two changes to the memory model to incorporate the
new insight:

	If a store is separated by a fence from another access,
	the store is necessarily visible to the other access (as
	reflected in the ww-vis and wr-vis relations).  Similarly,
	if a load is separated by a fence from another access then
	the load necessarily executes before the other access (as
	reflected in the rw-xbstar relation).

	If a store is separated by a strong fence from a marked access
	then it is necessarily visible to any access that executes
	after the marked access (as reflected in the ww-vis and wr-vis
	relations).

With these changes, the LKMM gives the desired result for Herbert's
litmus test and other related ones.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: Herbert Xu <herbert@gondor.apana.org.au>

---


 tools/memory-model/linux-kernel.cat |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: usb-devel/tools/memory-model/linux-kernel.cat
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.cat
+++ usb-devel/tools/memory-model/linux-kernel.cat
@@ -181,9 +181,11 @@ let r-post-bounded = (nonrw-fence | ([~N
 	[Marked]
 
 (* Visibility and executes-before for plain accesses *)
-let ww-vis = w-post-bounded ; vis ; w-pre-bounded
-let wr-vis = w-post-bounded ; vis ; r-pre-bounded
-let rw-xbstar = r-post-bounded ; xbstar ; w-pre-bounded
+let ww-vis = fence | (strong-fence ; xbstar ; w-pre-bounded) |
+	(w-post-bounded ; vis ; w-pre-bounded)
+let wr-vis = fence | (strong-fence ; xbstar ; r-pre-bounded) |
+	(w-post-bounded ; vis ; r-pre-bounded)
+let rw-xbstar = fence | (r-post-bounded ; xbstar ; w-pre-bounded)
 
 (* Potential races *)
 let pre-race = ext & ((Plain * M) | ((M \ IW) * Plain))


