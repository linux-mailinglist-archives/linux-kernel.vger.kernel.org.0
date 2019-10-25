Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6A0EE48B3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 12:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439486AbfJYKlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 06:41:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:20203 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730471AbfJYKlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:41:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 03:41:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="204518584"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Oct 2019 03:41:16 -0700
Received: from [10.125.252.238] (abudanko-mobl.ccr.corp.intel.com [10.125.252.238])
        by linux.intel.com (Postfix) with ESMTP id 936CA5800FE;
        Fri, 25 Oct 2019 03:41:13 -0700 (PDT)
Subject: Re: [PATCH v5 0/4] perf/core: fix restoring of Intel LBR call stack
 on a context switch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <6fa20503-b5ad-16c7-260e-5243509176bc@linux.intel.com>
 <20191025094630.GI4131@hirez.programming.kicks-ass.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b5ee0c34-e75b-74f6-60e9-18cf699b2e7d@linux.intel.com>
Date:   Fri, 25 Oct 2019 13:41:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025094630.GI4131@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.10.2019 12:46, Peter Zijlstra wrote:
> On Fri, Oct 25, 2019 at 11:35:46AM +0300, Alexey Budankov wrote:
> 
> Is this the exact same version again? ISTR already having seen (and
> picked up for testing) a v5.

This is the resend of exact same v5 that I had sent on Wed (10/23).

~Alexey
