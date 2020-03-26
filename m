Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B14194743
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 20:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgCZTOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 15:14:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44624 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OuLpqFnqFDxEEO4sWNfxqmccRQkxk3DQeTo8ggfuiO4=; b=FJsueFtQNP4ma3mKBsUnC3tLbx
        EWNix8TB2fDfTL2OneTxC1ZRAJAemhRNEkPewt7pRnUfv79yrfLqLQArOfBn1SqIefiO4BuOrsHDZ
        Qkcajx+Qjeqry1LhpIuDv4CpfMpeVTBIWybdRTDjTQXyS778Eb7VfKo8dpVnp6n/q9ZJni5ky/I3d
        rVmhhOgkyHz8VjUAGmW0xSTwKpa/hs96qxaz1mzVEoJIGizdfF1vDlxYXbBC1xe69lUSyf5nwCdBV
        HM8BKGAdGr2uTKyWe/xCL/IxYXDJ0kiHjjFMrj2owAcsWPtrtGNyu4b4OvJX9QFhF1Y8oerjQGgcw
        vRriEG/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHXx2-0001js-Bb; Thu, 26 Mar 2020 19:14:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C76FE983531; Thu, 26 Mar 2020 20:13:56 +0100 (CET)
Date:   Thu, 26 Mar 2020 20:13:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        tglx <tglx@linutronix.de>, "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>
Subject: Re: [RESEND][PATCH v3 06/17] static_call: Add basic static call
 infrastructure
Message-ID: <20200326191356.GC2452@worktop.programming.kicks-ass.net>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.632535759@infradead.org>
 <12A30BA0-18DA-4748-B82F-6008179CC88C@vmware.com>
 <20200326170128.GQ20713@hirez.programming.kicks-ass.net>
 <9D47A4CA-39AD-4408-879B-677BE9D891B7@vmware.com>
 <20200326182823.GB2452@worktop.programming.kicks-ass.net>
 <313E79F2-E277-4C66-97C8-40B545B58370@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <313E79F2-E277-4C66-97C8-40B545B58370@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 07:02:33PM +0000, Nadav Amit wrote:
> On another note - it may be beneficial to see if the infrastructure that you
> built can accommodate notifier-chains. It is not the most painful point, but
> it would be nice to deal with those as well. Since many of those are changed
> asynchronously, I am not sure it is the easiest thing to do.

You mean, like patch 12 does?
