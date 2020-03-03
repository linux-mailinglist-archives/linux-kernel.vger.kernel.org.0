Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A63176CBF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 03:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgCCC6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 21:58:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbgCCC6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:58:44 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF1062166E;
        Tue,  3 Mar 2020 02:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583204323;
        bh=f9xV/eWY/rwskCqYR2yqEJNGHdDtaNPeUxuxL49T+Ac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dNoPxFpKJBE86vFwZdoo3a4tx3MuutdydtjpGxdR/ztdb8DTREfm5hDI/2zN53xnC
         tIA36GrORZFqkWxzPf3YyZIEv/rr64M3R3vBZgJypfKzRULNAC7RertavLryoHe6Mu
         MeAnejynMcszJqiRmhIluUqXpKN28I++7cwyW1Jg=
Date:   Tue, 3 Mar 2020 11:58:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3] Documentation: bootconfig: Update boot configuration
 documentation
Message-Id: <20200303115839.4a18738d5d0d5899c6e1cf32@kernel.org>
In-Reply-To: <20200302151939.1a83a5ed@gandalf.local.home>
References: <158313621831.3082.9886161529613724376.stgit@devnote2>
        <158313622831.3082.8237132211731864948.stgit@devnote2>
        <20200302125033.4a62e88e@lwn.net>
        <20200302150802.348b814e@gandalf.local.home>
        <20200302131351.1b51a58e@lwn.net>
        <20200302151939.1a83a5ed@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 15:19:39 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 2 Mar 2020 13:13:51 -0700
> Jonathan Corbet <corbet@lwn.net> wrote:
> 
> > On Mon, 2 Mar 2020 15:08:02 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > > So I tried to apply this but failed - it's built on other changes to
> > > > bootconfig.rst that went into linux-next via Steve's tree.  So Steve,
> > > > would you like to take this one too?    
> > > 
> > > All my changes in linux-next have already hit Linus's tree. I haven't
> > > started pushing my next merge window changes yet. Are you up to date with
> > > Linus?  
> > 
> > I try not to do too many backmerges with mainline, so no.  I can pull
> > forward if I have to, I guess.
> >
> 
> I can add it to my tree, but I may not send it to Linus unless I have
> another urgent request to send to him. So it may not make it till the next
> merge window.

OK, then I'll wait for the next window. Anyway, I found a mistake and
it needs to be updated (again).

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
