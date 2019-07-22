Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6C7016F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 15:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfGVNnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 09:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbfGVNnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:43:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD5F72166E;
        Mon, 22 Jul 2019 13:43:45 +0000 (UTC)
Date:   Mon, 22 Jul 2019 09:43:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "George G. Davis" <george_davis@mentor.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: kmem: convert call_site addresses to user
 friendly symbols
Message-ID: <20190722094343.1e9a5920@gandalf.local.home>
In-Reply-To: <1563589361-18337-1-git-send-email-george_davis@mentor.com>
References: <1563589361-18337-1-git-send-email-george_davis@mentor.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Looking at the kbuild report...

On Fri, 19 Jul 2019 22:22:40 -0400
"George G. Davis" <george_davis@mentor.com> wrote:

> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index eb57e3037deb..ae18e61fa1c0 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -35,7 +35,7 @@ DECLARE_EVENT_CLASS(kmem_alloc,
>  		__entry->gfp_flags	= gfp_flags;
>  	),
>  
> -	TP_printk("call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
> +	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",

Note, %lx expects an unsigned long, %pS expects a pointer.

>  		__entry->call_site,

You need to change the above to: (void *)__entry->call_site,

-- Steve

>  		__entry->ptr,
>  		__entry->bytes_req,
