Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C91744E9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 05:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgB2Etx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 23:49:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbgB2Etx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 23:49:53 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB45E246AE;
        Sat, 29 Feb 2020 04:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582951792;
        bh=DS3NNAGzQXXPBL6dUXkJQXtASwW/7FOFjDPGY+oNzvw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YdpZavzk/Y3olsp8VBNE8OWwrBOZZFKxShVq4DfJ6JhiPPxoPKo8SnZYNzREHoU1H
         jTA8o1m+SopT3xxVdb+OyQ2VYwULR+K1UbzUCp1wP443MgQDMK+vo/n7AAJXprh9UT
         mihI3g9tpciq6JMG9Crsr9P6xwWYaLHnFnBvgWLw=
Date:   Sat, 29 Feb 2020 13:49:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 03/13] kprobes: Add symbols for kprobe insn pages
Message-Id: <20200229134947.839096dbc8321cfdca980edb@kernel.org>
In-Reply-To: <20200228172004.GI5451@krava>
References: <20200228135125.567-1-adrian.hunter@intel.com>
        <20200228135125.567-4-adrian.hunter@intel.com>
        <20200228233600.5f5c733584eac08b8a4a2b70@kernel.org>
        <20200228172004.GI5451@krava>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 18:20:04 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> > BTW, it seems to pretend to be a module, but is there no concern of
> > confusing users? Shouldn't it be [*kprobes] so that it is non-exist
> > module name?
> 
> note we already have bpf symbols as [bpf] module

Yeah, and this series adds [kprobe(s)] and [ftrace] too.
I simply concern that the those module names implicitly become
special word (rule) and embedded in the code. If such module names
are not exposed to users, it is OK (but I hope to have some comments).
However, it is under /proc, which means users can notice it.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
