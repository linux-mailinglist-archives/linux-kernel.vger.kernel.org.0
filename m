Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE2A10516D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 12:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKULal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 06:30:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKULal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:30:41 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6435C20714;
        Thu, 21 Nov 2019 11:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574335840;
        bh=Rwju7mil6tW/AfAn9a6uUogaLmvQb/zy3wNtrHb4LSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G5RLswA97Zv34MBS5+FVmcBxNGECL/UpHfxcNKADLc3btNtRTO5bZoE7xxZu4hxN8
         EaWGfiTFQMDc+4ILEgRP0n74PDzh7zf0xaRGKJeF0Wbhaju13nf7OMUvEAopZb6zA1
         LArGSNfSacOYnKFZSviCLV2etHMKB7itiCV7gUF0=
Date:   Thu, 21 Nov 2019 20:30:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf probe: fix spelling mistake "addrees" ->
 "address"
Message-Id: <20191121203035.5eae09a076f376472cd4465b@kernel.org>
In-Reply-To: <20191121092623.374896-1-colin.king@canonical.com>
References: <20191121092623.374896-1-colin.king@canonical.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Thu, 21 Nov 2019 09:26:23 +0000
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a pr_warning message. Fix it.

Oops, good catch! (How my finger miss-typed this...)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/perf/util/probe-finder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 38d6cd22779f..c470c49a804f 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -812,7 +812,7 @@ static int verify_representive_line(struct probe_finder *pf, const char *fname,
>  	if (strcmp(fname, __fname) || lineno == __lineno)
>  		return 0;
>  
> -	pr_warning("This line is sharing the addrees with other lines.\n");
> +	pr_warning("This line is sharing the address with other lines.\n");
>  
>  	if (pf->pev->point.function) {
>  		/* Find best match function name and lines */
> -- 
> 2.24.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
