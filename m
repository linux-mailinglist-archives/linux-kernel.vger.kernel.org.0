Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE376F336
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 14:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfGUM2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 08:28:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfGUM2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 08:28:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 422DB3082E24;
        Sun, 21 Jul 2019 12:28:15 +0000 (UTC)
Received: from redhat.com (ovpn-120-23.rdu2.redhat.com [10.10.120.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id DD5C75F7C0;
        Sun, 21 Jul 2019 12:28:06 +0000 (UTC)
Date:   Sun, 21 Jul 2019 08:28:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     paulmck@linux.vnet.ibm.com
Cc:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jasowang@redhat.com,
        jglisse@redhat.com, keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Subject: RFC: call_rcu_outstanding (was Re: WARNING in __mmdrop)
Message-ID: <20190721081933-mutt-send-email-mst@kernel.org>
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721044615-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sun, 21 Jul 2019 12:28:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, others,

So it seems that vhost needs to call kfree_rcu from an ioctl. My worry
is what happens if userspace starts cycling through lots of these
ioctls.  Given we actually use rcu as an optimization, we could just
disable the optimization temporarily - but the question would be how to
detect an excessive rate without working too hard :) .

I guess we could define as excessive any rate where callback is
outstanding at the time when new structure is allocated.  I have very
little understanding of rcu internals - so I wanted to check that the
following more or less implements this heuristic before I spend time
actually testing it.

Could others pls take a look and let me know?

Thanks!

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 477b4eb44af5..067909521d72 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -125,6 +125,25 @@ void synchronize_rcu(void)
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 
+/*
+ * Helpful for rate-limiting kfree_rcu/call_rcu callbacks.
+ */
+bool call_rcu_outstanding(void)
+{
+	unsigned long flags;
+	struct rcu_data *rdp;
+	bool outstanding;
+
+	local_irq_save(flags);
+	rdp = this_cpu_ptr(&rcu_data);
+	outstanding = rcu_segcblist_empty(&rdp->cblist);
+	outstanding = rcu_ctrlblk.donetail != rcu_ctrlblk.curtail;
+	local_irq_restore(flags);
+
+	return outstanding;
+}
+EXPORT_SYMBOL_GPL(call_rcu_outstanding);
+
 /*
  * Post an RCU callback to be invoked after the end of an RCU grace
  * period.  But since we have but one CPU, that would be after any
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a14e5fbbea46..d4b9d61e637d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2482,6 +2482,24 @@ static void rcu_leak_callback(struct rcu_head *rhp)
 {
 }
 
+/*
+ * Helpful for rate-limiting kfree_rcu/call_rcu callbacks.
+ */
+bool call_rcu_outstanding(void)
+{
+	unsigned long flags;
+	struct rcu_data *rdp;
+	bool outstanding;
+
+	local_irq_save(flags);
+	rdp = this_cpu_ptr(&rcu_data);
+	outstanding = rcu_segcblist_empty(&rdp->cblist);
+	local_irq_restore(flags);
+
+	return outstanding;
+}
+EXPORT_SYMBOL_GPL(call_rcu_outstanding);
+
 /*
  * Helper function for call_rcu() and friends.  The cpu argument will
  * normally be -1, indicating "currently running CPU".  It may specify
