Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7CA2C1E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 10:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfE1I7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 04:59:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfE1I7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:59:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DD4E2E95A2;
        Tue, 28 May 2019 08:59:44 +0000 (UTC)
Received: from krava (unknown [10.43.17.32])
        by smtp.corp.redhat.com (Postfix) with SMTP id BF9745D9CD;
        Tue, 28 May 2019 08:59:42 +0000 (UTC)
Date:   Tue, 28 May 2019 10:59:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com
Subject: Re: [PATCH 3/3] perf header: Rename "sibling cores" to "sibling
 sockets"
Message-ID: <20190528085942.GA27906@krava>
References: <1558644081-17738-1-git-send-email-kan.liang@linux.intel.com>
 <1558644081-17738-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558644081-17738-3-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 28 May 2019 08:59:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 01:41:21PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The "sibling cores" actually shows the sibling CPUs of a socket.
> The name "sibling cores" is very misleading.
> 
> Rename "sibling cores" to "sibling sockets"

by checking on die topology, I found that thread_siblings_list
is deprecated/renamed to core_cpus_list.. we should keep that
in mind and support both

jirka

> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/Documentation/perf.data-file-format.txt | 2 +-
>  tools/perf/util/header.c                           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index c731416..dd85163 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -168,7 +168,7 @@ struct {
>  };
>  
>  Example:
> -	sibling cores   : 0-8
> +	sibling sockets : 0-8
>  	sibling dies	: 0-3
>  	sibling dies	: 4-7
>  	sibling threads : 0-1
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index faa1e38..eb79495 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1465,7 +1465,7 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
>  	str = ph->env.sibling_cores;
>  
>  	for (i = 0; i < nr; i++) {
> -		fprintf(fp, "# sibling cores   : %s\n", str);
> +		fprintf(fp, "# sibling sockets : %s\n", str);
>  		str += strlen(str) + 1;
>  	}
>  
> -- 
> 2.7.4
> 
