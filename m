Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9FAD4B3C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 01:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfJKXzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 19:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfJKXzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 19:55:17 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C9AE20663;
        Fri, 11 Oct 2019 23:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570838116;
        bh=ax686pJ3fwHRXkYEzK6rzHdFbX01bbXaYBqGuLR8qoE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q130Eda4QY0u77zTziwgXggx4QQabTxsxD1bLStU6hTCH9RiuYcm4dKl4nIc3WKN2
         ZDmR6bi2g7yyzAvMxLIp/6K0wEwJc9eryUGVULED0vgVOWvujZA0ynEzuaCs2aBJnh
         hrIuoeLj3R53M5a20RgR+sax6KuifGzKzsTbgoTA=
Date:   Fri, 11 Oct 2019 16:55:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] mm/vmalloc: remove preempt_disable/enable when do
 preloading
Message-Id: <20191011165515.a25e7d1c22e6b5e3e6fb69da@linux-foundation.org>
In-Reply-To: <20191010151749.GA14740@pc636>
References: <20191009164934.10166-1-urezki@gmail.com>
        <20191009151901.1be5f7211db291e4bd2da8ca@linux-foundation.org>
        <20191009221725.0b83151e@oasis.local.home>
        <20191010151749.GA14740@pc636>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 17:17:49 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:

> > > : 	 * The preload is done in non-atomic context, thus it allows us
> > > : 	 * to use more permissive allocation masks to be more stable under
> > > : 	 * low memory condition and high memory pressure.
> > > : 	 *
> > > : 	 * Even if it fails we do not really care about that. Just proceed
> > > : 	 * as it is. "overflow" path will refill the cache we allocate from.
> > > : 	 */
> > > : 	if (!this_cpu_read(ne_fit_preload_node)) {
> > > 
> > > Readability nit: local `pva' should be defined here, rather than having
> > > function-wide scope.
> > > 
> > > : 		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
> > > 
> > > Why doesn't this honour gfp_mask?  If it's not a bug, please add
> > > comment explaining this.
> > > 
> But there is a comment, if understand you correctly:
> 
> <snip>
> * Even if it fails we do not really care about that. Just proceed
> * as it is. "overflow" path will refill the cache we allocate from.
> <snip>

My point is that the alloc_vmap_area() caller passed us a gfp_t but
this code ignores it, as does adjust_va_to_fit_type().  These *look*
like potential bugs.  If not, they should be commented so they don't
look like bugs any more ;)


