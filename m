Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CB61FD5E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 03:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfEPBq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 21:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfEPAJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 20:09:46 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4303920818;
        Thu, 16 May 2019 00:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557965386;
        bh=/mA5r5W/A7V4rUyFc2FCpKil99JwrJtw0RfOspQouPg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MprtKYYAB+Uh/i8PK10BaZbdvTTLwfT3fMgG/M5sHmCJujx6HclXH64rizpJAHRci
         OwUKXyrY8is01ZL57SZFCyRpukPjx3RnJHbAPZm1iHuLjrIvt41FmhwGhkHtMfn0zl
         2MA0guPR4P49aw9hwgtNqALjb+1BCJ4hFR8fmOPA=
Date:   Thu, 16 May 2019 09:09:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Joe Jin <joe.jin@oracle.com>
Subject: Re: [PATCH] tracing: Kernel access to Ftrace instances
Message-Id: <20190516090942.75f3a957ceed20201edc91a6@kernel.org>
In-Reply-To: <1553106531-3281-2-git-send-email-divya.indi@oracle.com>
References: <1553106531-3281-1-git-send-email-divya.indi@oracle.com>
        <1553106531-3281-2-git-send-email-divya.indi@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Divya,

On Wed, 20 Mar 2019 11:28:51 -0700
Divya Indi <divya.indi@oracle.com> wrote:

> Ftrace provides the feature “instances” that provides the capability to
> create multiple Ftrace ring buffers. However, currently these buffers
> are created/accessed via userspace only. The kernel APIs providing these
> features are not exported, hence cannot be used by other kernel
> components.
> 
> This patch aims to extend this infrastructure to provide the
> flexibility to create/log/remove/ enable-disable existing trace events
> to these buffers from within the kernel.
> 
> Signed-off-by: Divya Indi <divya.indi@oracle.com>
> Reviewed-by: Joe Jin <joe.jin@oracle.com>

Would you tested these APIs with your module? Since,

[...]
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 5b3b0c3..81c038e 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -832,6 +832,7 @@ static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(ftrace_set_clr_event);

I found this exports a static function to module. Did it work?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
