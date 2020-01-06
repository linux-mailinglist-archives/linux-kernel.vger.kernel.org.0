Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A955C131627
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 17:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgAFQgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 11:36:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFQgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:36:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A192207FF;
        Mon,  6 Jan 2020 16:36:16 +0000 (UTC)
Date:   Mon, 6 Jan 2020 11:36:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        users@linux.kernel.org
Subject: Re: [RFC] tools lib traceevent: How to do library versioning being
 in the Linux kernel source?
Message-ID: <20200106113615.4545e3c5@gandalf.local.home>
In-Reply-To: <20200106162623.GA11285@kernel.org>
References: <20200102122004.216c85da@gandalf.local.home>
        <20200102234950.GA14768@krava>
        <20200102185853.0ed433e4@gandalf.local.home>
        <20200103133640.GD9715@krava>
        <20200103181614.7aa37f6d@gandalf.local.home>
        <20200106151902.GB236146@krava>
        <20200106162623.GA11285@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2020 13:26:23 -0300
Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> So, we have:
> 
> https://www.kernel.org/pub/linux/kernel/tools/perf/
> 
> trying to mimic the kernel sources tree structure, so perhaps we could
> have:
> 
> https://www.kernel.org/pub/linux/kernel/tools/lib/{perf,traceevent}/
> 
> To continue that directory tree mirror?

Wouldn't that become a bit of manual work. Unlike perf, the versions
will not correspond to the Linux kernel versions. They would need to
follow library versioning.

It would at a minimum require new scripting to get this right.

-- Steve
