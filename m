Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 944CFDB90B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 23:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441531AbfJQVaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 17:30:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732322AbfJQVaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 17:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ddG8SSBXeHtQJjnOT9zp0H8FqPeFjXG/6++DCHq7Y3U=; b=JJ5+RO1nbc5RPXZO0h8IMN4RJ
        e92r1vlygPa33RKRyNJyhKhytJAub1NRP3EaTujMAZl7OvCs1I3acpPRcZeLqDKm3P8+A31HJ1dRv
        qqz4YGTTjlrDrWU+OpL0DdUbusmT3CUTm1ecX+92yCADv+YPQ+ZZ9sDxIHcTupHFxdfD2754ibbmi
        //0P8Is0nHvoBtpa187gKKefIpwRsd3FDDDKW6Pe7H9LUHkEHAwSUZ0Y+kUuzHhTME+Z1mC2KnFTi
        380ntvNi2DXS3/iaUZ4VfkfZj1wBtXQWyPb3NllLt1x64Of0/ebu550yrNnzx9GwyfsnmFF/OxG6Y
        3kRyO+msg==;
Received: from [177.158.182.196] (helo=sandy.ghostprotocols.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLDLO-00028t-6U; Thu, 17 Oct 2019 21:30:02 +0000
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id EE3DA11E4; Thu, 17 Oct 2019 18:29:52 -0300 (BRT)
Date:   Thu, 17 Oct 2019 18:29:52 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/2] perf: Iterate on tep event arrays directly
Message-ID: <20191017212952.GA3884@redhat.com>
References: <20191017210521.465613686@goodmis.org>
 <20191017210636.061448713@goodmis.org>
 <20191017212431.GF3600@kernel.org>
 <20191017172823.15f242eb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017172823.15f242eb@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 17, 2019 at 05:28:23PM -0400, Steven Rostedt escreveu:
> On Thu, 17 Oct 2019 18:24:31 -0300
> Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> 
> > I'll add a:
> > 
> > Fixes: bb3dd7e7c4d5 ("tools lib traceevent, perf tools: Move struct tep_handler definition in a local header file")
> > Cc: stable@vger.kernel.org : v4.20+
> > 
> > As this is when this problem starts causing the segfault when generating
> > python scripts from perf.data files with multiple tracepoint events, ok?
> 
> Sure, go ahead. I realized I forgot to add a Fixes tag when sending it.

np, I added it, thanks for the prompt fix!

- Arnaldo
