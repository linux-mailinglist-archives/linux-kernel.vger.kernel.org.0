Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8E6149CE8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 21:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgAZUuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 15:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgAZUuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 15:50:15 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9BD206F0;
        Sun, 26 Jan 2020 20:50:14 +0000 (UTC)
Date:   Sun, 26 Jan 2020 15:50:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [for-next][PATCH 7/7] tracing: Use pr_err() instead of WARN()
 for memory failures
Message-ID: <20200126155013.5cfc23aa@rorschach.local.home>
In-Reply-To: <e70ff75e9712478704fad44ac6b66c86a45df6a6.camel@perches.com>
References: <20200126191932.984391723@goodmis.org>
        <20200126192021.350763989@goodmis.org>
        <e70ff75e9712478704fad44ac6b66c86a45df6a6.camel@perches.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jan 2020 12:38:55 -0800
Joe Perches <joe@perches.com> wrote:

> On Sun, 2020-01-26 at 14:19 -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > As warnings can trigger panics, especially when "panic_on_warn" is set,
> > memory failure warnings can cause panics and fail fuzz testers that are
> > stressing memory.
> > 
> > Create a MEM_FAIL() macro to use instead of WARN() in the tracing code
> > (perhaps this should be a kernel wide macro?), and use that for memory
> > failure issues. This should stop failing fuzz tests due to warnings.  
> 
> It looks as if most of these could just be removed instead
> as there is an existing dump_stack() on failure.

That sounds more generic. This is specific for my own tracing tests to
look for. As the point is, it is *not* to dump_stack, and still report
the error.

-- Steve
