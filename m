Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDB229D39
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 19:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391645AbfEXRgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 13:36:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34252 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391530AbfEXRfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id n19so5738842pfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jTlQzYqrjzzW1MYnyuDkipJisTZbubvkU14bVoe0t14=;
        b=MC93AIIpGvqvxr8KRwqE/rWvPO816+lg1ETrCvK8D6sHxJvYJ7kjPT01pyAH/9YLHW
         rKBhBxiBcCRxSMwlhyztMxeq546Q44yGeKEORvrc/Z1TcGFvOlAwvRLLfqhNc8bSnfrM
         IBDJWi+NIUGrO2UtFv9kqJiTeF32OiaBBsmmFhiUjd5PkXdHYmEjRE6G+RJ8mjJQLnCP
         142m+uRG7sJQcCztbeuvD4QrM7baoBZOVVq7YYf88ndLv1TsuRyouvxttcIK8BWn6Vtj
         Vtsea2KMHWfQPN7Hzv+8Y0oC1WGILNqZcTcekCR6Bo1vJ3hC1zi5d5X5XL1O4rQN2ywf
         OPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jTlQzYqrjzzW1MYnyuDkipJisTZbubvkU14bVoe0t14=;
        b=VJWslzMBjKbFcpNx7GLI2gQ3pMqaRHp57ItuTyH8LBonMUCsvZs8f9ChHvg5MTSlpe
         ImtN5um57YUUnPCvv/mqs2aX3DWComUAYtcDsw6Qe77HAbXlJT7rPABJk9OWdjY2trrl
         iWrJbHT7yY62QBvQW3616D9cea58vy7YeXMkIH+PjUZs6K3PhQd7RJMKegOHKY4G88th
         V4ng7UF0fQgjNUgSFEGCmLb1Oq8FD2ZqVrqEGFyq8j+WuUL5C5VTntUGjO9sS+WYHuxH
         8xaswn9njHWzWXir4Z3aQ08eJUCYYocd3BOt5O5CHNgdkKKVSKRvxkjx8fAXXYy8yea+
         xa5A==
X-Gm-Message-State: APjAAAVPoooKMBQf0Dfquixz94KoLIPWdIBwrLGHXR3LUkgXg5hOMi6F
        qVbH+1409rIYOvD5fK0iFqTfqw==
X-Google-Smtp-Source: APXvYqzaqJ7TrV3X6jpeNwx5Rrn55gZe2XCC7/rB2jq8eJJMyNiIIb9qunK7UjUXrP/aeNGx+CLx3w==
X-Received: by 2002:a65:494a:: with SMTP id q10mr12264479pgs.201.1558719316187;
        Fri, 24 May 2019 10:35:16 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k13sm2809575pgr.90.2019.05.24.10.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:35:15 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH v2 05/17] perf tools: Add handling of switch-CPU-wide events
Date:   Fri, 24 May 2019 11:34:56 -0600
Message-Id: <20190524173508.29044-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524173508.29044-1-mathieu.poirier@linaro.org>
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add handling of SWITCH-CPU-WIDE events in order to add the tid/pid of the
incoming process to the perf tools machine infrastructure.  This
information is later retrieved when a contextID packet is found in the
trace stream.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0742c50fce46..5322dcaaf654 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1680,6 +1680,42 @@ static int cs_etm__process_itrace_start(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
+static int cs_etm__process_switch_cpu_wide(struct cs_etm_auxtrace *etm,
+					   union perf_event *event)
+{
+	struct thread *th;
+	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
+
+	/*
+	 * Context switch in per-thread mode are irrelevant since perf
+	 * will start/stop tracing as the process is scheduled.
+	 */
+	if (etm->timeless_decoding)
+		return 0;
+
+	/*
+	 * SWITCH_IN events carry the next process to be switched out while
+	 * SWITCH_OUT events carry the process to be switched in.  As such
+	 * we don't care about IN events.
+	 */
+	if (!out)
+		return 0;
+
+	/*
+	 * Add the tid/pid to the log so that we can get a match when
+	 * we get a contextID from the decoder.
+	 */
+	th = machine__findnew_thread(etm->machine,
+				     event->context_switch.next_prev_pid,
+				     event->context_switch.next_prev_tid);
+	if (!th)
+		return -ENOMEM;
+
+	thread__put(th);
+
+	return 0;
+}
+
 static int cs_etm__process_event(struct perf_session *session,
 				 union perf_event *event,
 				 struct perf_sample *sample,
@@ -1719,6 +1755,8 @@ static int cs_etm__process_event(struct perf_session *session,
 
 	if (event->header.type == PERF_RECORD_ITRACE_START)
 		return cs_etm__process_itrace_start(etm, event);
+	else if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
+		return cs_etm__process_switch_cpu_wide(etm, event);
 
 	return 0;
 }
-- 
2.17.1

