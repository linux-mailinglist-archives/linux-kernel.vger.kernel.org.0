Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B3E189BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 13:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgCRMOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 08:14:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22259 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbgCRMOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584533658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TYFAvu2uKTz7Cwt/dbZj8smyGUrw3nlIrQrl0ibJqbY=;
        b=amMj84jSXnyLOC5iFZuXkgrtgOHc9EFCTuNyDgBSU4dhIO0N7By9AEbPSN+Ajm6agHLk/V
        3rbdXPg1M7nTEPbsA+c2GTAvUO8KvR0WKIihvpKgenzXUmSQXitHXmGcUrGHrtoSEUgooI
        CF7+278f4ajELs1xmsSkPc+OrLBKOWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-cRkhSGbaOzuaLn6qc5AGAQ-1; Wed, 18 Mar 2020 08:14:14 -0400
X-MC-Unique: cRkhSGbaOzuaLn6qc5AGAQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D354C149C1;
        Wed, 18 Mar 2020 12:14:11 +0000 (UTC)
Received: from krava (unknown [10.40.195.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1492C5D9C5;
        Wed, 18 Mar 2020 12:14:07 +0000 (UTC)
Date:   Wed, 18 Mar 2020 13:14:05 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V3 15/17] perf top: Add option to enable the LBR
 stitching approach
Message-ID: <20200318121405.GA849721@krava>
References: <20200313183319.17739-1-kan.liang@linux.intel.com>
 <20200313183319.17739-16-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313183319.17739-16-kan.liang@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 11:33:17AM -0700, kan.liang@linux.intel.com wrote:

SNIP

>  #include "util/top.h"
> @@ -766,6 +767,9 @@ static void perf_event__process_sample(struct perf_tool *tool,
>  	if (machine__resolve(machine, &al, sample) < 0)
>  		return;
>  
> +	if (top->stitch_lbr)
> +		al.thread->lbr_stitch_enable = true;
> +
>  	if (!machine->kptr_restrict_warned &&
>  	    symbol_conf.kptr_restrict &&
>  	    al.cpumode == PERF_RECORD_MISC_KERNEL) {
> @@ -1543,6 +1547,8 @@ int cmd_top(int argc, const char **argv)
>  			"number of thread to run event synthesize"),
>  	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
>  		    "Record namespaces events"),
> +	OPT_BOOLEAN(0, "stitch-lbr", &top.stitch_lbr,
> +		    "Enable LBR callgraph stitching approach"),
>  	OPTS_EVSWITCH(&top.evswitch),
>  	OPT_END()
>  	};
> @@ -1612,6 +1618,11 @@ int cmd_top(int argc, const char **argv)
>  		}
>  	}
>  
> +	if (top.stitch_lbr && !(callchain_param.record_mode == CALLCHAIN_LBR)) {
> +		pr_err("Error: --stitch-lbr must be used with --call-graph lbr\n");
> +		goto out_delete_evlist;
> +	}

why is this check not added for script/report/c2c..?

jirka

