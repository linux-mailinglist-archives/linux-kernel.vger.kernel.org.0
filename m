Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC74D14CB46
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 14:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgA2NPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 08:15:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgA2NPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:15:25 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11B5520678;
        Wed, 29 Jan 2020 13:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580303724;
        bh=oUDmtxiN41VdcoNQ6eSO7UKsE16s05WPMjsBCDCEb+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZnnsUEW0A0w6MrbLPgKEx4obNfVoCWr0lIzKLoOtOtFb0MHecDoEgMGYrDV+A9z8
         l+d0Y91PCdTzDQ185BFTCZaIT1DheYHBiGfgyOEOH3AWZoRMqBwYc52t9TJRvXoIEM
         ZOqcs3zU1ZNbOB7TsbMIXjv9xG2WtwRGgcIwNfrk=
Date:   Wed, 29 Jan 2020 13:15:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] m68k,mm: Extend table allocator for multiple sizes
Message-ID: <20200129131520.GA31774@willie-the-truck>
References: <20200129103941.304769381@infradead.org>
 <20200129104345.491163937@infradead.org>
 <20200129121752.GB31582@willie-the-truck>
 <20200129124352.GP14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129124352.GP14879@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 01:43:52PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 29, 2020 at 12:17:53PM +0000, Will Deacon wrote:
> > On Wed, Jan 29, 2020 at 11:39:45AM +0100, Peter Zijlstra wrote:
> 
> > > +extern void *get_pointer_table(int type);
> > 
> > Could be prettier/obfuscated with an enum type?
> 
> Definitely, but then we get to bike-shed on names :-)

At least we don't need an emulator for *that*!

> enum m68k_table_type {
> 	TABLE_BIG = 0,
> 	TABLE_SMALL,
> };
> 
> Is not exactly _that_ much better, and while TABLE_PTE works,
> TABLE_PGD_PMD is a bit crap.

Some alternatives:

TABLE_PXD / TABLE_PTE
TABLE_BRANCH / TABLE_LEAF
TABLE_DIR / TABLE_PTE
TABLE_TI_AB / TABLE_TI_C

Will
