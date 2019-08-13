Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 217588BAC2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 15:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfHMNvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 09:51:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbfHMNvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:51:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAA6630FB8D0;
        Tue, 13 Aug 2019 13:51:52 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-35.phx2.redhat.com [10.3.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B0081001948;
        Tue, 13 Aug 2019 13:51:52 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 8FB5B12E; Tue, 13 Aug 2019 10:51:49 -0300 (BRT)
Date:   Tue, 13 Aug 2019 10:51:49 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v6 7/7] perf intel-pt: Add brief documentation for PEBS
 via Intel PT
Message-ID: <20190813135149.GA3754@redhat.com>
References: <20190806084606.4021-1-alexander.shishkin@linux.intel.com>
 <20190806084606.4021-8-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806084606.4021-8-alexander.shishkin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 13 Aug 2019 13:51:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 06, 2019 at 11:46:06AM +0300, Alexander Shishkin escreveu:
> From: Adrian Hunter <adrian.hunter@intel.com>
> 
> Document how to select PEBS via Intel PT and how to display synthesized
> PEBS samples.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  tools/perf/Documentation/intel-pt.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
> index 50c5b60101bd..8dc513b6607b 100644
> --- a/tools/perf/Documentation/intel-pt.txt
> +++ b/tools/perf/Documentation/intel-pt.txt
> @@ -919,3 +919,18 @@ amended to take the number of elements as a parameter.
>  
>  Note there is currently no advantage to using Intel PT instead of LBR, but
>  that may change in the future if greater use is made of the data.
> +
> +
> +PEBS via Intel PT
> +=================
> +
> +Some hardware has the feature to redirect PEBS records to the Intel PT trace.
> +Recording is selected by using the aux-output config term e.g.
> +
> +	perf record  -c 10000 -e cycles/aux-output/ppp -e intel_pt/branch=0/ uname
> +
> +Note that currently, software only supports redirecting at most one PEBS event.

So, with these patches, but not the kernel ones I end up getting:

[root@quaco ~]# perf record  -c 10000 -e cycles/aux-output/ppp -e intel_pt/branch=0/ uname
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (cycles/aux-output/ppp).
/bin/dmesg | grep -i perf may provide additional information.

[root@quaco ~]#

I'll check if I can make it spew a more helpful message, then build a
kernel with the kernel patches and try with it as well.

PeterZ has the kernel ones landed on tip? I guess not, as perf/core I
have should be in sync...

- Arnaldo

> +To display PEBS events from the Intel PT trace, use the itrace 'o' option e.g.
> +
> +	perf script --itrace=oe
> -- 
> 2.20.1
