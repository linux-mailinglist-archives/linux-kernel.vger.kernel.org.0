Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 779D414F70A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 08:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgBAH2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Feb 2020 02:28:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgBAH2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 02:28:50 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFE2D206A2;
        Sat,  1 Feb 2020 07:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580542129;
        bh=ySVJ+VtpaS7wNXidTmBslbOzBhZtcJN03yeuJlTde7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rkt69jvOhucipTVCXEb8mywLEZKU4kEwl2oqOrEOkgWX3FUvqf8W17ioWNlPafYmO
         6LsDeRYDkrIyQpeZmqn3Np3jeYVaVX4MaFv5abW+i2YFvirTOuUSo5CgTNGaqcTjVd
         iVTWIZFDprRfSYLoiBSAFLbQOs8TVyf5eHt5CBqA=
Date:   Sat, 1 Feb 2020 16:28:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, artem.bityutskiy@linux.intel.com,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/4] tracing: Remove useless code in
 dynevent_arg_pair_add()
Message-Id: <20200201162845.4671305320ca03d5d42b966d@kernel.org>
In-Reply-To: <7880a1268217886cdba7035526650195668da856.1580506712.git.zanussi@kernel.org>
References: <cover.1580506712.git.zanussi@kernel.org>
        <7880a1268217886cdba7035526650195668da856.1580506712.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 15:55:33 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> The final addition to q is unnecessary, since q isn't ever used
> afterwards.
> 

Yeah, thanks for updating :)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,


> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/trace_dynevent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> index f9cfcdc9d1f3..204275ec8d71 100644
> --- a/kernel/trace/trace_dynevent.c
> +++ b/kernel/trace/trace_dynevent.c
> @@ -322,7 +322,7 @@ int dynevent_arg_pair_add(struct dynevent_cmd *cmd,
>  		pr_err("field string is too long: %s\n", arg_pair->rhs);
>  		return -E2BIG;
>  	}
> -	cmd->remaining -= delta; q += delta;
> +	cmd->remaining -= delta;
>  
>  	return ret;
>  }
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
