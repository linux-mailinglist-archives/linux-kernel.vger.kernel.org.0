Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC9A1355DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 10:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgAIJeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 04:34:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729655AbgAIJeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:34:03 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71387206ED;
        Thu,  9 Jan 2020 09:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578562442;
        bh=uaoMrFIyM80NOLNvypeG45DSvOtIQFbrcttOC5k49b0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F4qYsR7By5pv4AcdPT4SP4wtxlPiIIgKCOQZ4Vihkf2fTNdJPGZlp9Z2R6yXxlXPE
         6C/YJH+Ee7yJbg5WOKtwlngPNLhqcKNfwRKHl+vlHXRKNFCqr6qoqIbdB+1hYDRsOj
         9y+gzw3STzc3T4ZzzPzo6myJkALnYwKBWJH0vSw8=
Date:   Thu, 9 Jan 2020 18:33:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= 
        <thoiland@redhat.com>, Jean-Tsung Hsiao <jhsiao@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] list corruption while enabling multi call uprobes via
 perf
Message-Id: <20200109183356.5a81ad2bfed6804f9934faee@kernel.org>
In-Reply-To: <20200109111056.484a181fc6acc20196344f9a@kernel.org>
References: <20200108171611.GA8472@kernel.org>
        <20200109111056.484a181fc6acc20196344f9a@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 9 Jan 2020 11:10:56 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hmm, this seems that the event->hw.tp_list is not initialized when removing
> from the list in uprobe_perf_close().

Oops, that's wrong. Of course my patch can ease (avoid kernel panic) the
issue, but not fixing the root cause.
The root cause is that the uprobe event tries to open multiple probes with
one perf_event. So the perf_event is reused on different probes.

In the reported case, if we remove the multiple probe event before perf-stat,
no problem happens.

I'll try to fix it.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
