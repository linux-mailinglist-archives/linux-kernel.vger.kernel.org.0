Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9861311A9F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 12:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfLKLdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 06:33:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:14628 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbfLKLdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 06:33:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 03:33:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="225491882"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2019 03:33:18 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 0/2] perf/x86/intel/bts: Small fixes
In-Reply-To: <20191210174047.GQ2844@hirez.programming.kicks-ass.net>
References: <20191205142853.28894-1-alexander.shishkin@linux.intel.com> <20191210174047.GQ2844@hirez.programming.kicks-ass.net>
Date:   Wed, 11 Dec 2019 13:33:17 +0200
Message-ID: <87eexbcd1e.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Dec 05, 2019 at 05:28:51PM +0300, Alexander Shishkin wrote:
>> Hi Peter and Ingo,
>> 
>> Here are two small fixes that resulted from running perf_fuzzer on a !KPTI
>> kernel. One is a misguided and unannotated warning and another is a sketchy
>> use of page_private(). The choice between deleting the BTS driver and
>> fixing it is not obvious, though. It may theoretically still have users.
>> 
>> Alexander Shishkin (2):
>>   perf/x86/intel/bts: Remove a silly warning
>>   perf/x86/intel/bts: Fix the use of page_private()
>
> I'll squash the pair, that makes more sense to me.

Thanks!
