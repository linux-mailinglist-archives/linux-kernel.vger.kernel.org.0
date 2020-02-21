Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55DD7166B88
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 01:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgBUAWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 19:22:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbgBUAWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:22:34 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B53E207FD;
        Fri, 21 Feb 2020 00:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582244554;
        bh=3zzigx0wsPNwcqVybdA7xBVz/mTSBm8jN2Gi+VxS/zw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iKNJCd68G3Msz/J6bM51p7M3hGTkXIfusPfoNOqGx3KT4S94bSxoLTscqWYY4FpPX
         gUZmZz2O97guy5NOwJeqF16N+Kr0AnuMB9u/ddr3GqnqCLuKb0wzQBG+nyrLZVI7qZ
         slOsl6RA33UAap6MArD8/i2Tz2dSil4w1ozr/iPw=
Date:   Fri, 21 Feb 2020 09:22:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing: Have synthetic event test use
 raw_smp_processor_id()
Message-Id: <20200221092230.6ec9160d0ae135b14f29fd8c@kernel.org>
In-Reply-To: <1582236880.12738.5.camel@kernel.org>
References: <20200220162950.35162579@gandalf.local.home>
        <1582236880.12738.5.camel@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 16:14:40 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Steve,
> 
> On Thu, 2020-02-20 at 16:29 -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > The test code that tests synthetic event creation pushes in as one of
> > its
> > test fields the current CPU using "smp_processor_id()". As this is
> > just
> > something to see if the value is correctly passed in, and the actual
> > CPU
> > used does not matter, use raw_smp_processor_id(), otherwise with
> > debug
> > preemption enabled, a warning happens as the smp_processor_id() is
> > called
> > without preemption enabled.
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Makes sense - I guess it's simpler than Masami's and fine for this
> purpose.
> 
> Reviewed-by: Tom Zanussi <zanussi@kernel.org>

Hmm, can we reserve ring buffer on CPU1 and commit it on CPU2?
Shouldn't we disable preemption between them?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
