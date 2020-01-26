Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBBC149D13
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 22:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgAZVkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 16:40:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgAZVkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 16:40:35 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC83220702;
        Sun, 26 Jan 2020 21:40:34 +0000 (UTC)
Date:   Sun, 26 Jan 2020 16:40:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [for-next][PATCH 7/7] tracing: Use pr_err() instead of WARN()
 for memory failures
Message-ID: <20200126164032.7ac82cc0@rorschach.local.home>
In-Reply-To: <5b221ac7e49666b76cd9ca368b37e721cfb4aa9c.camel@perches.com>
References: <20200126191932.984391723@goodmis.org>
        <20200126192021.350763989@goodmis.org>
        <e70ff75e9712478704fad44ac6b66c86a45df6a6.camel@perches.com>
        <20200126155013.5cfc23aa@rorschach.local.home>
        <5b221ac7e49666b76cd9ca368b37e721cfb4aa9c.camel@perches.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jan 2020 13:07:36 -0800
Joe Perches <joe@perches.com> wrote:

> > That sounds more generic. This is specific for my own tracing tests to
> > look for. As the point is, it is *not* to dump_stack, and still report
> > the error.  
> 
> __GFP_NOWARN is available too.

I honestly don't care if there's a dump_stack or not. I just removed the
WARN_ON. If the allocation causes a dump_stack() then that's fine, but
I still like to have a bit more information at what failed to allocate,
than just a offset into a function.

The point of this patch was simply to remove WARN_ON() that caused
fuzzers to fail.

-- Steve
