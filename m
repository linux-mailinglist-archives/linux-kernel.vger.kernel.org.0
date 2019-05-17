Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CFC21605
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 11:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfEQJKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 05:10:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfEQJKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 05:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CJyIw/+rjKasvY8yMkFNMy6qA00M4WMYrpzsHPZXP0o=; b=SKmI1NEQDf0K6UeUHIvTwBCD6
        0gNAHx3VCb4KiNi5xS4/Dd8NPHqgyaRxLzvW5SPXElZG0Te2fn9jiDuupxq5/jvAMS39JHcKgYy0z
        S5A1gZxlM6I9ubC+SGpLHy3c4Ck2l0xz+wCjlOcaskWUYvO5PhQWjpg34ce1XniaPJYllL21aXNXK
        n7WdXv2NYxJB2xbOqnGL0rIHH7lBw2I/oNa3H62OER5aTjCX/3egb5+/k4cftAnlYwvMpgsBcZIzs
        mHQ1V8RoyaO4tfV3wshfJmzjjmc5AeWkXeGDqKeBMSnzDlkpjx0qqNPdm2TTyopKZNEfS5wg8ZV9O
        QIls9CoWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRYt4-00034I-2W; Fri, 17 May 2019 09:10:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A82E2029B0A3; Fri, 17 May 2019 11:10:44 +0200 (CEST)
Date:   Fri, 17 May 2019 11:10:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kairui Song <kasong@redhat.com>
Cc:     Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190517091044.GM2606@hirez.programming.kicks-ass.net>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
 <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 04:15:39PM +0800, Kairui Song wrote:
> Hi, I think the actual problem is that bpf_get_stackid_tp (and maybe
> some other bfp functions) is now broken, or, strating an unwind
> directly inside a bpf program will end up strangely. It have following
> kernel message:

Urgh, what is that bpf_get_stackid_tp() doing to get the regs? I can't
follow.
