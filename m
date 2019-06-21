Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C414C4EE20
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 19:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfFURs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 13:48:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:49255 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfFURs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:48:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 10:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,401,1557212400"; 
   d="scan'208";a="359358777"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jun 2019 10:48:25 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 77191301C16; Fri, 21 Jun 2019 10:48:25 -0700 (PDT)
Date:   Fri, 21 Jun 2019 10:48:25 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tom Vaden <tom.vaden@hpe.com>
Subject: Re: [RFC] perf/x86/intel: Disable check_msr for real hw
Message-ID: <20190621174825.GA31027@tassilo.jf.intel.com>
References: <20190614112853.GC4325@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614112853.GC4325@krava>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 01:28:53PM +0200, Jiri Olsa wrote:
> hi,
> the HPE server can do POST tracing and have enabled LBR
> tracing during the boot, which makes check_msr fail falsly.
> 
> It looks like check_msr code was added only to check on guests
> MSR access, would it be then ok to disable check_msr for real
> hardware? (as in patch below)
> 
> We could also check if LBR tracing is enabled and make
> appropriate checks, but this change is simpler ;-)
> 
> ideas? thanks,
> jirka

Sorry for the late comment. I see this patch has been merged now.

Unfortunately I don't think it's a good idea. The problem 
is that the hypervisor flags are only set for a few hypervisors
that Linux knows about. But in practice there are many more
Hypervisors around that will not cause these flags to be set.
But these are still likely to miss MSRs.

The other hypervisors are relatively obscure, but eventually
someone will hit problems.

-Andi


