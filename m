Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 725ADE1D11
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 15:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406036AbfJWNoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 09:44:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390619AbfJWNox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GV+IWvK6woYMh5jAJHD1QoWsqFxxrlXfLLQLGUWXrqU=; b=rUFwOzl+ocYCUMxVFUzEs8uUx
        bpD2LZREbaPzw+NeeqD0I5lPGssTQtsqF6h5l3c5HDWpbr1/q0FoDUSFDGAmbG/oULIwzFo225NcN
        zylpP2YN+KQHWHgPIoeAJRe4A7qfaE8Oi/eWZ22wxTMoWI9LhmFrcaNx9JQ416jUKtpMd8oXY6PMs
        TVAj1Szq0rzEoKQhMERkjrD3Uyxe0Y8v8qXnahdQTgLSKxO0Sm/1sFra2wgIQftUhkzUGwZqhht/B
        Vb2ktT2YuwMO4h2u1yEt314VifZRu0Xht5fTKMGuJNeiU0S80hwqiLGLgT7CXVF9NS+9EHpOmQGHv
        EcfeIgeaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNGwR-0002DK-Ix; Wed, 23 Oct 2019 13:44:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1CF8300C3C;
        Wed, 23 Oct 2019 15:43:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDD2E265394A0; Wed, 23 Oct 2019 15:44:44 +0200 (CEST)
Date:   Wed, 23 Oct 2019 15:44:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        andi@firstfloor.org, kan.liang@linux.intel.com
Subject: Re: [PATCH 1/3] perf: Optimize perf_install_in_event()
Message-ID: <20191023134444.GV1817@hirez.programming.kicks-ass.net>
References: <20191022092017.740591163@infradead.org>
 <20191022092307.368892814@infradead.org>
 <874kzz4pb0.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kzz4pb0.fsf@ashishki-desk.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 03:30:27PM +0300, Alexander Shishkin wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > +	/*
> > +	 * perf_event_attr::disabled events will not run and can be initialized
> > +	 * without IPI. Except when this is the first event for the context, in
> > +	 * that case we need the magic of the IPI to set ctx->is_active.
> > +	 *
> > +	 * The IOC_ENABLE that is sure to follow the creation of a disabled
> > +	 * event will issue the IPI and reprogram the hardware.
> > +	 */
> > +	if (__perf_effective_state(event) == PERF_EVENT_STATE_OFF && ctx->nr_events) {
> > +		raw_spin_lock_irq(&ctx->lock);
> > +		if (task && ctx->task == TASK_TOMBSTONE) {
> 
> Confused: isn't that redundant? If ctx->task reads TASK_TOMBSTONE, task
> is always !NULL,

The test is only relevant for task contexts, that's what the first
'task' clause tests for, then we need to check the ctx isn't dying,
which is the second clause 'ctx->task == TASK_TOMBSTONE'.

> afaict. And in any case, if a task context is going
> away, we shouldn't probably be adding events there. Or am I missing
> something?

Right, so in that case we exit early.
