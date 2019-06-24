Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB74518EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 18:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbfFXQqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 12:46:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:52774 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbfFXQqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:46:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 09:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,412,1557212400"; 
   d="scan'208";a="336554184"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 24 Jun 2019 09:46:17 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 364CE3020A6; Mon, 24 Jun 2019 09:46:17 -0700 (PDT)
Date:   Mon, 24 Jun 2019 09:46:17 -0700
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
        Tom Vaden <tom.vaden@hpe.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>
Subject: Re: [RFC] perf/x86/intel: Disable check_msr for real hw
Message-ID: <20190624164617.GB31027@tassilo.jf.intel.com>
References: <20190614112853.GC4325@krava>
 <20190621174825.GA31027@tassilo.jf.intel.com>
 <20190623224031.GB5471@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623224031.GB5471@krava>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The other hypervisors are relatively obscure, but eventually
> > someone will hit problems.
> 
> any idea if there's any other flag/way we could use to detect those?

I'm not aware of a generic way to detect any hypervisor unfortunately.

There are hypervisor reserved cpuid ranges, in theory you could
probe the existence of those. But there might be always some which
don't have extra CPUIDs.

> 
> adding few virtualization folks to the loop
> and attaching the original patch
> 
> thanks,
> jirka
> 
> 
> ---
> Tom Vaden reported false failure of check_msr function, because
> some servers can do POST tracing and enable LBR tracing during
> the boot.

Just to understand the original problem, the LBR registers
get locked somehow? It would be reasonable to not use LBRs
in this case. We just need to make sure everything 
else is still probed.

-Andi
