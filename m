Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6C318F48F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 13:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgCWM3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 08:29:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCWM3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x2GYiYbIlLLJAd/cDAIRQqv1UKwDNeF6qS0RKGALnxs=; b=ahWQT4oRunLOQfWx+/YgU7BuKf
        r2STLJjPL8AJuAece++T+Ran8pvzOsr1R3KPx/HrXqrAkyFJRZGl2q+ZiLn9FN3AJzaXEwVsHFNlf
        OGh2ONFrC43Q/x65YarB/rclZuXPiGEFjQ05zr0Qo7ADv1GUE6lnN/Ou5xFkqcikB0wDvn+pRytPh
        dGorFvFJK7rPc82mffHuc7WA/ZjmzDksPSUb4iPLIJmVG9lzJ61HUQEOEvXa45vwF3trnsj9Jbumn
        rKdNxUgBVNTBAiFheYS/JXGH9pr2eZH7742vl2NV0N43a+eHi7HsoQiF22EvjxRrsyesYZbSNKcRK
        HoBZfSbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGMCt-00052M-Rr; Mon, 23 Mar 2020 12:29:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41683983504; Mon, 23 Mar 2020 13:29:25 +0100 (CET)
Date:   Mon, 23 Mar 2020 13:29:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf test x86: address multiplexing in rdpmc test
Message-ID: <20200323122925.GH2452@worktop.programming.kicks-ass.net>
References: <20200321173710.127770-1-irogers@google.com>
 <20200322101848.GF2452@worktop.programming.kicks-ass.net>
 <20200322231820.GB267978@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322231820.GB267978@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 04:18:20PM -0700, Andi Kleen wrote:
> > Here's something a little better. Much of it copied from linux/math64.h
> > and asm/div64.h.
> 
> Not sure what the point is of micro optimizing a unit test?
> 
> This is never run in production.

People might use it as an example of how to use the stuff.. and then
copy horrendous crap code.
