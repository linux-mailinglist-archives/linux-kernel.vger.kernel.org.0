Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9B513B32C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 20:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgANTtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 14:49:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44728 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbgANTtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:49:07 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irSBU-0005Zy-TA; Tue, 14 Jan 2020 20:49:05 +0100
Message-Id: <20200114185947.297142051@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 14 Jan 2020 19:52:44 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [patch 07/15] clocksource: Cleanup struct clocksource and documentation
References: <20200114185237.273005683@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reformat the struct definition, add missing member documentation.
No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/clocksource.h |   87 +++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 40 deletions(-)

--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -32,9 +32,19 @@ struct module;
  *	Provides mostly state-free accessors to the underlying hardware.
  *	This is the structure used for system time.
  *
- * @name:		ptr to clocksource name
- * @list:		list head for registration
- * @rating:		rating value for selection (higher is better)
+ * @read:		Returns a cycle value, passes clocksource as argument
+ * @mask:		Bitmask for two's complement
+ *			subtraction of non 64 bit counters
+ * @mult:		Cycle to nanosecond multiplier
+ * @shift:		Cycle to nanosecond divisor (power of two)
+ * @max_idle_ns:	Maximum idle time permitted by the clocksource (nsecs)
+ * @maxadj:		Maximum adjustment value to mult (~11%)
+ * @archdata:		Optional arch-specific data
+ * @max_cycles:		Maximum safe cycle value which won't overflow on
+ *			multiplication
+ * @name:		Pointer to clocksource name
+ * @list:		List head for registration (internal)
+ * @rating:		Rating value for selection (higher is better)
  *			To avoid rating inflation the following
  *			list should give you a guide as to how
  *			to assign your clocksource a rating
@@ -49,27 +59,23 @@ struct module;
  *			400-499: Perfect
  *				The ideal clocksource. A must-use where
  *				available.
- * @read:		returns a cycle value, passes clocksource as argument
- * @enable:		optional function to enable the clocksource
- * @disable:		optional function to disable the clocksource
- * @mask:		bitmask for two's complement
- *			subtraction of non 64 bit counters
- * @mult:		cycle to nanosecond multiplier
- * @shift:		cycle to nanosecond divisor (power of two)
- * @max_idle_ns:	max idle time permitted by the clocksource (nsecs)
- * @maxadj:		maximum adjustment value to mult (~11%)
- * @max_cycles:		maximum safe cycle value which won't overflow on multiplication
- * @flags:		flags describing special properties
- * @archdata:		arch-specific data
- * @suspend:		suspend function for the clocksource, if necessary
- * @resume:		resume function for the clocksource, if necessary
+ * @flags:		Flags describing special properties
+ * @enable:		Optional function to enable the clocksource
+ * @disable:		Optional function to disable the clocksource
+ * @suspend:		Optional suspend function for the clocksource
+ * @resume:		Optional resume function for the clocksource
  * @mark_unstable:	Optional function to inform the clocksource driver that
  *			the watchdog marked the clocksource unstable
- * @owner:		module reference, must be set by clocksource in modules
+ * @tick_stable:        Optional function called periodically from the watchdog
+ *			code to provide stable syncrhonization points
+ * @wd_list:		List head to enqueue into the watchdog list (internal)
+ * @cs_last:		Last clocksource value for clocksource watchdog
+ * @wd_last:		Last watchdog value corresponding to @cs_last
+ * @owner:		Module reference, must be set by clocksource in modules
  *
  * Note: This struct is not used in hotpathes of the timekeeping code
  * because the timekeeper caches the hot path fields in its own data
- * structure, so no line cache alignment is required,
+ * structure, so no cache line alignment is required,
  *
  * The pointer to the clocksource itself is handed to the read
  * callback. If you need extra information there you can wrap struct
@@ -78,35 +84,36 @@ struct module;
  * structure.
  */
 struct clocksource {
-	u64 (*read)(struct clocksource *cs);
-	u64 mask;
-	u32 mult;
-	u32 shift;
-	u64 max_idle_ns;
-	u32 maxadj;
+	u64			(*read)(struct clocksource *cs);
+	u64			mask;
+	u32			mult;
+	u32			shift;
+	u64			max_idle_ns;
+	u32			maxadj;
 #ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
 	struct arch_clocksource_data archdata;
 #endif
-	u64 max_cycles;
-	const char *name;
-	struct list_head list;
-	int rating;
-	int (*enable)(struct clocksource *cs);
-	void (*disable)(struct clocksource *cs);
-	unsigned long flags;
-	void (*suspend)(struct clocksource *cs);
-	void (*resume)(struct clocksource *cs);
-	void (*mark_unstable)(struct clocksource *cs);
-	void (*tick_stable)(struct clocksource *cs);
+	u64			max_cycles;
+	const char		*name;
+	struct list_head	list;
+	int			rating;
+	unsigned long		flags;
+
+	int			(*enable)(struct clocksource *cs);
+	void			(*disable)(struct clocksource *cs);
+	void			(*suspend)(struct clocksource *cs);
+	void			(*resume)(struct clocksource *cs);
+	void			(*mark_unstable)(struct clocksource *cs);
+	void			(*tick_stable)(struct clocksource *cs);
 
 	/* private: */
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 	/* Watchdog related data, used by the framework */
-	struct list_head wd_list;
-	u64 cs_last;
-	u64 wd_last;
+	struct list_head	wd_list;
+	u64			cs_last;
+	u64			wd_last;
 #endif
-	struct module *owner;
+	struct module		*owner;
 };
 
 /*

