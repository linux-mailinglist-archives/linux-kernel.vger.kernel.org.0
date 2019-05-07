Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF6C16886
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfEGQ5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 12:57:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEGQ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=snh1OcxQPptELjRACBL9eThdDTnyjEo5jOd9EOTBBDw=; b=MzNdmyV+UjZCxR5OohOEpTT14
        a3hP/xXVSNJI94AM09BoQCMfDhpWanvAW6IYUfmicY/y/Tg3FcaZMolJXba5iNQ1Rx4bnJYHqnMh+
        dHiGUB2HpBMjl5Xeg4zQJxzkBCrac5cNZW05cYlC8rZFIe6dEvCHilcy+IhibnID3TTS1IeNxSmYH
        ws3p0c/IgRoH5VFEiZrpPycA/7VHgUtIjBGsFBBuG8oejg9hiAxOI4x/jZmXjedkik7A97XVldXXl
        LvMNLuXVTSnEu9vd8uEg7ZXqRGxPditeol9bCCWfARuYcutQaZtyu1cRwf+g4BiHxUAYtWOZ75jzm
        RPY6V+G+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hO3PU-0007Fu-R8; Tue, 07 May 2019 16:57:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57B4F21466241; Tue,  7 May 2019 18:57:43 +0200 (CEST)
Date:   Tue, 7 May 2019 18:57:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kairui Song <kasong@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH v4] perf/x86: make perf callchain work without
 CONFIG_FRAME_POINTER
Message-ID: <20190507165743.GX2606@hirez.programming.kicks-ass.net>
References: <20190422162652.15483-1-kasong@redhat.com>
 <20190423113501.GN11158@hirez.programming.kicks-ass.net>
 <CACPcB9f8JuALCw1i-V2N01GuTQRfjrCya6esOTM8dGwvf+oT7w@mail.gmail.com>
 <20190424125212.GN12232@hirez.programming.kicks-ass.net>
 <CAADnVQJLLCQJoV8Qg+0D4_-mE8hLmrEYz91Jy0kT2Qgkb1evtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJLLCQJoV8Qg+0D4_-mE8hLmrEYz91Jy0kT2Qgkb1evtQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 09:45:47AM -0700, Alexei Starovoitov wrote:
> On Wed, Apr 24, 2019 at 5:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Apr 24, 2019 at 08:42:40AM -0400, Kairui Song wrote:
> >
> > > Sure, the updated comments looks much better. Will the maintainer
> > > squash the comment update or should I send a V5?
> >
> > I've squashed it, I've just not gotten around to stuffing it a git tree
> > yet. Should happen 'soon'.
> 
> Was it applied and on the way to Linus yet ?

AFAICT it has already landed in Linus' tree.
