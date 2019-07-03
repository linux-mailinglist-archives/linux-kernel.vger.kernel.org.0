Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3315ED19
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 22:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfGCUBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 16:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfGCUBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:01:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D86421882;
        Wed,  3 Jul 2019 20:01:29 +0000 (UTC)
Date:   Wed, 3 Jul 2019 16:01:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, shuah <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] ftrace/selftest: Test if set_event/ftrace_pid
 exists before writing
Message-ID: <20190703160128.46c98009@gandalf.local.home>
In-Reply-To: <20190703160009.31ef5cb7@gandalf.local.home>
References: <20190703194959.596805445@goodmis.org>
        <20190703195300.408302485@goodmis.org>
        <20190703160009.31ef5cb7@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 16:00:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> > index 779ec11f61bd..a7b06291e32c 100644
> > --- a/tools/testing/selftests/ftrace/test.d/functions
> > +++ b/tools/testing/selftests/ftrace/test.d/functions
> > @@ -91,8 +91,8 @@ initialize_ftrace() { # Reset ftrace to initial-state
> >      reset_events_filter
> >      reset_ftrace_filter
> >      disable_events
> > -    echo > set_event_pid	# event tracer is always on
> > -    echo > set_ftrace_pid
> > +    [ -f set_event_pid ] && echo > set_event_pid  # event tracer is always on  
> 
> I probably should remove that comment, because I believe that was why
> it wasn't tested :-/

Masami,

I'll wait for your review before posting a v2 without this comment.

-- Steve
