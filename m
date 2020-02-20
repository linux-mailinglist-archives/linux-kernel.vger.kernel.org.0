Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D590166785
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 20:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgBTTvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 14:51:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgBTTvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:51:50 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C490206E2;
        Thu, 20 Feb 2020 19:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582228309;
        bh=inbcbcpwi5tQ6Mt2SNqbNgb0gw+R9VogWJuC9bHVY+I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Kctczxrrh91HLKuFd73ECPF0UaWVGxACvyapJC0utBRhBKmwF00G3MRGwh8cG3NyR
         OraqzAzXWRLA5KRXpovUYbuvHhCCCZ/OhurXeNCcfTAeHzTeyE33Ejzw4hRl622KL3
         7oV0yBI93zaJuVSPfy78Zd0zymxd9t0WKAOx8ETc=
Message-ID: <1582228308.12738.1.camel@kernel.org>
Subject: Re: [PATCH] tracing: Skip software disabled event at
 __synth_event_trace_end()
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Thu, 20 Feb 2020 13:51:48 -0600
In-Reply-To: <20200220143412.65432e7c@gandalf.local.home>
References: <158148685911.20407.3538292497442671878.stgit@devnote2>
         <20200217183340.121fed47e680584c4ca6dd93@kernel.org>
         <20200220143412.65432e7c@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, 2020-02-20 at 14:34 -0500, Steven Rostedt wrote:
> On Mon, 17 Feb 2020 18:33:40 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > >  static inline void
> > >  __synth_event_trace_end(struct synth_event_trace_state
> > > *trace_state)
> > >  {
> > > +	if (trace_state->disabled)
> > > +		return;
> > > +  
> > 
> > Aah, I assumed that trace_state should be initialized with 0, but
> > in really, it could be just allocated on the stack.
> > We has to set trace_state->disabled = false in
> > __synth_event_trace_start().
> 
> Is this patch good enough to take, or is there another one coming?
> 

I think this patch is good to take.  The fix for setting trace_state-
>disabled to false would be covered by this later patch:

  [PATCH 2/2] tracing: Clear trace_state when starting trace

https://lore.kernel.org/lkml/158193315899.8868.1781259176894639952.stgit@devnote2/

Tom

> -- Steve
