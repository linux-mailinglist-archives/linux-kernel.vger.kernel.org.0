Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F1117E96
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 04:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLJD4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 22:56:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfLJD4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:56:48 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B10892465C;
        Tue, 10 Dec 2019 03:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950208;
        bh=kszLF0bT7aHHUG9zA3c6FJ6o71gT16dHrEBieWTigng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ngOj1QsnKGkCZuTnMzSmkk+sYCEJWaE8bRTVgoyvJNA9ID1JkYFyEuQClh4J+OJPQ
         wwq77yjcFZL4w2HalJxSfHHEOnfL5xrcT4auXDVcfOHOEnmX4WMRS0qZwvRG42JyGi
         MyOqN9H7wGRAjKEx4sMr+sO4jjod+MUkhZWQc6hg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 7/7] doc: Fix typo s/deference/dereference/
Date:   Mon,  9 Dec 2019 19:56:41 -0800
Message-Id: <20191210035641.2226-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210035539.GA792@paulmck-ThinkPad-P72>
References: <20191210035539.GA792@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/lockdep-splat.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/lockdep-splat.txt b/Documentation/RCU/lockdep-splat.txt
index 9c01597..b809631 100644
--- a/Documentation/RCU/lockdep-splat.txt
+++ b/Documentation/RCU/lockdep-splat.txt
@@ -99,7 +99,7 @@ With this change, the rcu_dereference() is always within an RCU
 read-side critical section, which again would have suppressed the
 above lockdep-RCU splat.
 
-But in this particular case, we don't actually deference the pointer
+But in this particular case, we don't actually dereference the pointer
 returned from rcu_dereference().  Instead, that pointer is just compared
 to the cic pointer, which means that the rcu_dereference() can be replaced
 by rcu_access_pointer() as follows:
-- 
2.9.5

