Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 266B24FF2D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 04:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfFXCQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 22:16:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfFXCQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:16:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF5DA3083394;
        Sun, 23 Jun 2019 22:40:36 +0000 (UTC)
Received: from krava (ovpn-204-56.brq.redhat.com [10.40.204.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1119D5D9D3;
        Sun, 23 Jun 2019 22:40:31 +0000 (UTC)
Date:   Mon, 24 Jun 2019 00:40:31 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
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
Message-ID: <20190623224031.GB5471@krava>
References: <20190614112853.GC4325@krava>
 <20190621174825.GA31027@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621174825.GA31027@tassilo.jf.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sun, 23 Jun 2019 22:40:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 10:48:25AM -0700, Andi Kleen wrote:
> On Fri, Jun 14, 2019 at 01:28:53PM +0200, Jiri Olsa wrote:
> > hi,
> > the HPE server can do POST tracing and have enabled LBR
> > tracing during the boot, which makes check_msr fail falsly.
> > 
> > It looks like check_msr code was added only to check on guests
> > MSR access, would it be then ok to disable check_msr for real
> > hardware? (as in patch below)
> > 
> > We could also check if LBR tracing is enabled and make
> > appropriate checks, but this change is simpler ;-)
> > 
> > ideas? thanks,
> > jirka
> 
> Sorry for the late comment. I see this patch has been merged now.
> 
> Unfortunately I don't think it's a good idea. The problem 
> is that the hypervisor flags are only set for a few hypervisors
> that Linux knows about. But in practice there are many more
> Hypervisors around that will not cause these flags to be set.
> But these are still likely to miss MSRs.
> 
> The other hypervisors are relatively obscure, but eventually
> someone will hit problems.

any idea if there's any other flag/way we could use to detect those?

adding few virtualization folks to the loop
and attaching the original patch

thanks,
jirka


---
Tom Vaden reported false failure of check_msr function, because
some servers can do POST tracing and enable LBR tracing during
the boot.

Kan confirmed that check_msr patch was to fix a bug report in
guest, so it's ok to disable it for real HW.

Cc: Kan Liang <kan.liang@intel.com>
Reported-by: Tom Vaden <tom.vaden@hpe.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/intel/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 71001f005bfe..1194ae7e1992 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -20,6 +20,7 @@
 #include <asm/intel-family.h>
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
+#include <asm/hypervisor.h>
 
 #include "../perf_event.h"
 
@@ -4050,6 +4051,13 @@ static bool check_msr(unsigned long msr, u64 mask)
 {
 	u64 val_old, val_new, val_tmp;
 
+	/*
+	 * Disable the check for real HW, so we don't
+	 * mess up with potentionaly enabled regs.
+	 */
+	if (hypervisor_is_type(X86_HYPER_NATIVE))
+		return true;
+
 	/*
 	 * Read the current value, change it and read it back to see if it
 	 * matches, this is needed to detect certain hardware emulators
-- 
2.21.0

