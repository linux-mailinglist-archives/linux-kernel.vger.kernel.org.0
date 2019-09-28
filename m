Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841ADC101D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 09:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfI1H47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Sep 2019 03:56:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfI1H46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 03:56:58 -0400
Received: from devnote2 (unknown [12.157.10.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 985742081B;
        Sat, 28 Sep 2019 07:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569657418;
        bh=g25bV1WdxtGU+b3JNxNBVCRry5AkbtKwGhn0cs1fGLU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g7nhWH+H83f3brhv8F25SCu2TcqFjtMqFsgCFXzZsnnP8fst0uJQAtqSHnzmycLyN
         /xoMe/qM3+UH2ZqQ1MpOkEx5U7GLIGlnoZ+84M/CjkzAqWNmtOSa9ZgRr86p+DvJ0v
         N6bLD0hYXRv/TGBDdE9QTREhIDmTtGx8Oa5hHA2k=
Date:   Sat, 28 Sep 2019 00:56:56 -0700
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Fix same probe error test
Message-Id: <20190928005656.cf7553118ebf292a3d44a59d@kernel.org>
In-Reply-To: <20190927112514.00cc6e92@oasis.local.home>
References: <20190927112514.00cc6e92@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2019 11:25:14 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The "same probe" selftest that tests that adding the same probe fails
> doesn't add the same probe and passes, which fails the test.
> 
> Fixes: b78b94b82122 ("selftests/ftrace: Update kprobe event error testcase")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Oops, thanks!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> ---
>  .../selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> index 8a4025e912cb..ef1e9bafb098 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> @@ -95,7 +95,7 @@ echo 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
>  check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
>  check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
>  check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
> -check_error '^p:kprobes/testevent _do_fork'	# SAME_PROBE
> +check_error '^p:kprobes/testevent _do_fork abcd=\1'	# SAME_PROBE
>  fi
>  
>  exit 0
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
