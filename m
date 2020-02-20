Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E9916673E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 20:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgBTTeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 14:34:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgBTTeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:34:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CEC4208C4;
        Thu, 20 Feb 2020 19:34:14 +0000 (UTC)
Date:   Thu, 20 Feb 2020 14:34:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, artem.bityutskiy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] tracing: Skip software disabled event at
 __synth_event_trace_end()
Message-ID: <20200220143412.65432e7c@gandalf.local.home>
In-Reply-To: <20200217183340.121fed47e680584c4ca6dd93@kernel.org>
References: <158148685911.20407.3538292497442671878.stgit@devnote2>
        <20200217183340.121fed47e680584c4ca6dd93@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 18:33:40 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> >  static inline void
> >  __synth_event_trace_end(struct synth_event_trace_state *trace_state)
> >  {
> > +	if (trace_state->disabled)
> > +		return;
> > +  
> 
> Aah, I assumed that trace_state should be initialized with 0, but
> in really, it could be just allocated on the stack.
> We has to set trace_state->disabled = false in __synth_event_trace_start().

Is this patch good enough to take, or is there another one coming?

-- Steve
