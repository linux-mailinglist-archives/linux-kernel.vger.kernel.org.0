Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74EE479BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 00:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfG2V7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 17:59:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39749 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389348AbfG2V7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:59:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so44437232wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CL7BuFSrbJFNxj7ShYd110TtYKaJGS9/+ZXIwtFyKB0=;
        b=Urz94JLoFcWBaFdOI1mFsa8uf0xOxUKDTWVPotYGHJITzV6juX2+MCA0NXJelnVOH1
         kfuyiejUqdyC9V+LERH5jEDJFa/1AB4z4CXYT3RrOuhEwFm7McoJjmz5nr2vgHt1dbol
         Sf5NhA0da5fitv1WmgqQL7aSSTxAS+1pyh4jdFRgAEBWZYhkpTPCqEY1sQgP886P7t2Z
         MvxthfHmTJXn42NtS2E/5FbcsvY5wUCth/cc2UiQ0w5nuf1/mgJhVfdhprOlvTFH/4F8
         L8+PvGk2p1GulSujA7SDj4gUK8mdU96HikGBcwFRdNZzgLiFh7dcFiCwR5XIB9dXVi4F
         W28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CL7BuFSrbJFNxj7ShYd110TtYKaJGS9/+ZXIwtFyKB0=;
        b=HXjda1sjhW5iih4ZtmaVV8d9PJBWr8tFGPGyRZ7mifcWm1BeAeoBtqNVGHIaNBfHg0
         ed7NT6KKgVRjKuLL+6bfC29dV7fr8FN2tg+TO+iNg+hp+ANTqGldL3+UutfriIWqBpgN
         i6TFIH/mYR1LtZrCwN9BHCMzYI93+iIeKKzl2SyXTb1ZAEXDhliXOR8tSRg0XQImn3Fr
         SBy+wrZg3dt79hqdWEKWKJweHZYxOTI5hV7ENGMgdQycsXvBbU8fMsHFbzVlg+V7yDUf
         jQyNK4ldrvGxqOLugOTKXRsERuVTL+tk9EL0pMOJcK56UNXDiEOP5E9vER2rlkgzP08T
         JZ3Q==
X-Gm-Message-State: APjAAAUelrl42p4m/GBVb4w4MSYXFTNthS6OsMF2L4aqFJGRRgiU0E7/
        Q/gcXT363B098CgND8RbZDx2PX63WDlu+P8rxWMyPP00GY659gMtgEjoFjc6X/Gc/OSr0yYiwNZ
        +qwu6Iu1KkmLKyW7ZO10SUj2rzm57MLU7oXX8nPj33mfhQu+B/p6SQ0EsJ/3flLzRbPzIFiFySQ
        gF8crcC0fyRA5xFWk2kHMPU+FAoOaSqtvN0rHTA0A=
X-Google-Smtp-Source: APXvYqyNDXpf1vxAi1C3ZEUkS/oS081JLs8EZa99SmDmmoe9H9jnDqwMSD1abukB5Sz+vn2xtlR0ug==
X-Received: by 2002:a1c:9696:: with SMTP id y144mr100566476wmd.73.1564437548842;
        Mon, 29 Jul 2019 14:59:08 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.59.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:59:08 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv5 11/37] kernel: Add do_timens_ktime_to_host() helper
Date:   Mon, 29 Jul 2019 22:57:31 +0100
Message-Id: <20190729215758.28405-50-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

The helper subtracts namespace's clock offset from the given time
and checks that the result is in [0, KTIME_MAX].

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/time_namespace.h | 17 ++++++++++++++
 kernel/time_namespace.c        | 43 ++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 334c1a1c6607..9ba9664ff0ab 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -56,6 +56,18 @@ static inline void timens_add_boottime(struct timespec64 *ts)
 		*ts = timespec64_add(*ts, ns_offsets->boottime);
 }
 
+ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
+				struct timens_offsets *offsets);
+static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
+{
+	struct timens_offsets *offsets = current->nsproxy->time_ns->offsets;
+
+	if (!offsets)
+		return tim;
+
+	return do_timens_ktime_to_host(clockid, tim, offsets);
+}
+
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
@@ -82,6 +94,11 @@ static inline int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *ts
 
 static inline void timens_add_monotonic(struct timespec64 *ts) {}
 static inline void timens_add_boottime(struct timespec64 *ts) {}
+
+static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
+{
+	return tim;
+}
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index f849c59f1108..9807c5c90cb2 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -16,6 +16,49 @@
 #include <linux/err.h>
 #include <linux/mm.h>
 
+ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
+				struct timens_offsets *ns_offsets)
+{
+	ktime_t offset;
+
+	switch (clockid) {
+	case CLOCK_MONOTONIC:
+		offset = timespec64_to_ktime(ns_offsets->monotonic);
+		break;
+	case CLOCK_BOOTTIME:
+	case CLOCK_BOOTTIME_ALARM:
+		offset = timespec64_to_ktime(ns_offsets->boottime);
+		break;
+	default:
+		return tim;
+	}
+
+	/*
+	 * Check that @tim value is in [offset, KTIME_MAX + offset]
+	 * and subtract offset.
+	 */
+	if (tim < offset) {
+		/*
+		 * User can specify @tim *absolute* value - if it's lesser than
+		 * the time namespace's offset - it's already expired.
+		 */
+		tim = 0;
+	} else if (KTIME_MAX - tim < -offset) {
+		/*
+		 * User-supplied @tim may be close or even equal KTIME_MAX
+		 * and time namespace offset can be negative.
+		 * Let's check (tim - offset) for an overflow.
+		 * Return KTIME_MAX in such case, as the time value is
+		 * thousands *years* in future anyway.
+		 */
+		tim = KTIME_MAX;
+	} else {
+		tim = ktime_sub(tim, offset);
+	}
+
+	return tim;
+}
+
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
 	return inc_ucount(ns, current_euid(), UCOUNT_TIME_NAMESPACES);
-- 
2.22.0

