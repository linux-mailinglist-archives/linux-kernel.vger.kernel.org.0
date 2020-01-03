Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4CE12FF0B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 00:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgACXQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 18:16:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgACXQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 18:16:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AAFE24649;
        Fri,  3 Jan 2020 23:16:16 +0000 (UTC)
Date:   Fri, 3 Jan 2020 18:16:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>,
        users@linux.kernel.org
Subject: Re: [RFC] tools lib traceevent: How to do library versioning being
 in the Linux kernel source?
Message-ID: <20200103181614.7aa37f6d@gandalf.local.home>
In-Reply-To: <20200103133640.GD9715@krava>
References: <20200102122004.216c85da@gandalf.local.home>
        <20200102234950.GA14768@krava>
        <20200102185853.0ed433e4@gandalf.local.home>
        <20200103133640.GD9715@krava>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Added Konstantin and kernel.org users mailing list ]

On Fri, 3 Jan 2020 14:36:40 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> On Thu, Jan 02, 2020 at 06:58:53PM -0500, Steven Rostedt wrote:
> > On Fri, 3 Jan 2020 00:49:50 +0100
> > Jiri Olsa <jolsa@redhat.com> wrote:
> >   
> > > > Should we move libtraceevent into a stand alone git repo (on
> > > > kernel.org), that can have tags and branches specifically for it? We
> > > > can keep a copy in the Linux source tree for perf to use till it    
> > > 
> > > so libbpf 'moved' for this reason to github repo,
> > > but keeping the kernel as the true/first source,
> > > and updating github repo when release is ready
> > > 
> > > libbpf github repo is then source for fedora (and others)
> > > package  
> > 
> > Ah, so perhaps I should follow this? I could keep it a kernel.org repo
> > (as I rather have it there anyway).  
> 
> sounds good, and if it works out, we'll follow you with libperf :-)
> 
> if you want to check on the libbpf:
>   https://github.com/libbpf/libbpf
> 
> there might be some syncs scripts worth checking

I wonder if there should be a:

  git://git.kernel.org/pub/scm/utils/lib/

directory to have:

  git://git.kernel.org/pub/scm/utils/lib/traceevent/
  git://git.kernel.org/pub/scm/utils/lib/libbpf/
  git://git.kernel.org/pub/scm/utils/lib/libperf/

That could hold the libraries that are tight to the kernel?

-- Steve


> 
> jirka
> 
> > 
> > We can have the tools/lib/traceevent be the main source, but then just
> > copy it to the stand alone for releases.
> > 
> > Sudip, would this work for you too? (and yes, I plan on acking that
> > patch for the -ldl change, after looking at it a little bit more).
> > 
> > -- Steve
> >   

