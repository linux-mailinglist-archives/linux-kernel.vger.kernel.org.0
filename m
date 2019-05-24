Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71361296E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 13:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390998AbfEXLQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 07:16:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35428 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390932AbfEXLQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:16:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so2699490wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D2Cp7f/Qid/by7EIC98tg3BbhOaVwQta3p5eP2Mz3hQ=;
        b=SYmw9u/BJ1amgAo2T7+9N3JVa9edXzEA5XwgQqoQMkbnEG66y2My7j+uYTQliLkZ5G
         wA9s/2O5X1B23OTaAssAZqkSQG7H0FIYEIl98O0kAwj5fnLaqvu/WznalSN1VNHQHsa3
         C2Ee/KA7/+/H1EyER8+3hFE2PHg0y77TF18FtIzduRBGHj0pAVpYwg3GCtGUmwEAyOdO
         kq+deYjKk+I+pLJefY9stJWTiwb51IIHZXQUqnwYT/unx3FHYircXFxYC/3b+akzVGQC
         I9K8RQxuAlz134Wu1krvsJ0ASORwtwDVQbjb7tDGIdPN5IxBeeHTnFhhM1qPXafxgn+F
         dBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D2Cp7f/Qid/by7EIC98tg3BbhOaVwQta3p5eP2Mz3hQ=;
        b=LXSA1+ZEXOspJIqI1/7LDUKBPbt+dG6p97bJT5QiiR44Y5KYFCxcxf9nZEbmRGLm8D
         DGJCKutVsvBUAl9OLHlN190K+fQyUd8wyFgnXcNujnXqYMyx2FRaU5skD2dfjcCi9SpG
         hFjD0ivw5OkoC2DPUZGyq2xBBJ4VsPfd4140jpXxE9/9qtjswXFfJjTl516wGlOTDa9p
         FvOsOY9gl47yaE5GpSrQklBQbrPIUzuV95Cua5yiyLUY1v3uilGNCWUdTxptV8XAkdgr
         CA6EjtbUjYc1PhOa6O9gvQOR8Jd6gFUDe6rOMh4iRifFgahpWtUHY/GG2AIENut8Dm2g
         oi0w==
X-Gm-Message-State: APjAAAUFfLxl9VH3C60spfVsoy77tgyvwBd8YjQ8GtYz8PMAVrvdzbst
        oiQEhLfRmLb+KovpNOjqNddioLepgFw=
X-Google-Smtp-Source: APXvYqxsVF67CvGyBFlBpEB6QLF5KlM2/7fBtHAgHn+ziqbVb+VjF03bsjbsYjxxhD9U1c3D5iapPA==
X-Received: by 2002:a1c:a815:: with SMTP id r21mr14796594wme.66.1558696603124;
        Fri, 24 May 2019 04:16:43 -0700 (PDT)
Received: from clegane.local (73.82.95.92.rev.sfr.net. [92.95.82.73])
        by smtp.gmail.com with ESMTPSA id h12sm2575392wre.14.2019.05.24.04.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:16:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V2 5/9] genirq/timings: Encapsulate timings push
Date:   Fri, 24 May 2019 13:16:11 +0200
Message-Id: <20190524111615.4891-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524111615.4891-1-daniel.lezcano@linaro.org>
References: <20190524111615.4891-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the next patches providing the selftest, we do want to
artificially insert timings value in the circular buffer in order to
check the correctness of the code. Encapsulate the common code between
the future test code and the current with an always-inline tag.

No functional change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/irq/internals.h | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 70c3053bc1f6..21f9927ff5ad 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -354,6 +354,16 @@ static inline int irq_timing_decode(u64 value, u64 *timestamp)
 	return value & U16_MAX;
 }
 
+static __always_inline void irq_timings_push(u64 ts, int irq)
+{
+	struct irq_timings *timings = this_cpu_ptr(&irq_timings);
+
+	timings->values[timings->count & IRQ_TIMINGS_MASK] =
+		irq_timing_encode(ts, irq);
+
+	timings->count++;
+}
+
 /*
  * The function record_irq_time is only called in one place in the
  * interrupts handler. We want this function always inline so the code
@@ -367,15 +377,8 @@ static __always_inline void record_irq_time(struct irq_desc *desc)
 	if (!static_branch_likely(&irq_timing_enabled))
 		return;
 
-	if (desc->istate & IRQS_TIMINGS) {
-		struct irq_timings *timings = this_cpu_ptr(&irq_timings);
-
-		timings->values[timings->count & IRQ_TIMINGS_MASK] =
-			irq_timing_encode(local_clock(),
-					  irq_desc_get_irq(desc));
-
-		timings->count++;
-	}
+	if (desc->istate & IRQS_TIMINGS)
+		irq_timings_push(local_clock(), irq_desc_get_irq(desc));
 }
 #else
 static inline void irq_remove_timings(struct irq_desc *desc) {}
-- 
2.17.1

