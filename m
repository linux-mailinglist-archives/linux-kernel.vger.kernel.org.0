Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC301F1BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 13:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfEOLRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 07:17:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:65294 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbfEOLRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:17:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 04:17:46 -0700
X-ExtLoop1: 1
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.63])
  by fmsmga004.fm.intel.com with ESMTP; 15 May 2019 04:17:42 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org, jolsa@redhat.com,
        songliubraving@fb.com, eranian@google.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, mark.rutland@arm.com,
        megha.dey@intel.com, frederic@kernel.org,
        alexander.shishkin@linux.intel.com
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
In-Reply-To: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
Date:   Wed, 15 May 2019 14:17:42 +0300
Message-ID: <875zqcx8yx.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> +	// XXX think about exclusive
> +	if ((pmu->capabilities & PERF_PMU_CAP_EXCLUSIVE) && group_leader) {
> +		err = -EBUSY;
> +		goto err_context;
>  	}

This used to be a problem, because group_leader could have caused
move_group, which could then potentially violate the
exclusive_event_installable() half way through installing siblings onto
the new context (gctx -> ctx). But, with the proposed new order, it's
the same context (ctx), but different epc, which is not a problem; any
potential violations would be caught by

  if (!exclusive_event_installable(event, ctx))

that preceeds the move_group block.

It also makes sense that exclusive_event_installable() looks on
ctx->event_list and not epc lists for this exact reason.

In retrospect, we can probably also fix this better in the current code
like:

  if (!exclusive_event_installable(event, ctx) ||
      !exclusive_event_installable(event, gctx)) /* do -EBUSY */

and get rid of the above restriction to allow grouping "exclusive"
events.

Regards,
--
Alex
