Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2EA470888
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 20:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfGVS1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 14:27:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbfGVS1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HtnFaD4ytCU2gpckrHCrFiV3N+IzFvsSC/qjM6SxoRE=; b=sdfEIxROl3n1rR6nyDkj6v11Q
        MzHEL6IiERaMiMekhTX8vPOmN/FkkM85MwlF9S+bfomurdZ/3juboz2OPU/vdBOWXD9DyfCHp3D0q
        7InwdH0qfAfVkevEnPtMeZWZ6Im742vN2eJU0D18IQy6yR600JMjkqb/+DVKhNMk3yt0bhm39VoFB
        oRyU+9GnjcpqVTxPqn4TTbRw2h0rqBGg8Un0+GEMDqwNwm7Cwlqzez1xMOi37TvQ1L9lKXkHVJoC2
        4Ty7s8AOXJDOewpoJg2zzageno0lupeqS2Y/XmYovSHMtfvjLnu9CJOol7Fcoeq8MyKXj4P1heIuE
        erXvaov1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpd29-0001UL-9M; Mon, 22 Jul 2019 18:27:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 349C6980D22; Mon, 22 Jul 2019 20:27:35 +0200 (CEST)
Date:   Mon, 22 Jul 2019 20:27:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 3/9] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
 tlb_is_not_lazy()
Message-ID: <20190722182735.GC6698@worktop.programming.kicks-ass.net>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-4-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719005837.4150-4-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 05:58:31PM -0700, Nadav Amit wrote:
> +static DEFINE_PER_CPU(cpumask_t, flush_tlb_mask);

I'm thinking it should be possible to allocate this before we switch to
SMP, no? cpumask_t really should not be used wherever possible.

