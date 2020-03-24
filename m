Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65610190D80
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 13:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCXMbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 08:31:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39664 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgCXMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JpBHrONiTqvkIxwALwGzclMdtFWhbbsPgYO1Au6VT9A=; b=xi148V3cnfki8/LSm70OZnEDdU
        3qPH0VHVNg1AqvpUBzftSbSwHmwPGPAkc44zTkjCQRWOukn2y2I6sIj/XSA81jMDIyFjYVvNGFbjw
        1CdI0r2AHzUPNTcpJaqmMpE2cS3aACPUWPLRDxyYVkIwSTFGwlu4uBkoXAYKi6n6RA48eyM+yGbsb
        PAzIKs2Od6nA80IVKKxVLmC+AcXcjGyfhzcTwmsNi5sU60VO5TiEmnuwIWWzWlylRtaYtsamzdQC0
        AgQCSJZYcikogJShMJWpFpZ1zs8o+2Z5+qah5jK/GCWR5sNCx3PYMrfB3l5XKUH2qKLJS/OVHOgWB
        BCynKz6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGii7-0000fh-1e; Tue, 24 Mar 2020 12:31:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B25423062B3;
        Tue, 24 Mar 2020 13:31:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D1A52019B522; Tue, 24 Mar 2020 13:31:08 +0100 (CET)
Date:   Tue, 24 Mar 2020 13:31:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 03/13] kprobes: Add symbols for kprobe insn pages
Message-ID: <20200324123108.GO20696@hirez.programming.kicks-ass.net>
References: <20200304090633.420-1-adrian.hunter@intel.com>
 <20200304090633.420-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304090633.420-4-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:06:23AM +0200, Adrian Hunter wrote:
> Symbols are needed for tools to describe instruction addresses. Pages
> allocated for kprobe's purposes need symbols to be created for them.
> Add such symbols to be visible via /proc/kallsyms.
> 
> Note: kprobe insn pages are not used if ftrace is configured. To see the
> effect of this patch, the kernel must be configured with:
> 
> 	# CONFIG_FUNCTION_TRACER is not set
> 	CONFIG_KPROBES=y
> 
> and for optimised kprobes:
> 
> 	CONFIG_OPTPROBES=y
> 
> Example on x86:
> 
> 	# perf probe __schedule
> 	Added new event:
> 	  probe:__schedule     (on __schedule)
> 	# cat /proc/kallsyms | grep '\[__builtin__kprobes\]'
> 	ffffffffc00d4000 t kprobe_insn_page     [__builtin__kprobes]
> 	ffffffffc00d6000 t kprobe_optinsn_page  [__builtin__kprobes]
> 

I'm confused; why are you iterating pages and not slots? A 'page' is not
a symbol, they contain text, sometimes.

If you iterate slots you can even get them a proper name; something
like:

	optinsn-sym+xxx [__builtin__kprobes]

	insn-sym+xxx [__builtin__kprobes]
