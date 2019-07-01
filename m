Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B4928B37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 22:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbfEWUCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 16:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387434AbfEWUCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:02:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 021F720881;
        Thu, 23 May 2019 20:02:04 +0000 (UTC)
Date:   Thu, 23 May 2019 16:02:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] tracing: Use correct function name in
 trace_filter_add_remove_task() comment
Message-ID: <20190523160203.17ba68c2@gandalf.local.home>
In-Reply-To: <20190523192628.134406-1-mka@chromium.org>
References: <20190523192628.134406-1-mka@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019 12:26:28 -0700
Matthias Kaehlcke <mka@chromium.org> wrote:

> The comment of trace_filter_add_remove_task() refers to the function as
> 'trace_pid_filter_add_remove_task', use the correct name.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Thanks, I added it to my queue.

-- Steve

> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2c92b3d9ea30..d1ab31abc46f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -366,7 +366,7 @@ trace_ignore_this_task(struct trace_pid_list *filtered_pids, struct task_struct
>  }
>  
>  /**
> - * trace_pid_filter_add_remove_task - Add or remove a task from a pid_list
> + * trace_filter_add_remove_task - Add or remove a task from a pid_list
>   * @pid_list: The list to modify
>   * @self: The current task for fork or NULL for exit
>   * @task: The task to add or remove

