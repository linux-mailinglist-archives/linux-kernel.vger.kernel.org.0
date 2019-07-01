Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1282A73B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 00:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfEYWjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 18:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfEYWjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 18:39:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CB582081C;
        Sat, 25 May 2019 22:39:53 +0000 (UTC)
Date:   Sat, 25 May 2019 18:39:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: Re: [GIT PULL] tracing: Small fixes to histogram code and header
 cleanup
Message-ID: <20190525183951.1dbe9a89@gandalf.local.home>
In-Reply-To: <CAHk-=wgseDTYAw-O7=21j4vQmufm=eZCMqeq9Z+PtCst9WkmnA@mail.gmail.com>
References: <20190524231106.5812936b@gandalf.local.home>
        <CAHk-=wgseDTYAw-O7=21j4vQmufm=eZCMqeq9Z+PtCst9WkmnA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 May 2019 10:09:19 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, May 24, 2019 at 8:11 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Tom Zanussi sent me some small fixes and cleanups to the histogram
> > code and I forgot to incorporate them.
> >
> > I also added a small clean up patch that was sent to me a while ago
> > and I just noticed it.  
> 
> Why not the warning avoidance patch? It changes no actual code, and
> avoids two 20-line build warnings for me that are very annoying..
> 

You mean this one:

 http://lkml.kernel.org/r/20190523124535.GA12931@gmail.com

?

I have it in my queue for the next merge window, but I can cherry pick
it and send it to you directly now. It's already been through my test
suite.

-- Steve
