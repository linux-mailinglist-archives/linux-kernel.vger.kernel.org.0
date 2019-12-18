Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5E812402C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 08:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfLRHUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 02:20:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26519 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725799AbfLRHUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576653609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvzyg3hR9fYbD3SR/CZr3+e/c4xKxhlbELvtpYRuRYg=;
        b=gn2eBEv9VfCg8HLXHgAEBTzZ5taCt2bGJBxJWEHSjBFK1VT1qi/7Levtd6s4ond/n2E7Mg
        zMUDSag/9t6+lpmhPyon4JsIJ4DNxx+QSD0V4FI1VSldEIB1SJFkGlBcbmqBYQMquJif5Z
        ZqLFF9wMpkJOlL/fHzvM1FUYImpi60g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-Q5NMG4zwMOCb28FOmrpEag-1; Wed, 18 Dec 2019 02:20:06 -0500
X-MC-Unique: Q5NMG4zwMOCb28FOmrpEag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB0838005B7;
        Wed, 18 Dec 2019 07:20:02 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D5685C545;
        Wed, 18 Dec 2019 07:19:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Long Li <longli@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [RFC PATCH 1/3] sched/core: add API for exporting runqueue clock
Date:   Wed, 18 Dec 2019 15:19:40 +0800
Message-Id: <20191218071942.22336-2-ming.lei@redhat.com>
In-Reply-To: <20191218071942.22336-1-ming.lei@redhat.com>
References: <20191218071942.22336-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scheduler runqueue maintains its own software clock that is periodically
synchronised with hardware. Export this clock so that it can be used
by interrupt flood detection for saving the cost of reading from hardware=
.

Cc: Long Li <longli@microsoft.com>
Cc: Ingo Molnar <mingo@redhat.com>,
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: John Garry <john.garry@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/sched.h | 2 ++
 kernel/sched/core.c   | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 467d26046416..efe1a3ec0e9e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2011,4 +2011,6 @@ int sched_trace_rq_cpu(struct rq *rq);
=20
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
=20
+u64 sched_local_rq_clock(void);
+
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90e4b00ace89..03e2e3c36067 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -219,6 +219,11 @@ void update_rq_clock(struct rq *rq)
 	update_rq_clock_task(rq, delta);
 }
=20
+u64 sched_local_rq_clock(void)
+{
+	return this_rq()->clock;
+}
+EXPORT_SYMBOL_GPL(sched_local_rq_clock);
=20
 #ifdef CONFIG_SCHED_HRTICK
 /*
--=20
2.20.1

