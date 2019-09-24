Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483FFBC8A2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441091AbfIXNNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 09:13:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35722 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440971AbfIXNNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 09:13:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so1900058wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8DKNKBcYPFJX7gcFM6fla2nCDZ7tXWQVJSYaXdG56A8=;
        b=lGBchQR8d3kN6JhJQ9MVaKL2lR1I8m5zgXBjPBV6qID/LajCYPB8pbwPTaxkOA/iI8
         SXERodTB9XgfGda/UryUoMa1L0vA6n/F9z99rU9Mj4UPvK8x+pZAg+P453ct3pM4AVWr
         46RlBuG0FYJbYVwLKYShyBeGNnDsEL/SnYLV0ywyIs2bnY5U5V6C4us+rYspD9wGIKjc
         FzCk/Om3E3iUDesiFC8oMzr7DnBea2NwIauJdXWDRE4MhwqAZXX4G19Cll6lu4X50vjT
         fBlx9QSPm5M29db64H3kGOHLIugDBtN8QXTr5MRMV3XvoD2VQHVDaC7c7XuKJo77Ec9B
         1qVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8DKNKBcYPFJX7gcFM6fla2nCDZ7tXWQVJSYaXdG56A8=;
        b=GjsRDHpEwyq6poibelmrJxvkkce+AtyKFXUBqKiKAM0spSw3fMSwE8oRLKKUxMiKLs
         ZSfeXB3czwTe96WR58NH/roWqT5cInPlwSHfcX0e6W06Ug4pDYYkJQXFVwm+xJEpeCrR
         NIwqXmSBy8ZAwLimkqa0kD0oWMezWoiJmI5Q7EzK/l5ZDNMr819RUyqMrF5J8VLHwaD8
         Ny8FjzWPRvQRtJvenWvZX58+gk4/DGJ80VYEJwPrMdL2hVCV78V4dbMvvg2FLQ55PO5C
         RTpGI1AwFtG/5CVrqJ60rvNOImDB4I1rXnUrZAZkVFjFMAXPW4WUtY94U+hp93Mil7jb
         wPDQ==
X-Gm-Message-State: APjAAAUjuCEKWezStapjmXAZ+HYgz/kGtlm7x/z0uqNoBoVhfNVBoGo0
        UL3Yqw6x/r8hAGfzQKwqYZ284LPg4daaab6N
X-Google-Smtp-Source: APXvYqzMgXXfQ2e8P0JfGMx58UK24q+b8F7dgRRDyNxYQMxAEMG1nmN+c1auG9UeGmxqbIKhXmsJVw==
X-Received: by 2002:adf:a499:: with SMTP id g25mr2348289wrb.204.1569330819743;
        Tue, 24 Sep 2019 06:13:39 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
        by smtp.gmail.com with ESMTPSA id p7sm2529419wma.34.2019.09.24.06.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 06:13:39 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
 <20190924094942.GN2349@hirez.programming.kicks-ass.net>
 <6f935fb9-6ebd-1df1-0cd0-69e34a16fa7e@kernel.dk>
 <29e6e06e-351f-c19d-ed7c-51f30c9ca887@kernel.dk>
 <08193e07-6f05-a496-492d-06ed8ce3aea1@gmail.com>
 <da86ec56-5f14-536d-2d43-2cc9e118d2a7@kernel.dk>
 <6228b13d-5ef6-e83e-b5dc-7a157013d43f@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a0a0cddf-c5ae-43b0-5445-0bd55e4b7c45@kernel.dk>
Date:   Tue, 24 Sep 2019 15:13:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6228b13d-5ef6-e83e-b5dc-7a157013d43f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/19 5:23 AM, Pavel Begunkov wrote:
>> Yep that should do it, and saves 8 bytes of stack as well.
>>
>> BTW, did you test my patch, this one or the previous? Just curious if it
>> worked for you.
>>
> Not yet, going to do that tonight

Thanks! For reference, the final version is below. There was still a
signal mishap in there, now it should all be correct afaict.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9b84232e5cc4..d2a86164d520 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2768,6 +2768,38 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 	return submit;
 }
 
+struct io_wait_queue {
+	struct wait_queue_entry wq;
+	struct io_ring_ctx *ctx;
+	unsigned to_wait;
+	unsigned nr_timeouts;
+};
+
+static inline bool io_should_wake(struct io_wait_queue *iowq)
+{
+	struct io_ring_ctx *ctx = iowq->ctx;
+
+	/*
+	 * Wake up if we have enough events, or if a timeout occured since we
+	 * started waiting. For timeouts, we always want to return to userspace,
+	 * regardless of event count.
+	 */
+	return io_cqring_events(ctx->rings) >= iowq->to_wait ||
+			atomic_read(&ctx->cq_timeouts) != iowq->nr_timeouts;
+}
+
+static int io_wake_function(struct wait_queue_entry *curr, unsigned int mode,
+			    int wake_flags, void *key)
+{
+	struct io_wait_queue *iowq = container_of(curr, struct io_wait_queue,
+							wq);
+
+	if (!io_should_wake(iowq))
+		return -1;
+
+	return autoremove_wake_function(curr, mode, wake_flags, key);
+}
+
 /*
  * Wait until events become available, if we don't already have some. The
  * application must reap them itself, as they reside on the shared cq ring.
@@ -2775,8 +2807,16 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			  const sigset_t __user *sig, size_t sigsz)
 {
+	struct io_wait_queue iowq = {
+		.wq = {
+			.private	= current,
+			.func		= io_wake_function,
+			.entry		= LIST_HEAD_INIT(iowq.wq.entry),
+		},
+		.ctx		= ctx,
+		.to_wait	= min_events,
+	};
 	struct io_rings *rings = ctx->rings;
-	unsigned nr_timeouts;
 	int ret;
 
 	if (io_cqring_events(rings) >= min_events)
@@ -2795,15 +2835,20 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			return ret;
 	}
 
-	nr_timeouts = atomic_read(&ctx->cq_timeouts);
-	/*
-	 * Return if we have enough events, or if a timeout occured since
-	 * we started waiting. For timeouts, we always want to return to
-	 * userspace.
-	 */
-	ret = wait_event_interruptible(ctx->wait,
-				io_cqring_events(rings) >= min_events ||
-				atomic_read(&ctx->cq_timeouts) != nr_timeouts);
+	iowq.nr_timeouts = atomic_read(&ctx->cq_timeouts);
+	do {
+		prepare_to_wait_exclusive(&ctx->wait, &iowq.wq,
+						TASK_INTERRUPTIBLE);
+		if (io_should_wake(&iowq))
+			break;
+		schedule();
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			break;
+		}
+	} while (1);
+	finish_wait(&ctx->wait, &iowq.wq);
+
 	restore_saved_sigmask_unless(ret == -ERESTARTSYS);
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;

-- 
Jens Axboe

