Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22C2A17C13C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 16:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgCFPHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 10:07:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgCFPHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:07:17 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A9C120409;
        Fri,  6 Mar 2020 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583507237;
        bh=vZ1lWakiK0Z+Z51w7LxGAodml2VPRcn0JzZWPGmT7QI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oa+pzMKYCYPXBRS8Gor2uE+igPLz/f6HaCWnQbdHtMKCTtStbltIdq8TfVvUX+OHi
         7rSiz/XcReljm6yZp6KQAeqq4maxUbPeLBjV3eIgO4Yx/VhpLS32xF15dquM4X5kZj
         K2osju4xyRGuiAKR4UIcJ1UjDt8/Mbc4YOfMMO+8=
Date:   Sat, 7 Mar 2020 00:07:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [BUGFIX PATCH] tools: Let O= makes handle a relative path with
 -C option
Message-Id: <20200307000712.62c32a04c794b9a12e2342bb@kernel.org>
In-Reply-To: <CAMuHMdXSNwPwxOTDxK09LKTyOwL=LqTH6+HZRd=RY4P5VHg5Ew@mail.gmail.com>
References: <9e7beb31-b41f-9e95-c92b-1829e420af77@infradead.org>
        <158338818292.25448.7161196505598269976.stgit@devnote2>
        <CAMuHMdXSNwPwxOTDxK09LKTyOwL=LqTH6+HZRd=RY4P5VHg5Ew@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Geert,

So Randy, what you will get if you add "echo $(PWD)" instead of "cd $(PWD)" ?
Is that still empty or shows the tools/bootconfig directory?

Thanks,


On Fri, 6 Mar 2020 08:52:40 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> CC +kbuild, -stable
> 
> On Thu, Mar 5, 2020 at 7:03 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > When I compiled tools/bootconfig from top directory with
> > -C option, the O= option didn't work correctly if I passed
> > a relative path.
> >
> >   $ make O=./builddir/ -C tools/bootconfig/
> >   make: Entering directory '/home/mhiramat/ksrc/linux/tools/bootconfig'
> >   ../scripts/Makefile.include:4: *** O=./builddir/ does not exist.  Stop.
> >   make: Leaving directory '/home/mhiramat/ksrc/linux/tools/bootconfig'
> >
> > The O= directory existence check failed because the check
> > script ran in the build target directory instead of the
> > directory where I ran the make command.
> >
> > To fix that, once change directory to $(PWD) and check O=
> > directory, since the PWD is set to where the make command
> > runs.
> >
> > Fixes: c883122acc0d ("perf tools: Let O= makes handle relative paths")
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/scripts/Makefile.include |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> > index ded7a950dc40..6d2f3a1b2249 100644
> > --- a/tools/scripts/Makefile.include
> > +++ b/tools/scripts/Makefile.include
> > @@ -1,8 +1,8 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  ifneq ($(O),)
> >  ifeq ($(origin O), command line)
> > -       dummy := $(if $(shell test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
> > -       ABSOLUTE_O := $(shell cd $(O) ; pwd)
> > +       dummy := $(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
> > +       ABSOLUTE_O := $(shell cd $(PWD); cd $(O) ; pwd)
> >         OUTPUT := $(ABSOLUTE_O)/$(if $(subdir),$(subdir)/)
> >         COMMAND_O := O=$(ABSOLUTE_O)
> >  ifeq ($(objtree),)
> >


-- 
Masami Hiramatsu <mhiramat@kernel.org>
