Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD05127189
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 00:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfLSXby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 18:31:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:34324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbfLSXbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 18:31:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D166724679;
        Thu, 19 Dec 2019 23:31:52 +0000 (UTC)
Date:   Thu, 19 Dec 2019 18:31:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-trace-devel@vger.kernel.org,
        Shuah Khan <shuahkhan@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] selftests/ftrace: fix glob selftest
Message-ID: <20191219183151.58d81624@gandalf.local.home>
In-Reply-To: <20191218074427.96184-2-svens@linux.ibm.com>
References: <20191218074427.96184-1-svens@linux.ibm.com>
        <20191218074427.96184-2-svens@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 08:44:25 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:

> test.d/ftrace/func-filter-glob.tc is failing on s390 because it has
> ARCH_INLINE_SPIN_LOCK and friends set to 'y'. So the usual
> __raw_spin_lock symbol isn't in the ftrace function list. Change
> '*aw*lock' to '*time*ns' which would hopefully match some of the
> ktime_() functions on all platforms.

This requires an ack from Masami, and this patch can go through Shuah's
tree.

Also, any patches for the Linux kernel should be Cc'd to lkml. The
linux-trace-devel is mostly for tracing tools, not kernel patches.

-- Steve

> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  .../testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
> index 27a54a17da65..a5d61667cd56 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
> @@ -30,7 +30,7 @@ ftrace_filter_check '*schedule*' '^.*schedule.*$'
>  ftrace_filter_check 'schedule*' '^schedule.*$'
>  
>  # filter by *mid*end
> -ftrace_filter_check '*aw*lock' '.*aw.*lock$'
> +ftrace_filter_check '*time*ns' '.*time.*ns$'
>  
>  # filter by start*mid*
>  ftrace_filter_check 'mutex*try*' '^mutex.*try.*'

