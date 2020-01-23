Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70A3146601
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 11:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgAWK4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 05:56:32 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46578 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgAWK4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:56:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so1181471pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 02:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oByV9jS19XUdDiBoEYoJppft+pgA1ruNja8UqbGBYtw=;
        b=p0zZUQK2o/KCW+4o30fIUN/lMhc5wyk7rjFxdymsD/9yKOtL0dQKQ/kr6sGmDp4e8i
         y/7WfkxJYlFwKSkEHXAU+SW4rYNA/FXQZyFsoapCTKYlV8d/ZE0d6crs1SL2hesLhb/Y
         jXlH5F0IZ3JbsHNAS2FU454q+7flFQi4R67AJCAhkFTxWWCngxmnxIYXDO4CXdbquvv/
         PK/kNk4ZPWf2uVgmytCoGxMBM9s6h4kaOidhHg6+YvFJBLNNqm8nBrzv0Mr+Zu1Kzoq6
         4B5UUZi+lIvnBvPU8clHQK+RT8FjD/dRXnuHjbfzu38ODMV9JNh9onPCzShZG5AWsI8A
         9afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oByV9jS19XUdDiBoEYoJppft+pgA1ruNja8UqbGBYtw=;
        b=HlWTvbJN3OfcaCu3gc5kUgf7HrLYcjPm672GiKBMRjz7VwquceldUyTnbDBlO9j5m4
         23ljOm6cK4q4JjKO6Jx5qrDBpMNzojMo3wmse484KxJx1IS1L35P58WiB/vZlla0YeKj
         LtmaYQEYOaSYJnKs1uOuyibKAzMiYfQrfnQi0WC8bX/Vqei/8NNHms5HhfiPLSJ1wZ4g
         4xjmZTT0wKVKzMhLXx/iFB+qi85w/t5wTOaT7rgHaBvzJiFiPSZFOAq6WAgL81l96TLB
         QYTzxKs7YzL9Ifmv7pLqVd19K3TqXEFhYjORQtQ9VnnmsATgbS4gzZr9/fdHXpG77vOp
         +1ig==
X-Gm-Message-State: APjAAAWX7WAMlnBU8YDG9qsu2qy5eZVe1Rt1f+ZtzEt7tF9kdiPTZAVC
        9JFwxMAWzweujJF+25bVfIE=
X-Google-Smtp-Source: APXvYqzYIpqVZym13Fd2MB5wj2VVWikRKu0vfV9+28NKjwFVyXeKLBxAYZ05+RHiR8v10ZxV8HpliA==
X-Received: by 2002:a17:90a:e646:: with SMTP id ep6mr4049302pjb.58.1579776991167;
        Thu, 23 Jan 2020 02:56:31 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.138])
        by smtp.googlemail.com with ESMTPSA id m71sm5441372pje.0.2020.01.23.02.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 02:56:30 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] lockdep: Pass lockdep expression to RCU lists
Date:   Thu, 23 Jan 2020 16:24:42 +0530
Message-Id: <20200123105441.22182-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data is traversed using hlist_for_each_entry_rcu outside an
RCU read-side critical section but under the protection
of either lockdep_lock or with irqs disabled.

Hence, add corresponding lockdep expression to silence false-positive
lockdep warnings, and harden RCU lists. Also add macro for
corresponding lockdep expression.

Two things to note:
- RCU traversals protected under both, irqs disabled and
graph lock, have both the checks in the lockdep expression.
- RCU traversals under the protection of just disabled irqs
don't have a corresponding lockdep expression as it is implicitly
checked for.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 kernel/locking/lockdep.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 32282e7112d3..696ad5d4daed 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -85,6 +85,8 @@ module_param(lock_stat, int, 0644);
  * code to recurse back into the lockdep code...
  */
 static arch_spinlock_t lockdep_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+#define graph_lock_held() \
+	arch_spin_is_locked(&lockdep_lock)
 static struct task_struct *lockdep_selftest_task_struct;
 
 static int graph_lock(void)
@@ -1009,7 +1011,7 @@ static bool __check_data_structures(void)
 	/* Check the chain_key of all lock chains. */
 	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
 		head = chainhash_table + i;
-		hlist_for_each_entry_rcu(chain, head, entry) {
+		hlist_for_each_entry_rcu(chain, head, entry, graph_lock_held()) {
 			if (!check_lock_chain_key(chain))
 				return false;
 		}
@@ -1124,7 +1126,8 @@ void lockdep_register_key(struct lock_class_key *key)
 	raw_local_irq_save(flags);
 	if (!graph_lock())
 		goto restore_irqs;
-	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+	hlist_for_each_entry_rcu(k, hash_head, hash_entry,
+				 irqs_disabled() && graph_lock_held()) {
 		if (WARN_ON_ONCE(k == key))
 			goto out_unlock;
 	}
@@ -1203,7 +1206,8 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	 * We have to do the hash-walk again, to avoid races
 	 * with another CPU:
 	 */
-	hlist_for_each_entry_rcu(class, hash_head, hash_entry) {
+	hlist_for_each_entry_rcu(class, hash_head, hash_entry,
+				 irqs_disabled() && graph_lock_held()) {
 		if (class->key == key)
 			goto out_unlock_set;
 	}
@@ -2858,7 +2862,7 @@ static inline struct lock_chain *lookup_chain_cache(u64 chain_key)
 	struct hlist_head *hash_head = chainhashentry(chain_key);
 	struct lock_chain *chain;
 
-	hlist_for_each_entry_rcu(chain, hash_head, entry) {
+	hlist_for_each_entry_rcu(chain, hash_head, entry, graph_lock_held()) {
 		if (READ_ONCE(chain->chain_key) == chain_key) {
 			debug_atomic_inc(chain_lookup_hits);
 			return chain;
@@ -4833,7 +4837,7 @@ static void remove_class_from_lock_chains(struct pending_free *pf,
 
 	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
 		head = chainhash_table + i;
-		hlist_for_each_entry_rcu(chain, head, entry) {
+		hlist_for_each_entry_rcu(chain, head, entry, graph_lock_held()) {
 			remove_class_from_lock_chain(pf, chain, class);
 		}
 	}
@@ -4993,7 +4997,7 @@ static void __lockdep_free_key_range(struct pending_free *pf, void *start,
 	/* Unhash all classes that were created by a module. */
 	for (i = 0; i < CLASSHASH_SIZE; i++) {
 		head = classhash_table + i;
-		hlist_for_each_entry_rcu(class, head, hash_entry) {
+		hlist_for_each_entry_rcu(class, head, hash_entry, graph_lock_held()) {
 			if (!within(class->key, start, size) &&
 			    !within(class->name, start, size))
 				continue;
@@ -5076,7 +5080,7 @@ static bool lock_class_cache_is_registered(struct lockdep_map *lock)
 
 	for (i = 0; i < CLASSHASH_SIZE; i++) {
 		head = classhash_table + i;
-		hlist_for_each_entry_rcu(class, head, hash_entry) {
+		hlist_for_each_entry_rcu(class, head, hash_entry, graph_lock_held()) {
 			for (j = 0; j < NR_LOCKDEP_CACHING_CLASSES; j++)
 				if (lock->class_cache[j] == class)
 					return true;
@@ -5181,7 +5185,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		goto out_irq;
 
 	pf = get_pending_free();
-	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+	hlist_for_each_entry_rcu(k, hash_head, hash_entry,
+				 irqs_disabled() && graph_lock_held()) {
 		if (k == key) {
 			hlist_del_rcu(&k->hash_entry);
 			found = true;
-- 
2.24.1

