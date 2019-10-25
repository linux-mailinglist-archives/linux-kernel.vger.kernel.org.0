Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42A3E4AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 14:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440174AbfJYMTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 08:19:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:49239 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfJYMTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:19:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 05:19:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="201794460"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 05:19:39 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v2 4/4] perf/x86/intel/pt: Opportunistically use single range output mode
In-Reply-To: <20191024135632.GE4114@hirez.programming.kicks-ass.net>
References: <20191022095812.67071-1-alexander.shishkin@linux.intel.com> <20191022095812.67071-5-alexander.shishkin@linux.intel.com> <20191024135632.GE4114@hirez.programming.kicks-ass.net>
Date:   Fri, 25 Oct 2019 15:19:38 +0300
Message-ID: <87blu5ggpx.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Oct 22, 2019 at 12:58:12PM +0300, Alexander Shishkin wrote:
>> Most of PT implementations support Single Range Output mode, which is
>> an alternative to ToPA that can be used for a single contiguous buffer
>> and if we don't require an interrupt, that is, in AUX snapshot mode.
>> 
>> Now that perf core will use high order allocations for the AUX buffer,
>> in many cases the first condition will also be satisfied.
>> 
>> The two most obvious benefits of the Single Range Output mode over the
>> ToPA are:
>>  * not having to allocate the ToPA table(s),
>>  * not using the ToPA walk hardware.
>> 
>> Make use of this functionality where available and appropriate.
>
> This seems independent of the snapshot stuff, right?

Yes, it depends on the previous PT driver patch for context,
though. I'll drop it from the set.

Regards,
--
Alex
