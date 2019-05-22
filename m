Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 936B326617
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 16:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfEVOki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 10:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbfEVOki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:40:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E86020879;
        Wed, 22 May 2019 14:40:36 +0000 (UTC)
Date:   Wed, 22 May 2019 10:40:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC][PATCH 00/14 v2] function_graph: Rewrite to allow multiple
 users
Message-ID: <20190522104027.1b2aabd8@gandalf.local.home>
In-Reply-To: <20190522231955.72899b0d606adb919e8716ff@kernel.org>
References: <20190520142001.270067280@goodmis.org>
        <20190522231955.72899b0d606adb919e8716ff@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 23:19:55 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> >  void *fgraph_reserve_data(int size_in_bytes)
> > 
> >     Allows the entry function to reserve up to 4 words of data on
> >     the shadow stack. On success, a pointer to the contents is returned.
> >     This may be only called once per entry function.
> > 
> >  void *fgraph_retrieve_data(void)
> > 
> >     Allows the return function to retrieve the reserved data that was
> >     allocated by the entry function.  
> 
> Nice! this seems good for kretprobe too. I'll review and try to port
> kretprobe on this framework.

If you rather pull from my git repo and not download all the patches,
they are currently available in my ftrace/fgraph-multi branch.

-- Steve
