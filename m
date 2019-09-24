Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 943A9BCF83
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 19:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411048AbfIXQ5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 12:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbfIXQ5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:57:39 -0400
Received: from devnote2 (unknown [12.206.46.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E8420673;
        Tue, 24 Sep 2019 16:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569344259;
        bh=ukvkbUWPZgKT8DM481/hafI6yceN2bLg0AIJm/fKvsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZAisG4Tv4lkpwx383sYq1aSCBklYWwnPhZHN9aUU9f+Z8AVTtPDKspA1s/LtAsQVC
         anIOtwdjverTGILBUnuxs2shjV0pq0O6ip2EmzPpBXxM2if8EJdzX+VL3slt/RKlyr
         6bAnHEeyvsJUg9JVxWsu6Qi96Fj+V+tLRwR4HUPY=
Date:   Tue, 24 Sep 2019 09:57:37 -0700
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/probe: Fix same probe event argument matching
Message-Id: <20190924095737.571b71594c25dc4b246e5377@kernel.org>
In-Reply-To: <20190924114906.14038-1-srikar@linux.vnet.ibm.com>
References: <20190924114906.14038-1-srikar@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srikar,

On Tue, 24 Sep 2019 17:19:06 +0530
Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> Commit fe60b0ce8e73 ("tracing/probe: Reject exactly same probe event")
> tries to reject a event which matches an already existing probe.
> 
> However it currently continues to match arguments and rejects adding a
> probe even when the arguments don't match. Fix this by only rejecting a
> probe if and only if all the arguments match.

Thank you for fixing!
This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> 
> Fixes: fe60b0ce8e73 ("tracing/probe: Reject exactly same probe event")
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  kernel/trace/trace_kprobe.c | 5 +++--
>  kernel/trace/trace_uprobe.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index a6697e28ddda..402dc3ce88d3 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -549,10 +549,11 @@ static bool trace_kprobe_has_same_kprobe(struct trace_kprobe *orig,
>  		for (i = 0; i < orig->tp.nr_args; i++) {
>  			if (strcmp(orig->tp.args[i].comm,
>  				   comp->tp.args[i].comm))
> -				continue;
> +				break;
>  		}
>  
> -		return true;
> +		if (i == orig->tp.nr_args)
> +			return true;
>  	}
>  
>  	return false;
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 34dd6d0016a3..dd884341f5c5 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -431,10 +431,11 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
>  		for (i = 0; i < orig->tp.nr_args; i++) {
>  			if (strcmp(orig->tp.args[i].comm,
>  				   comp->tp.args[i].comm))
> -				continue;
> +				break;
>  		}
>  
> -		return true;
> +		if (i == orig->tp.nr_args)
> +			return true;
>  	}
>  
>  	return false;
> -- 
> 2.18.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
