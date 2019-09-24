Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2975BBC3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 10:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409380AbfIXICx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 04:02:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34092 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409293AbfIXICw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:02:52 -0400
Received: by mail-io1-f66.google.com with SMTP id q1so2256966ion.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 01:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XlIpObiXn0pGhAIkyW27MYi03pXVmO2CJBBWixP9Me0=;
        b=Nz+nPJZvOg62qPOPDhEOsJMRJQoL2XQgBHHlrnN9+BpxsHlPCHNo1iGM9YC3V1qlN8
         sB/WhtHSxQWK+I1d3xe9nY6vUIPU8rc67xoER270JGjBpZiMVNhRd0vJgBQB4tuXFZJ5
         gin0/eYkj35DuDCKMOkQD0uHe2eAObajZj2EYG670ieSyo927HKf2iVp8QHSfOuXbhoa
         /pNzJzg1cgETOJ/uGTD+3Xx4rxK1xKWJ6gHg1q+8YFIprj07ZxJ5ZtS3VBYcaLldQDZr
         Bvg1Gbjs30F77ptP9bjalM7eh77tIXnY9HVv+Q7bVHME5u8Hbc3gE9DyxYAWdr+s3Osb
         QGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XlIpObiXn0pGhAIkyW27MYi03pXVmO2CJBBWixP9Me0=;
        b=gpRhMb/Ujw+j9NdBpSUxoeGGb5xM1IkeeT6Yi3gFTBqeE04/Gv3YdpI1XQffhIwOxV
         c7/gYkBs2ay5wZFV6s/ckNDeIwxLCPhAOLbPuEbhCAnZeSL/fapQHqguBjf1DDEogWiK
         3xbTse50Un0LaHLmGIUFu6IcEnku22bQPc4kyde2kGaAi3e8FPGawG7krTs4tQhRRD2c
         9wBT4xYmuJSMFpH2nrlpctUhAxKhisHctMPdFbQc0CIOQUk6W5Fdjlu6jUWtLCcNk0l5
         evblzf8dCQZ8rCmEHoGPNR8v9JsKSuzEMSGdQX4Bv9tyLwYL7H5XAJcyeEr1418zHYPS
         LnwA==
X-Gm-Message-State: APjAAAVV+9hw6OrP4tCkt2lpFvMuJcccR2TTEQWG5r/ynj8VgZP7EO9H
        YuAWlmx6Deupt0TAeibcuNWS/nhsqcqnZA==
X-Google-Smtp-Source: APXvYqxu9as56XBJs/27/izI40JyfUFGUn6Ir1RHkmlGUc0zo/EsnkuXfTbp3nlBXlY4kBWh8BBqSw==
X-Received: by 2002:a02:65cd:: with SMTP id u196mr2368567jab.3.1569312170512;
        Tue, 24 Sep 2019 01:02:50 -0700 (PDT)
Received: from [172.19.131.113] ([8.46.75.9])
        by smtp.gmail.com with ESMTPSA id t16sm970403iol.12.2019.09.24.01.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 01:02:48 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
Date:   Tue, 24 Sep 2019 10:02:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/19 1:06 AM, Pavel Begunkov wrote:
> On 24/09/2019 02:00, Jens Axboe wrote:
>>> I think we can do the same thing, just wrapping the waitqueue in a
>>> structure with a count in it, on the stack. Got some flight time
>>> coming up later today, let me try and cook up a patch.
>>
>> Totally untested, and sent out 5 min before departure... But something
>> like this.
> Hmm, reminds me my first version. Basically that's the same thing but
> with macroses inlined. I wanted to make it reusable and self-contained,
> though.
> 
> If you don't think it could be useful in other places, sure, we could do
> something like that. Is that so?

I totally agree it could be useful in other places. Maybe formalized and
used with wake_up_nr() instead of adding a new primitive? Haven't looked
into that, I may be talking nonsense.

In any case, I did get a chance to test it and it works for me. Here's
the "finished" version, slightly cleaned up and with a comment added
for good measure.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index ca7570aca430..14fae454cf75 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2768,6 +2768,42 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 	return submit;
 }
 
+struct io_wait_queue {
+	struct wait_queue_entry wq;
+	struct io_ring_ctx *ctx;
+	struct task_struct *task;
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
+	if (io_should_wake(iowq)) {
+		list_del_init(&curr->entry);
+		wake_up_process(iowq->task);
+		return 1;
+	}
+
+	return -1;
+}
+
 /*
  * Wait until events become available, if we don't already have some. The
  * application must reap them itself, as they reside on the shared cq ring.
@@ -2775,8 +2811,16 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			  const sigset_t __user *sig, size_t sigsz)
 {
+	struct io_wait_queue iowq = {
+		.wq = {
+			.func	= io_wake_function,
+			.entry	= LIST_HEAD_INIT(iowq.wq.entry),
+		},
+		.task		= current,
+		.ctx		= ctx,
+		.to_wait	= min_events,
+	};
 	struct io_rings *rings = ctx->rings;
-	unsigned nr_timeouts;
 	int ret;
 
 	if (io_cqring_events(rings) >= min_events)
@@ -2795,15 +2839,16 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
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
+	prepare_to_wait_exclusive(&ctx->wait, &iowq.wq, TASK_INTERRUPTIBLE);
+	do {
+		if (io_should_wake(&iowq))
+			break;
+		schedule();
+		set_current_state(TASK_INTERRUPTIBLE);
+	} while (1);
+	finish_wait(&ctx->wait, &iowq.wq);
+
 	restore_saved_sigmask_unless(ret == -ERESTARTSYS);
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;

-- 
Jens Axboe

