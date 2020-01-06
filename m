Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D39811319F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 22:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgAFVAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 16:00:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgAFVAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:00:46 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DF4E2072C;
        Mon,  6 Jan 2020 20:52:33 +0000 (UTC)
Date:   Mon, 6 Jan 2020 15:52:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        users@linux.kernel.org
Subject: Re: [kernel.org users] [RFC] tools lib traceevent: How to do
 library versioning being in the Linux kernel source?
Message-ID: <20200106155232.4061d755@gandalf.local.home>
In-Reply-To: <20200106204715.GA22353@ziepe.ca>
References: <20200102122004.216c85da@gandalf.local.home>
        <20200102234950.GA14768@krava>
        <20200102185853.0ed433e4@gandalf.local.home>
        <20200103133640.GD9715@krava>
        <20200103181614.7aa37f6d@gandalf.local.home>
        <20200106151902.GB236146@krava>
        <20200106162623.GA11285@kernel.org>
        <20200106113615.4545e3c5@gandalf.local.home>
        <20200106204715.GA22353@ziepe.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2020 16:47:15 -0400
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> If it is not tightly linked to the kernel and is just a normal

Well, it's used by perf, trace-cmd, power-top and rasdaemon (and
perhaps even more). It lives in the kernel tree mainly because of perf.

> library, you might consider using github. This is what we do for the
> rdma user space and it works well. We still take patches from the
> mailing list flow, but do use a fair amount of the github stuff too:
> 
> https://github.com/linux-rdma/rdma-core
> 
> With github actions now able to provide a quite good CI it covers a
> lot of required stuff for a library in one place, in a way that
> doesn't silo all the build infrastucture.

Github has ways to help with libraries? I'm totally clueless about
this. I'm interested in hearing more.

Thanks,

-- Steve


> 
> If you are interested in how we set it up I can write a longer email.

