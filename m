Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4BB6B11E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 23:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfGPVd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 17:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfGPVd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:33:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAF7E2173E;
        Tue, 16 Jul 2019 21:33:55 +0000 (UTC)
Date:   Tue, 16 Jul 2019 17:33:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     xywang.sjtu@sjtu.edu.cn
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: replace simple_strtol() by kstrtoint()
Message-ID: <20190716173354.32575715@gandalf.local.home>
In-Reply-To: <20190715085856.5664-1-xywang.sjtu@sjtu.edu.cn>
References: <20190715085856.5664-1-xywang.sjtu@sjtu.edu.cn>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019 16:58:55 +0800
xywang.sjtu@sjtu.edu.cn wrote:

> From: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
> 
> The simple_strtol() function is deprecated. kstrto[l,int]() are
> the correct replacements as they can properly handle overflows.
> 
> This patch replaces the deprecated simple_strtol() use introduced recently.
> As skip_entries is actually int-typed, we are safe to use kstrtoint() here.
> 
> Same as before, set 0 to skip_entries on string parsing error.
> 
> Fixes: dbfe67334a17 ("tracing: kdb: The skip_lines parameter should have been skip_entries")

This patch doesn't "fix" anything. It's more of a clean up.

I'll look at it after the merge window. Same for the other patch.

-- Steve

> Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
> ---
>  kernel/trace/trace_kdb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> index cca65044c14c..5d9dd4c3f23f 100644
> --- a/kernel/trace/trace_kdb.c
> +++ b/kernel/trace/trace_kdb.c
> @@ -104,8 +104,7 @@ static int kdb_ftdump(int argc, const char **argv)
>  		return KDB_ARGCOUNT;
>  
>  	if (argc) {
> -		skip_entries = simple_strtol(argv[1], &cp, 0);
> -		if (*cp)
> +		if (kstrtoint(argv[1], 0, &skip_entries))
>  			skip_entries = 0;
>  	}
>  

