Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707867D454
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 06:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfHAEU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 00:20:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54578 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHAEU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 00:20:58 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3B9324379;
        Thu,  1 Aug 2019 04:20:56 +0000 (UTC)
Date:   Wed, 31 Jul 2019 21:20:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] fork: Improve error message for corrupted page tables
Message-Id: <20190731212052.5c262ad084cbd6cf475df005@linux-foundation.org>
In-Reply-To: <a05920e5994fb74af480255471a6c3f090f29b27.camel@intel.com>
References: <20190730221820.7738-1-sai.praneeth.prakhya@intel.com>
        <20190731152753.b17d9c4418f4bf6815a27ad8@linux-foundation.org>
        <a05920e5994fb74af480255471a6c3f090f29b27.camel@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 15:36:49 -0700 Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com> wrote:

> > > +static const char * const resident_page_types[NR_MM_COUNTERS] = {
> > > +	"MM_FILEPAGES",
> > > +	"MM_ANONPAGES",
> > > +	"MM_SWAPENTS",
> > > +	"MM_SHMEMPAGES",
> > > +};
> > 
> > But please let's not put this in a header file.  We're asking the
> > compiler to put a copy of all of this into every compilation unit which
> > includes the header.  Presumably the compiler is smart enough not to
> > do that, but it's not good practice.
> 
> Thanks for the explanation. Makes sense to me.
> 
> Just wanted to check before sending V2,
> Is it OK if I add this to kernel/fork.c? or do you have something else in
> mind?

I was thinking somewhere like mm/util.c so the array could be used by
other code.  But it seems there is no such code.  Perhaps it's best to
just leave fork.c as it is now.


