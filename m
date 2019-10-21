Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2EEDF6CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 22:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfJUUei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 16:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbfJUUei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:34:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BBB12067B;
        Mon, 21 Oct 2019 20:34:37 +0000 (UTC)
Date:   Mon, 21 Oct 2019 16:34:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Prateek Sood <prsood@codeaurora.org>
Subject: Re: [GIT PULL v2] tracing: A couple of minor fixes
Message-ID: <20191021163436.13acca67@gandalf.local.home>
In-Reply-To: <CAHk-=whCRAsQTKkR88bUgZ-6ET45U++47V=8L_H9YGCk7n-U7w@mail.gmail.com>
References: <20191021124508.203ccdb3@gandalf.local.home>
        <20191021151348.3a231f04@gandalf.local.home>
        <20191021151934.50342fef@gandalf.local.home>
        <CAHk-=whCRAsQTKkR88bUgZ-6ET45U++47V=8L_H9YGCk7n-U7w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 16:30:14 -0400
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Oct 21, 2019 at 3:19 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Two minor fixes:
> >
> >  - A race in perf trace initialization (missing mutexes)  
> 
> Are you sure you fixed the crud?
> 
> That commit still has a very odd commit message with an oops and
> ramdump at the top, before the explanation.
> 

I can clean it up some more. I just deleted from the original:

"Could you please confirm:
1) the race mentioned below exists or not.
2) if following patch fixes it.

>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8  "

That was in it.

These are minor fixes, so there's no rush. I'll look at it tonight and
see if I can make the change log a little nicer.

-- Steve
