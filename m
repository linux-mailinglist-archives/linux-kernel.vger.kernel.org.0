Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 394FCF1BA3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 17:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbfKFQuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 11:50:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:37943 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728832AbfKFQuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:50:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 08:50:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="214301961"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 06 Nov 2019 08:50:07 -0800
Received: from [10.251.82.133] (abudanko-mobl.ccr.corp.intel.com [10.251.82.133])
        by linux.intel.com (Postfix) with ESMTP id 0EDA0580A3E;
        Wed,  6 Nov 2019 08:50:04 -0800 (PST)
Subject: Re: [RFC] perf session: Fix compression processing
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20191103222441.GE8251@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <bb1d712b-c02f-d22d-ee19-644c0612a317@linux.intel.com>
Date:   Wed, 6 Nov 2019 19:50:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191103222441.GE8251@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.11.2019 1:24, Jiri Olsa wrote:
> hi,
> I'm not sure I follow everything on compression,
> so I might have missed something, but patch below
> fixes the issue for me.
> 
> jirka
> 
> 
> ---
> The compressed data processing occasionally fails with:
>   $ perf report --stdio -vv
>   decomp (B): 44519 to 163000
>   decomp (B): 48119 to 174800
>   decomp (B): 65527 to 131072
>   fetch_mmaped_event: head=0x1ffe0 event->header_size=0x28, mmap_size=0x20000: fuzzed perf.data?
>   Error:
>   failed to process sample
>   ...
> 
> It's caused by recent fuzzer fix that does not take into account
> that compressed data do not need to by fully present in the buffer,
> so it's ok to just return NULL and not to fail.
> 
> Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
> Link: http://lkml.kernel.org/n/tip-q1biqscs4stcmc9bs1iokfro@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/session.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

I am on vacations currently, getting back on Monday (11/11). 
Please expect delay in response.

~Alexey
