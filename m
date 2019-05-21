Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D2124F72
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 14:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfEUM5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 08:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEUM5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:57:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 744DA21773;
        Tue, 21 May 2019 12:57:42 +0000 (UTC)
Date:   Tue, 21 May 2019 08:57:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <20190521085741.7305dc78@gandalf.local.home>
In-Reply-To: <20190521082809.GA112373@gmail.com>
References: <155789866428.26965.8344923934342528416.stgit@devnote2>
        <20190515055534.GA39270@gmail.com>
        <20190520112605.421bda88@gandalf.local.home>
        <20190521082809.GA112373@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 10:28:09 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> > Hi Ingo,
> > 
> > Do you want me to take this through my tree, or do you want to take it
> > through yours?  
> 
> Since these changes are more heavy on the kernel/tracing/ side I suspect 
> your tree is the better match for this series?

No problem. Will do, and thanks for the Ack.

-- Steve
