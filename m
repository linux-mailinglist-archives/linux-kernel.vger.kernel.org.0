Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 858FC127675
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 08:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfLTH1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 02:27:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfLTH1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:27:52 -0500
Received: from devnote2 (unknown [220.96.9.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 732C624679;
        Fri, 20 Dec 2019 07:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576826871;
        bh=C3/+t09+JlYgXJMiyf/c69h3aWt3GYU+pk/ofLVh8Fs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HIz/Z212wye7ju9Tty7e9/kVztJFHp+gGsEHEAGGPk9VMMUeUOf3J0U63GnGqinGe
         NYjb3XgYkt/Eilfj2UywlpBzZFGiyQjVAJ7c4XlEYbhWv/iMVaJfOPmK7XZ+GrT6Pz
         hFQC7q5hRaTNJR1CHmsNxcgMIqouP1ZOJkNpKgMg=
Date:   Fri, 20 Dec 2019 16:27:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        linux-trace-devel@vger.kernel.org,
        Shuah Khan <shuahkhan@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] selftests/ftrace: fix glob selftest
Message-Id: <20191220162746.d0889aeac721f8e4d400db64@kernel.org>
In-Reply-To: <20191219183151.58d81624@gandalf.local.home>
References: <20191218074427.96184-1-svens@linux.ibm.com>
        <20191218074427.96184-2-svens@linux.ibm.com>
        <20191219183151.58d81624@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019 18:31:51 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 18 Dec 2019 08:44:25 +0100
> Sven Schnelle <svens@linux.ibm.com> wrote:
> 
> > test.d/ftrace/func-filter-glob.tc is failing on s390 because it has
> > ARCH_INLINE_SPIN_LOCK and friends set to 'y'. So the usual
> > __raw_spin_lock symbol isn't in the ftrace function list. Change
> > '*aw*lock' to '*time*ns' which would hopefully match some of the
> > ktime_() functions on all platforms.
> 
> This requires an ack from Masami, and this patch can go through Shuah's
> tree.
> 
> Also, any patches for the Linux kernel should be Cc'd to lkml. The
> linux-trace-devel is mostly for tracing tools, not kernel patches.

Thanks Steve to CC to me.
BTW, are there any reason why we use different symbols for different
glob patterns?
I mean we can use 'schedul*', '*chedule' and '*sch*ule' as test
glob patterns.

Thank you,

> 
> -- Steve
> 
> > 
> > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> > ---
> >  .../testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc  | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
> > index 27a54a17da65..a5d61667cd56 100644
> > --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
> > @@ -30,7 +30,7 @@ ftrace_filter_check '*schedule*' '^.*schedule.*$'
> >  ftrace_filter_check 'schedule*' '^schedule.*$'
> >  
> >  # filter by *mid*end
> > -ftrace_filter_check '*aw*lock' '.*aw.*lock$'
> > +ftrace_filter_check '*time*ns' '.*time.*ns$'
> >  
> >  # filter by start*mid*
> >  ftrace_filter_check 'mutex*try*' '^mutex.*try.*'
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
