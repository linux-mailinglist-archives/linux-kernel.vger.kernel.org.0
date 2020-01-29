Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09B514CDF3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 17:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgA2QJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 11:09:12 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46364 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA2QJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:09:12 -0500
Received: by mail-pg1-f195.google.com with SMTP id z124so9037976pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 08:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+oq96d085fk9R1zembWjfCyukhjjIatlVof2J+sNPxs=;
        b=EamuglrtmZ9uGundx/IPRJmVpL0Y/3ThnGKOVz4Zqb8m1MOH+bYP3fPoP5u8oz49Pn
         1Ij0uVWlWzH+x4BHRgxbd/WvXmQvpf1139nKPgvcQwhptH7/kdEQp58OBYTmsNidNqu+
         t2BBYY5mNpfr1yt+vHtvAupk/RTbYduLBjxPdP3PIsc4rgg5R1XSPm2TAPcEGkAOASzE
         kY1PCIFULGkg/YJjrCq9QmJB8D/tSTQv/nAfwwkcDJjKNBiSDRAPmySG9yxlrYhEs4qd
         uM1e2ZNWjtHQ2PpOvWQBMcJKxfTO350EfYmBRbw1WpRyyTa+cta9B1bu6pubqqsmNGK6
         5oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+oq96d085fk9R1zembWjfCyukhjjIatlVof2J+sNPxs=;
        b=PWF1q0Oq4VaeWQSxnS+WykWRwRJjn1JT2tHR6ndhjBK0DoWkWibRCoMl6iFO1esgBZ
         C52N7kUu55dERpSyVRFAUacOmfeQoRFO2PcEWZAU1s7bOqQQ79MLI1iYsccPIwRn541E
         IJxUQDYcsIrg9D4SI3X03wl526M6kokrWpDfEDibNWMSoPN8KwMPP7MMYBPvTI/9UL71
         +4nKWz1UFtLaLSG5ZWx7r6hzupMTwdeNepxKk/jw2X+sMcRUyKzzWFgiJNuVvSK32hX0
         onywIj7ASKaJ128/NFw+xbH/C+GlwSTLWWOHxM54PCuCwB1JjS9TKyqUNQTqrMe9gqdV
         sxKg==
X-Gm-Message-State: APjAAAUdBth0FCu6d99NqpKzfH6TRNF4i17ywTBA71gAvFINbp+Oq1jE
        zJaUIIY2g6uXFUBy7zPCiuo=
X-Google-Smtp-Source: APXvYqyhg/HldHGGdfEgHowy5IgtRURU9SafwhhUwsow9z2iqxxg52P1LutbN5nUIyb+3aqkQpZ/Eg==
X-Received: by 2002:a65:5809:: with SMTP id g9mr31259946pgr.146.1580314151330;
        Wed, 29 Jan 2020 08:09:11 -0800 (PST)
Received: from localhost.localdomain ([146.196.37.139])
        by smtp.googlemail.com with ESMTPSA id 73sm3258801pgc.13.2020.01.29.08.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 08:09:10 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH 1/2] events: callchain: Annotate RCU pointer with __rcu
Date:   Wed, 29 Jan 2020 21:38:12 +0530
Message-Id: <20200129160813.14263-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes following instances of sparse error
error: incompatible types in comparison expression
(different address spaces)
kernel/events/callchain.c:66:9: error: incompatible types in comparison
kernel/events/callchain.c:96:9: error: incompatible types in comparison
kernel/events/callchain.c:161:19: error: incompatible types in comparison

This introduces the following warning
kernel/events/callchain.c:65:17: warning: incorrect type in assignment

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 kernel/events/callchain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index c2b41a263166..f91e1f41d25d 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -32,7 +32,7 @@ static inline size_t perf_callchain_entry__sizeof(void)
 static DEFINE_PER_CPU(int, callchain_recursion[PERF_NR_CONTEXTS]);
 static atomic_t nr_callchain_events;
 static DEFINE_MUTEX(callchain_mutex);
-static struct callchain_cpus_entries *callchain_cpus_entries;
+static struct callchain_cpus_entries __rcu *callchain_cpus_entries;
 
 
 __weak void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
-- 
2.24.1

