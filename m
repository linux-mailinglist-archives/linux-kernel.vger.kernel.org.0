Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE41444FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 20:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAUTWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 14:22:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:32962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgAUTWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:22:40 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C5AF20678;
        Tue, 21 Jan 2020 19:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579634559;
        bh=IFgkmdAa0Mm5sr+/85Uezi3G42yK2R9/kPC0zvCu+ng=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qmqm6pMf5yC7/ShOx8REH67pE0gPGGu4YO915BcHD+uHbRTHBJPqkBf1tV2jWZMu5
         kIde/5PF5PzHkqfBv9cWhLrRlcAhAPxWdMSFJISKODQIKTuRC70Zy4yWJkQz+TaDux
         y1X/fhdtR8pDWEH8kijgzUZJFcXDAYA4Zr6S1i/4=
Message-ID: <1579634558.19595.5.camel@kernel.org>
Subject: Re: [PATCH v2 07/12] tracing: Add trace_synth_event() and related
 functions
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Tue, 21 Jan 2020 13:22:38 -0600
In-Reply-To: <20200121120348.01399a47@gandalf.local.home>
References: <cover.1578688120.git.zanussi@kernel.org>
         <fde7210e7807c29783fff0e2a06d0561d810c7cf.1578688120.git.zanussi@kernel.org>
         <20200121120348.01399a47@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, 2020-01-21 at 12:03 -0500, Steven Rostedt wrote:
> On Fri, 10 Jan 2020 14:35:13 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > +struct synth_event;
> > +
> > +struct synth_gen_state {
> > +	struct trace_event_buffer fbuffer;
> > +	struct synth_trace_event *entry;
> > +	struct ring_buffer *buffer;
> > +	struct synth_event *event;
> > +	unsigned int cur_field;
> > +	unsigned int n_u64;
> > +	bool enabled;
> > +	bool add_next;
> > +	bool add_name;
> > +};
> > +
> 
> Yes, please rebase on my for-next branch, as the ring_buffer
> structure
> has been renamed, and will break these patches :-/
> 

OK, I'll rebase on for-next, and will also adapt a couple of Masami's
boot trace patches to these.

Thanks,

Tom

> -- Steve
