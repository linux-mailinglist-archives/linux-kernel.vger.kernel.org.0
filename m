Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B8E87E30
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 17:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436724AbfHIPif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 11:38:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfHIPie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:38:34 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D83E208C4;
        Fri,  9 Aug 2019 15:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565365113;
        bh=6k2kbFbCAV2mbyYg9sNi3Qs1S2mO5xLD7rJ6o09Bb7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qXuCwhbI20W21UkVluLajhx1lzw63urn2mabKMZ/faXJ1w8idarPjedZsjVkQBGUA
         kYMqzm1h1yJH28OFM9M+KX7IvEi5NJJFI42Wv5O6sf2h5pFl4KMkqaY85I2gBBE8pq
         Xrnf+H018owd/dgfwcVlE/uPtfVxYRJdVsvS0kvE=
Date:   Fri, 9 Aug 2019 16:38:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH 5/6] lib/refcount: Improve performance of generic
 REFCOUNT_FULL code
Message-ID: <20190809153829.qehhxxfwlwitmv74@willie-the-truck>
References: <20190802101000.12958-1-will@kernel.org>
 <20190802101000.12958-6-will@kernel.org>
 <20190802185514.GE2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802185514.GE2349@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:55:14PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 02, 2019 at 11:09:59AM +0100, Will Deacon wrote:
> >  static inline void refcount_add(int i, refcount_t *r)
> >  {
> > +	int old = atomic_fetch_add_relaxed(i, &r->refs);
> > +
> > +	WARN_ONCE(!old, "refcount_t: addition on 0; use-after-free.\n");
> > +	if (unlikely(old <= 0 || old + i <= 0)) {
> > +		refcount_set(r, REFCOUNT_SATURATED);
> > +		WARN_ONCE(1, "refcount_t: saturated; leaking memory.\n");
> > +	}
> >  }
> 
> That will trigger both WARNs when !old.

Right you are. I'll make the second WARN_ONCE(old, ...);

Will
