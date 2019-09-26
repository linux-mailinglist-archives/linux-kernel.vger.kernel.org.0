Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8704BF26C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 14:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfIZMEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 08:04:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:26362 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfIZMEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:04:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 05:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,551,1559545200"; 
   d="scan'208";a="389584982"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.57])
  by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2019 05:04:43 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 4/6] perf: Allow using AUX data in perf samples
In-Reply-To: <87lfw234ew.fsf@ashishki-desk.ger.corp.intel.com>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com> <20180612075117.65420-5-alexander.shishkin@linux.intel.com> <20180614202022.GC12217@hirez.programming.kicks-ass.net> <20180619104725.bqvs7uwzhb4ihyxy@um.fi.intel.com> <20180621201632.GE27616@hirez.programming.kicks-ass.net> <87lfw234ew.fsf@ashishki-desk.ger.corp.intel.com>
Date:   Thu, 26 Sep 2019 15:04:43 +0300
Message-ID: <87blv75kmc.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Peter Zijlstra <peterz@infradead.org> writes:
>
>> On Tue, Jun 19, 2018 at 01:47:25PM +0300, Alexander Shishkin wrote:
>>> Right, the SW stuff may then race with event_function_call() stuff. Hmm.
>>> For the HW stuff, I'm hoping that some kind of a sleight of hand may
>>> suffice. Let me think some more.
>>
>> I currently don't see how the SW driven snapshot can ever work, see my
>> comment on the last patch.
>
> Yes, this should be solved by grouping, similarly PEBS->PT.

Peter, do you have any thoughts/suggestions as to this RFC? Thanks!

Regards,
--
Alex
