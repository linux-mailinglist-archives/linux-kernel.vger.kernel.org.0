Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C721152625
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 06:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgBEFws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 00:52:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgBEFwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 00:52:47 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 710992082E;
        Wed,  5 Feb 2020 05:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580881967;
        bh=RYm6OkKoPDFyjjlGy+TOLXYD4QA86s0eqri85Y92Rns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CqrWQqfE36+0834RvvnTWoz22iTytl8y2o3pLOaU0FJl8VU8gX+D4gTZtfBNxi6+Z
         mBfHnm5xLcjF+yaNmFEVlodNFpK/RONWG31k/1Bttz1RK3SkCZbNgpoehP5RKx/hGp
         +FvDFyMdXbrSxf15ix3d725d6EIAassrPY008ZCk=
Date:   Wed, 5 Feb 2020 14:52:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] bootconfig: Only load bootconfig if "bootconfig" is
 on the kernel cmdline
Message-Id: <20200205145243.4ce51dadcad98cb2fe46c7ce@kernel.org>
In-Reply-To: <20200204194759.188eef89@oasis.local.home>
References: <20200204110446.2c2616cd@oasis.local.home>
        <20200205090610.fa3d0dcd5b2fea22e40991cf@kernel.org>
        <20200204194759.188eef89@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2020 19:47:59 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 5 Feb 2020 09:06:10 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> >
> > 
> > Thanks for adding this feature :) This looks good to me.
> > Please add my ack when you fix the error message of "config=bootconfig".
> 
> I'm changing it to just "bootconfig", is that OK with you?

Yes, sorry about non-clear message.

Thanks,

> 
> -- Steve
> 
> > 
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Thank you!
> > 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
