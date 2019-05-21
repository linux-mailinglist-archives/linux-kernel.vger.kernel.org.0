Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7971254AA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 17:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfEUP5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 11:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbfEUP5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:57:47 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 237B321019;
        Tue, 21 May 2019 15:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558454267;
        bh=1Bh1Tg7s/wagirS6dPhNWQg4keyX0vwUofJoXOufznw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B1855i2dCLbv4nj0YTcUyIET8vG/CjPa9pw/gA5SHx17bcQBrqUlcVKzKhu8tuyla
         KYKrk67j+WgSbryQScFh2QjbPJI/yBVXnrRLdgPFkDG/pURH3BKF8jNbbdzRC83p9h
         sTqffmx0/5x8kYXweguxnuTaF+l45vTt2mVodE8I=
Date:   Wed, 22 May 2019 00:57:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: Re: [PATCH -tip v9 0/6] tracing/probes: uaccess: Add support
 user-space access
Message-Id: <20190522005741.5bc134a712970cac8e260b01@kernel.org>
In-Reply-To: <20190521085741.7305dc78@gandalf.local.home>
References: <155789866428.26965.8344923934342528416.stgit@devnote2>
        <20190515055534.GA39270@gmail.com>
        <20190520112605.421bda88@gandalf.local.home>
        <20190521082809.GA112373@gmail.com>
        <20190521085741.7305dc78@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 08:57:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 21 May 2019 10:28:09 +0200
> Ingo Molnar <mingo@kernel.org> wrote:
> 
> > > Hi Ingo,
> > > 
> > > Do you want me to take this through my tree, or do you want to take it
> > > through yours?  
> > 
> > Since these changes are more heavy on the kernel/tracing/ side I suspect 
> > your tree is the better match for this series?
> 
> No problem. Will do, and thanks for the Ack.

Thank you Steve for picking it up!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
