Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50DB159F87
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 04:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgBLD27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 22:28:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbgBLD27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:28:59 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F22D32082F;
        Wed, 12 Feb 2020 03:28:57 +0000 (UTC)
Date:   Tue, 11 Feb 2020 22:28:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, artem.bityutskiy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/3] tracing: Don't return -EINVAL when tracing soft
 disabled synth events
Message-ID: <20200211222856.67cdc386@rorschach.local.home>
In-Reply-To: <20200212122415.6dd7d33c19d1eeddae0ccfb8@kernel.org>
References: <cover.1581374549.git.zanussi@kernel.org>
        <df5d02a1625aff97c9866506c5bada6a069982ba.1581374549.git.zanussi@kernel.org>
        <20200212122415.6dd7d33c19d1eeddae0ccfb8@kernel.org>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 12:24:15 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Mon, 10 Feb 2020 17:06:49 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > There's no reason to return -EINVAL when tracing a synthetic event if
> > it's soft disabled - treat it the same as if it were hard disabled and
> > return normally.
> > 
> > Have synth_event_trace() and synth_event_trace_array() just return
> > normally, and have synth_event_trace_start set the trace state to
> > disabled and return.
> >   
> 
> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

Thanks for the review Masami, but these patches have already landed in
Linus's tree ;-)

-- Steve
