Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA8EDA4157
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 02:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfHaAbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 20:31:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:9288 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbfHaAbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 20:31:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 17:31:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,449,1559545200"; 
   d="scan'208";a="333022808"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga004.jf.intel.com with ESMTP; 30 Aug 2019 17:31:10 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 11D68300FFA; Fri, 30 Aug 2019 17:31:10 -0700 (PDT)
Date:   Fri, 30 Aug 2019 17:31:10 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [RESEND PATCH V3 3/8] perf/x86/intel: Support hardware TopDown
 metrics
Message-ID: <20190831003110.GA5447@tassilo.jf.intel.com>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
 <CABPqkBTS8bRjSwOBm2HxtuDWhxeZrTGa_E8mqfRfEJPzX1BNhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTS8bRjSwOBm2HxtuDWhxeZrTGa_E8mqfRfEJPzX1BNhw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> the same manner. It would greatly simplify the kernel implementation.

I tried that originally. It was actually more complicated.

You can't really do deltas on raw metrics, and a lot of the perf
infrastructure is built around deltas.

To do the regular reset and not lose precision over time internally
you have to keep expanded counters anyways. And if you do that
you can just expose them to user space too, and have everything
in user space just work without any changes (except for the final
output)

-Andi

