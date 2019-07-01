Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAEC2C36C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 11:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfE1Jld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 05:41:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:8912 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfE1Jlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:41:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 02:41:31 -0700
X-ExtLoop1: 1
Received: from ideak-desk.fi.intel.com ([10.237.72.204])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2019 02:41:29 -0700
From:   Imre Deak <imre.deak@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3 2/2] lockdep: Fix merging of hlocks with non-zero references
Date:   Tue, 28 May 2019 12:40:51 +0300
Message-Id: <20190528094051.22840-2-imre.deak@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528094051.22840-1-imre.deak@intel.com>
References: <20190528094051.22840-1-imre.deak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sequence

	static DEFINE_WW_CLASS(test_ww_class);

	struct ww_acquire_ctx ww_ctx;
	struct ww_mutex ww_lock_a;
	struct ww_mutex ww_lock_b;
	struct ww_mutex ww_lock_c;
	struct mutex lock_c;

	ww_acquire_init(&ww_ctx, &test_ww_class);

	ww_mutex_init(&ww_lock_a, &test_ww_class);
	ww_mutex_init(&ww_lock_b, &test_ww_class);
	ww_mutex_init(&ww_lock_c, &test_ww_class);

	mutex_init(&lock_c);

	ww_mutex_lock(&ww_lock_a, &ww_ctx);

	mutex_lock(&lock_c);

	ww_mutex_lock(&ww_lock_b, &ww_ctx);
	ww_mutex_lock(&ww_lock_c, &ww_ctx);

	mutex_unlock(&lock_c);	(*)

	ww_mutex_unlock(&ww_lock_c);
	ww_mutex_unlock(&ww_lock_b);
	ww_mutex_unlock(&ww_lock_a);

	ww_acquire_fini(&ww_ctx); (**)

will trigger the following error in __lock_release() when calling
mutex_release() at **:

	DEBUG_LOCKS_WARN_ON(depth <= 0)

The problem is that the hlock merging happening at * updates the
references for test_ww_class incorrectly to 3 whereas it should've
updated it to 4 (representing all the instances for ww_ctx and
ww_lock_[abc]).

Fix this by updating the references during merging correctly taking into
account that we can have non-zero references (both for the hlock that we
merge into another hlock or for the hlock we are merging into).

v2: (Peter)
- Rebase on latest upstream tree.
- Sanitize overflow check and hlock_references() helper.

Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 kernel/locking/lockdep.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7a48649ce6bc..1aa6dff3c12c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3638,6 +3638,11 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
 
+static inline int hlock_references(struct held_lock *hlock)
+{
+	return hlock->references ? : 1;
+}
+
 /*
  * This gets called for every mutex_lock*()/spin_lock*() operation.
  * We maintain the dependency maps and validate the locking attempt:
@@ -3703,17 +3708,14 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (depth) {
 		hlock = curr->held_locks + depth - 1;
 		if (hlock->class_idx == class_idx && nest_lock) {
-			if (hlock->references) {
-				/*
-				 * Check: unsigned int references:12, overflow.
-				 */
-				if (DEBUG_LOCKS_WARN_ON(hlock->references == (1 << 12)-1))
-					return 0;
+			if (!references)
+				references++;
 
-				hlock->references++;
-			} else {
-				hlock->references = 2;
-			}
+			hlock->references = hlock_references(hlock) + references;
+
+			/* Overflow */
+			if (DEBUG_LOCKS_WARN_ON(hlock->references < references))
+				return 0;
 
 			return 2;
 		}
-- 
2.17.1

