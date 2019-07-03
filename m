Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 844385E681
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfGCOYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfGCOYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:24:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CE8321850;
        Wed,  3 Jul 2019 14:24:04 +0000 (UTC)
Date:   Wed, 3 Jul 2019 10:24:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 12/16] kprobes: Initialize kprobes at
 postcore_initcall
Message-ID: <20190703102402.1319b928@gandalf.local.home>
In-Reply-To: <20190703140832.GD48312@arrakis.emea.arm.com>
References: <20190526191828.466305460@goodmis.org>
        <20190526191848.266163206@goodmis.org>
        <20190702165008.GC34718@lakrids.cambridge.arm.com>
        <20190703100205.0b58f3bf@gandalf.local.home>
        <20190703140832.GD48312@arrakis.emea.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 15:08:32 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:


> > +static int __init run_init_test_probes(void)
> > +{
> > +	if (run_kprobe_tests)
> > +		init_test_probes();  
> 
> A return 0 here.

Will update (would have triggered a failure on my test suite anyway ;-)

> 
> > +}
> > +module_init(run_init_test_probes);  
> 
> This does the trick. I prefer your fix as it leaves the arch code
> unchanged. In case you need it:
> 
> Tested-by: Catalin Marinas <catalin.marinas@arm.com>
> 

Great! Thanks.

-- Steve
