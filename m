Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB1B189660
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 08:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgCRH6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 03:58:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:31338 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbgCRH6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 03:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584518282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M+gEIOPX0qxekH1F68Wzhr3e0fXNU3XzPM40JRdqWi4=;
        b=VbOU5SP/qntIzpvAc/v9gJRHdkCdp0O/NCub8TrqrKOzPcj8jBToSK2pGyam3yNMBaHpEX
        B+CsOa9NzjaPkhwVUupbIJmFoAeQs2YBjp4AzJMIVPjdmuYmpUDQIqaNnr7nbZt84b4JE4
        SlMJ5pX+fXQRpfqG5R0ArCyk+amBCPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405--CZxqHtdP8mzhzeWXm1rTg-1; Wed, 18 Mar 2020 03:57:56 -0400
X-MC-Unique: -CZxqHtdP8mzhzeWXm1rTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E37D613F6;
        Wed, 18 Mar 2020 07:57:54 +0000 (UTC)
Received: from krava (unknown [10.40.195.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D5855D9E5;
        Wed, 18 Mar 2020 07:57:50 +0000 (UTC)
Date:   Wed, 18 Mar 2020 08:57:43 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        james.clark@arm.com, qiangqing.zhang@nxp.com
Subject: Re: [PATCH v2 0/7] perf test pmu-events case
Message-ID: <20200318075743.GA821557@krava>
References: <1584442939-8911-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584442939-8911-1-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 07:02:12PM +0800, John Garry wrote:

SNIP

> $ tools/perf/perf test -vv 10
> 
> 10: PMU events                                            :
> --- start ---
> test child forked, pid 26610
> testing event table bp_l1_btb_correct: pass
> testing event table bp_l2_btb_correct: pass
> testing event table segment_reg_loads.any: pass
> testing event table dispatch_blocked.any: pass
> testing event table eist_trans: pass
> testing event table uncore_hisi_ddrc.flux_wcmd: pass
> testing event table unc_cbo_xsnp_response.miss_eviction: pass
> Using CPUID GenuineIntel-6-3D-4
> intel_pt default config: tsc,pt,branch
> skipping testing PMU breakpoint
> testing aliases PMU uncore_cbox_1: matched event unc_cbo_xsnp_response.miss_eviction
> testing PMU uncore_cbox_1 aliases: pass
> testing aliases PMU cpu: matched event bp_l1_btb_correct
> testing aliases PMU cpu: matched event bp_l2_btb_correct
> testing aliases PMU cpu: matched event segment_reg_loads.any
> testing aliases PMU cpu: matched event dispatch_blocked.any
> testing aliases PMU cpu: matched event eist_trans
> testing PMU cpu aliases: pass
> skipping testing PMU software
> skipping testing PMU intel_bts
> testing aliases PMU uncore_cbox_0: matched event unc_cbo_xsnp_response.miss_eviction
> testing PMU uncore_cbox_0 aliases: pass
> skipping testing PMU tracepoint
> test child finished with 0
> ---- end ----
> PMU events: Ok
> 
> 
> Changes since v1:
> - Verify event table in generated pmu-events.c, in addition to verifying
>   aliases
> - Don't create separate table for test events, but include as a "testcpu"
> 
> John Garry (7):
>   perf jevents: Add some test events
>   perf jevents: Support test events folder
>   perf pmu: Refactor pmu_add_cpu_aliases()
>   perf test: Add pmu-events test
>   perf pmu: Add is_pmu_core()
>   perf pmu: Make pmu_uncore_alias_match() public
>   perf test: Test pmu-events aliases

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks a lot!

jirka

