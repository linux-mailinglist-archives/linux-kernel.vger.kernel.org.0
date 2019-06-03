Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A511433139
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 15:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfFCNjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 09:39:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48231 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfFCNjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:39:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53Dd1kY611388
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:39:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53Dd1kY611388
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559569142;
        bh=TVQWFkxhRuztGInnayReuqjuBamoVCCGYzS3QHx7cvc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=CoJ1Cf7/znhrJXEj+f6XG6X1L+Vx4BAR5Wz4k8LD+x218eKuC5P2v+duaECEfsV37
         TdeITULo37HsKCzphUtNmrNLJsITBJgHyBssU1Wq28yKCl+1oltH/uTqknbsp1g0os
         cpozoJo89iSZh9mh2Kewtc4aM2gRws2pQI+WIk9TYEtpeE+sLEbqiACu7Fnx+Aqjzn
         GRQHnYyjhNOpUq6sC71D18pJ8caRqL1mNnaFk2S/XMlMx9RFqrB6s75bseJoQbuZIe
         IOjpb4r2PWvm2mCdKi3ipwNC0eVk2ZRtw+BMDXLeZBAKO6vNmAYbRdpokm9l8iJcVH
         c8PKVK1eVweVg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53Dd1u7611385;
        Mon, 3 Jun 2019 06:39:01 -0700
Date:   Mon, 3 Jun 2019 06:39:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-d84e28d250150adc6526dcce4ca089e2b57430f3@git.kernel.org>
Cc:     will.deacon@arm.com, mingo@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, tony.luck@intel.com, hpa@zytor.com,
        fenghua.yu@intel.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
          tony.luck@intel.com, hpa@zytor.com, peterz@infradead.org,
          mark.rutland@arm.com, will.deacon@arm.com, mingo@kernel.org
In-Reply-To: <20190522132250.26499-9-mark.rutland@arm.com>
References: <20190522132250.26499-9-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, ia64: Use s64 for atomic64
Git-Commit-ID: d84e28d250150adc6526dcce4ca089e2b57430f3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d84e28d250150adc6526dcce4ca089e2b57430f3
Gitweb:     https://git.kernel.org/tip/d84e28d250150adc6526dcce4ca089e2b57430f3
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:40 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/atomic, ia64: Use s64 for atomic64

As a step towards making the atomic64 API use consistent types treewide,
let's have the ia64 atomic64 implementation use s64 as the underlying
type for atomic64_t, rather than long or __s64, matching the generated
headers.

As atomic64_read() depends on the generic defintion of atomic64_t, this
still returns long. This will be converted in a subsequent patch.

Otherwise, there should be no functional change as a result of this
patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aou@eecs.berkeley.edu
Cc: arnd@arndb.de
Cc: bp@alien8.de
Cc: catalin.marinas@arm.com
Cc: davem@davemloft.net
Cc: heiko.carstens@de.ibm.com
Cc: herbert@gondor.apana.org.au
Cc: ink@jurassic.park.msu.ru
Cc: jhogan@kernel.org
Cc: linux@armlinux.org.uk
Cc: mattst88@gmail.com
Cc: mpe@ellerman.id.au
Cc: palmer@sifive.com
Cc: paul.burton@mips.com
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: vgupta@synopsys.com
Link: https://lkml.kernel.org/r/20190522132250.26499-9-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/include/asm/atomic.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
index 206530d0751b..50440f3ddc43 100644
--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -124,10 +124,10 @@ ATOMIC_FETCH_OP(xor, ^)
 #undef ATOMIC_OP
 
 #define ATOMIC64_OP(op, c_op)						\
-static __inline__ long							\
-ia64_atomic64_##op (__s64 i, atomic64_t *v)				\
+static __inline__ s64							\
+ia64_atomic64_##op (s64 i, atomic64_t *v)				\
 {									\
-	__s64 old, new;							\
+	s64 old, new;							\
 	CMPXCHG_BUGCHECK_DECL						\
 									\
 	do {								\
@@ -139,10 +139,10 @@ ia64_atomic64_##op (__s64 i, atomic64_t *v)				\
 }
 
 #define ATOMIC64_FETCH_OP(op, c_op)					\
-static __inline__ long							\
-ia64_atomic64_fetch_##op (__s64 i, atomic64_t *v)			\
+static __inline__ s64							\
+ia64_atomic64_fetch_##op (s64 i, atomic64_t *v)				\
 {									\
-	__s64 old, new;							\
+	s64 old, new;							\
 	CMPXCHG_BUGCHECK_DECL						\
 									\
 	do {								\
@@ -162,7 +162,7 @@ ATOMIC64_OPS(sub, -)
 
 #define atomic64_add_return(i,v)					\
 ({									\
-	long __ia64_aar_i = (i);					\
+	s64 __ia64_aar_i = (i);						\
 	__ia64_atomic_const(i)						\
 		? ia64_fetch_and_add(__ia64_aar_i, &(v)->counter)	\
 		: ia64_atomic64_add(__ia64_aar_i, v);			\
@@ -170,7 +170,7 @@ ATOMIC64_OPS(sub, -)
 
 #define atomic64_sub_return(i,v)					\
 ({									\
-	long __ia64_asr_i = (i);					\
+	s64 __ia64_asr_i = (i);						\
 	__ia64_atomic_const(i)						\
 		? ia64_fetch_and_add(-__ia64_asr_i, &(v)->counter)	\
 		: ia64_atomic64_sub(__ia64_asr_i, v);			\
@@ -178,7 +178,7 @@ ATOMIC64_OPS(sub, -)
 
 #define atomic64_fetch_add(i,v)						\
 ({									\
-	long __ia64_aar_i = (i);					\
+	s64 __ia64_aar_i = (i);						\
 	__ia64_atomic_const(i)						\
 		? ia64_fetchadd(__ia64_aar_i, &(v)->counter, acq)	\
 		: ia64_atomic64_fetch_add(__ia64_aar_i, v);		\
@@ -186,7 +186,7 @@ ATOMIC64_OPS(sub, -)
 
 #define atomic64_fetch_sub(i,v)						\
 ({									\
-	long __ia64_asr_i = (i);					\
+	s64 __ia64_asr_i = (i);						\
 	__ia64_atomic_const(i)						\
 		? ia64_fetchadd(-__ia64_asr_i, &(v)->counter, acq)	\
 		: ia64_atomic64_fetch_sub(__ia64_asr_i, v);		\
