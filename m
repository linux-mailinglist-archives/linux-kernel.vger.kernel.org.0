Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04DD9FB914
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 20:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfKMTq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 14:46:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfKMTq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 14:46:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 928D3206E1;
        Wed, 13 Nov 2019 19:46:28 +0000 (UTC)
Date:   Wed, 13 Nov 2019 14:46:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hewenliang <hewenliang4@huawei.com>, <acme@redhat.com>
Cc:     <tstoyanov@vmware.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>
Subject: Re: [PATCH] tools lib traceevent: Fix memory leakage in
 copy_filter_type
Message-ID: <20191113144626.44ad5418@gandalf.local.home>
In-Reply-To: <20191025082312.62690-1-hewenliang4@huawei.com>
References: <20191025082312.62690-1-hewenliang4@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019 04:23:12 -0400
Hewenliang <hewenliang4@huawei.com> wrote:

> It is necessary to free the memory that we have allocated
> when error occurs.
> 
> Fixes: ef3072cd1d5c ("tools lib traceevent: Get rid of die in add_filter_type()")
> Signed-off-by: Hewenliang <hewenliang4@huawei.com>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Arnaldo,

Can you take this?

-- Steve

> ---
>  tools/lib/traceevent/parse-filter.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
> index 552592d153fb..fbaa790d10d8 100644
> --- a/tools/lib/traceevent/parse-filter.c
> +++ b/tools/lib/traceevent/parse-filter.c
> @@ -1473,8 +1473,10 @@ static int copy_filter_type(struct tep_event_filter *filter,
>  	if (strcmp(str, "TRUE") == 0 || strcmp(str, "FALSE") == 0) {
>  		/* Add trivial event */
>  		arg = allocate_arg();
> -		if (arg == NULL)
> +		if (arg == NULL) {
> +			free(str);
>  			return -1;
> +		}
>  
>  		arg->type = TEP_FILTER_ARG_BOOLEAN;
>  		if (strcmp(str, "TRUE") == 0)
> @@ -1483,8 +1485,11 @@ static int copy_filter_type(struct tep_event_filter *filter,
>  			arg->boolean.value = 0;
>  
>  		filter_type = add_filter_type(filter, event->id);
> -		if (filter_type == NULL)
> +		if (filter_type == NULL) {
> +			free(str);
> +			free(arg);
>  			return -1;
> +		}
>  
>  		filter_type->filter = arg;
>  

