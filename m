Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C74F14DB05
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 13:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgA3Mya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 07:54:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbgA3Mya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:54:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D83DD20702;
        Thu, 30 Jan 2020 12:54:28 +0000 (UTC)
Date:   Thu, 30 Jan 2020 07:54:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        borntraeger@de.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf test: Test case 66 broken on s390 (lib/traceevent
 issue)
Message-ID: <20200130075427.303478a0@gandalf.local.home>
In-Reply-To: <20200130105804.GD3841@kernel.org>
References: <20200124073941.39119-1-tmricht@linux.ibm.com>
        <20200124100742.4050c15e@gandalf.local.home>
        <20200125013153.46f05fc1f617fcd341e7060b@kernel.org>
        <20200124113610.662f4afb@gandalf.local.home>
        <659928a1-95b3-ed0d-7988-745d92b495d6@linux.ibm.com>
        <20200127105553.3cd92ef8@gandalf.local.home>
        <20200130105804.GD3841@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020 11:58:04 +0100
Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> Em Mon, Jan 27, 2020 at 10:55:53AM -0500, Steven Rostedt escreveu:
> > On Mon, 27 Jan 2020 08:34:23 +0100
> > Thomas Richter <tmricht@linux.ibm.com> wrote:
> >   
> > > Steven and Masami,
> > > 
> > > thanks for the patch, it fixes this issue!  
> > 
> > Thanks for letting me know. I'll add a:
> > 
> >   Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> > 
> > to the commit.  
> 
> So you're taking it, right?

Yes (Linus already has it in his tree), because it was a kernel fix. The
tools lib traceevent does not need to be changed for this.

-- Steve
