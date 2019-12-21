Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA84128659
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 02:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfLUBXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 20:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfLUBXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 20:23:23 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ACCD2070C;
        Sat, 21 Dec 2019 01:23:22 +0000 (UTC)
Date:   Fri, 20 Dec 2019 20:23:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Shuah Khan <shuahkhan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] selftests/ftrace: fix glob selftest
Message-ID: <20191220202320.18e6c653@rorschach.local.home>
In-Reply-To: <20191220073240.GA72310@tuxmaker.boeblingen.de.ibm.com>
References: <20191218074427.96184-1-svens@linux.ibm.com>
        <20191218074427.96184-2-svens@linux.ibm.com>
        <20191219183151.58d81624@gandalf.local.home>
        <20191220162746.d0889aeac721f8e4d400db64@kernel.org>
        <20191220073240.GA72310@tuxmaker.boeblingen.de.ibm.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019 08:32:40 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:


> > Thanks Steve to CC to me.
> > BTW, are there any reason why we use different symbols for different
> > glob patterns?
> > I mean we can use 'schedul*', '*chedule' and '*sch*ule' as test
> > glob patterns.  
> 
> Don't know, but i don't see a reason why we should have different patterns. If
> there's an agreement that we prefer a common pattern i can update the patch and
> resend.


I think I liked trying other functions just to make sure that it was
working to add a bit of churn to the mix (for the unlikely case that
schedule has some fluke case).

We could just switch it all to use schedule, or we can change "aw" to
"spin".

-- Steve
