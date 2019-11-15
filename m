Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD263FE20C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 16:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfKOPw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 10:52:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727564AbfKOPw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:52:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEBD820733;
        Fri, 15 Nov 2019 15:52:28 +0000 (UTC)
Date:   Fri, 15 Nov 2019 10:52:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace/synthetic_events: increase SYNTH_FIELDS_MAX
Message-ID: <20191115105227.341c238e@gandalf.local.home>
In-Reply-To: <20191115091730.9192-1-dedekind1@gmail.com>
References: <20191115091730.9192-1-dedekind1@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 11:17:30 +0200
Artem Bityutskiy <dedekind1@gmail.com> wrote:

> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> Increase the maximum allowed count of synthetic event fields from 16 to 32
> in order to allow for larger-than-usual events.

I'm fine with this, Tom are you OK with it?

-- Steve

> 
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 7482a1466ebf..f49d1a36d3ae 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -23,7 +23,7 @@
>  #include "trace_dynevent.h"
>  
>  #define SYNTH_SYSTEM		"synthetic"
> -#define SYNTH_FIELDS_MAX	16
> +#define SYNTH_FIELDS_MAX	32
>  
>  #define STR_VAR_LEN_MAX		32 /* must be multiple of sizeof(u64) */
>  

