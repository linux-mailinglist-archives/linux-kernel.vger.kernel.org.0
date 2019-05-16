Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D08B51FD0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 03:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfEPBqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 21:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfEPA1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 20:27:30 -0400
Received: from oasis.local.home (50-204-120-225-static.hfc.comcastbusiness.net [50.204.120.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2FF20862;
        Thu, 16 May 2019 00:27:29 +0000 (UTC)
Date:   Wed, 15 May 2019 20:27:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] tracing: Updates for 5.2
Message-ID: <20190515202729.3d62422c@oasis.local.home>
In-Reply-To: <CAHk-=wjbVZcZXkq5xOnBk3ibXorEYKdmRG5YFzzV-Rw3Q-VUEA@mail.gmail.com>
References: <20190515133614.31dcbbe0@oasis.local.home>
        <CAHk-=wihYB8w__YQjgYjYZsVniu5CtkTcFycmCGdqVg8GUje7g@mail.gmail.com>
        <CAHk-=wjbVZcZXkq5xOnBk3ibXorEYKdmRG5YFzzV-Rw3Q-VUEA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019 16:31:34 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, May 15, 2019 at 4:29 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > One option is to just rewrite it something like
> >
> >         const unsigned int offset = offsetof(struct trace_iterator, seq);
> >         memset(offset+(void *)&iter, 0, sizeof(iter) - offset);  
> 
> Side note: make it a well-named helper function, since
> "ftrace_dump_buf()" does this too in kernel/trace/trace_kdb.c, and

Good point, as they just cut and pasted some of this code.

I like the helper function, as it means I don't need to add the sub
part, as the function would be more contained.

> gets the exact same warning.
> 

I can do this, but it needs testing and all that before sending to you,
and may not make the merge window. Is that fine?

-- Steve
