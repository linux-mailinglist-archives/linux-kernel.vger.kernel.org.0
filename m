Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5B913B226
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 19:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgANScu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 13:32:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANSct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:32:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49833222C4;
        Tue, 14 Jan 2020 18:32:48 +0000 (UTC)
Date:   Tue, 14 Jan 2020 13:32:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?= =?UTF-8?B?bnNlbg==?= 
        <thoiland@redhat.com>, Jean-Tsung Hsiao <jhsiao@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/uprobe: Fix double perf_event linking on
 multiprobe uprobe
Message-ID: <20200114133246.20b96d09@gandalf.local.home>
In-Reply-To: <20200114174503.GB4769@kernel.org>
References: <157862073931.1800.3800576241181489174.stgit@devnote2>
        <20200114173535.GA4769@kernel.org>
        <20200114124404.50a1c396@gandalf.local.home>
        <20200114174503.GB4769@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 14:45:03 -0300
Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> Em Tue, Jan 14, 2020 at 12:44:04PM -0500, Steven Rostedt escreveu:
> > On Tue, 14 Jan 2020 14:35:35 -0300
> > Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> >   
> > > If you don't mind I can put it into my next perf/urgent pull req to
> > > Ingo/Thomas,  
> > 
> > I was going to pull this into my urgent tree when my tests finish with
> > my for-next code.
> > 
> > I have one or two other patches I need to apply to urgent as well, so
> > it's not an issue for me to take this.  
> 
> Go ahead, I still need some more time for my tests with the other
> patches, please just collect my Tested-by,
>

Will do!

This also needs to run through my test suite which will take 13
hours more (after my previous one finishes, which took more than 13
because of all the patches I was testing).

-- Steve
