Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCF9E4053
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 01:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfJXXWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 19:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbfJXXWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 19:22:54 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D111B205F4;
        Thu, 24 Oct 2019 23:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571959373;
        bh=lmpdMzLdGN4J6KFDzz3GgF4H5PsEQKCr4B/I49Nm34M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xkSE8lFTJJe/fl4BXI8jK4Hx43EyRv3A9u1EhVimbjXAm9DvnG0Vdbx5LXn6KqgzL
         vLjF5m/VMiAD/fXefAqPRKpOqVeFtChPHPpIhXVAk01BAQIilGjKWTZN/ZVkRYg/1o
         4TJKcZlfP9Or8J4tqG/DJb8hxQYeC4we9K4MM/kY=
Date:   Fri, 25 Oct 2019 08:22:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 0/3] perf/probe: Fix available line bugs
Message-Id: <20191025082249.2ef5cdbe89f6c5176d785c06@kernel.org>
In-Reply-To: <20191024202327.GA19678@kernel.org>
References: <157190834681.1859.7399361844806238387.stgit@devnote2>
        <20191024134325.GA1666@kernel.org>
        <20191025003648.af4216cbf71bf2d5e60d2932@kernel.org>
        <20191024202327.GA19678@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019 17:23:27 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:


> But why can't I probe this thing again?
> 
> [root@quaco ~]# perf probe clear_tasks_mm_cpumask:0
> Probe point 'clear_tasks_mm_cpumask' not found.
>   Error: Failed to add events.
> [root@quaco ~]# perf probe clear_tasks_mm_cpumask:1
> Failed to get entry address of clear_tasks_mm_cpumask
>   Error: Failed to add events.
> [root@quaco ~]# perf probe clear_tasks_mm_cpumask:2
> Failed to get entry address of clear_tasks_mm_cpumask
>   Error: Failed to add events.
> [root@quaco ~]# perf probe clear_tasks_mm_cpumask:11
> Failed to get entry address of clear_tasks_mm_cpumask
>   Error: Failed to add events.
> [root@quaco ~]# perf probe clear_tasks_mm_cpumask:12
> Failed to get entry address of clear_tasks_mm_cpumask
>   Error: Failed to add events.
> [root@quaco ~]# perf probe clear_tasks_mm_cpumask:13
> Failed to get entry address of clear_tasks_mm_cpumask
>   Error: Failed to add events.
> root@quaco ~]#

Oops, it's a verification error in convert_to_trace_point().
I'll fix it too!

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
