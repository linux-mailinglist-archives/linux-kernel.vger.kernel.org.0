Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8408D54EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 14:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfFYMUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 08:20:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:62516 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfFYMUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:20:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 05:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,415,1557212400"; 
   d="scan'208";a="155494457"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.63])
  by orsmga008.jf.intel.com with ESMTP; 25 Jun 2019 05:20:33 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, dvyukov@google.com, namhyung@kernel.org,
        xiexiuqi@huawei.com,
        syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf: Fix race between close() and fork()
In-Reply-To: <20190625104320.GZ3463@hirez.programming.kicks-ass.net>
References: <278ac311-d8f3-2832-5fa1-522471c8c31c@huawei.com> <20190228140109.64238-1-alexander.shishkin@linux.intel.com> <20190308155429.GB10860@lakrids.cambridge.arm.com> <20190624121902.GE3436@hirez.programming.kicks-ass.net> <20190625084904.GY3463@hirez.programming.kicks-ass.net> <20190625104320.GZ3463@hirez.programming.kicks-ass.net>
Date:   Tue, 25 Jun 2019 15:20:33 +0300
Message-ID: <87h88dvotq.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> Solve it by using the fact that detached events still have a reference
> count on their (previous) context. With this perf_event_free_task()
> can detect when events have escaped and wait for their destruction.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Fixes: 82d94856fa22 ("perf/core: Fix lock inversion between perf,trace,cpuhp")
> Reported-by: syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com
> Debugged-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Regards,
--
Alex
