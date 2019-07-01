Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A497180FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 22:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfEHUZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 16:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbfEHUYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:24:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3A0A2183F;
        Wed,  8 May 2019 20:24:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hOT7U-0007hm-UY; Wed, 08 May 2019 16:24:52 -0400
Message-Id: <20190508202452.837383631@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 May 2019 16:24:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [for-next][PATCH 07/13] ring-buffer: Fix mispelling of Calculate
References: <20190508202427.252736423@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

It's not "Caculate".

Link: http://lkml.kernel.org/r/20181101154640.23162-1-tiny.windzz@gmail.com

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index ffba6789c0e2..0564f6db0561 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -362,7 +362,7 @@ static void ring_buffer_producer(void)
 			hit--; /* make it non zero */
 		}
 
-		/* Caculate the average time in nanosecs */
+		/* Calculate the average time in nanosecs */
 		avg = NSEC_PER_MSEC / (hit + missed);
 		trace_printk("%ld ns per entry\n", avg);
 	}
-- 
2.20.1


