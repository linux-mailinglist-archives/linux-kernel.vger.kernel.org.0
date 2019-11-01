Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4B7EC8C8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 19:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfKAS7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 14:59:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbfKAS7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:59:52 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 534F9217D9;
        Fri,  1 Nov 2019 18:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572634791;
        bh=lRVpk7cBWykOpWgnyK3qxsXb6qvYPBxlHllAXwYHWwk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l5otfoxV3jIeKhh3tTE18TRy+G1CxJ8fZccktuHdF17wreK35qAXHBY6D9TS+ayxd
         wCIN6UBhh6lF7CxYJlJISu/6ZA2hOdOL+bhdtvPkpfUcR1RbL52fzvwwI9+sbgra2s
         umulqdmc/Ty/5V6c1BIsmhXh4qqoIjArHsfzAihs=
Date:   Fri, 1 Nov 2019 11:59:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Down <chris@chrisdown.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] kernel: sysctl: make drop_caches write-only
Message-Id: <20191101115950.bb88d49849bfecb1af0a88bf@linux-foundation.org>
In-Reply-To: <20191101144540.GA12808@cmpxchg.org>
References: <20191031221602.9375-1-hannes@cmpxchg.org>
        <20191031162825.a545a5d4d8567368501769bd@linux-foundation.org>
        <20191101110901.GB690103@chrisdown.name>
        <20191101144540.GA12808@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2019 10:45:40 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Fri, Nov 01, 2019 at 11:09:01AM +0000, Chris Down wrote:
> > Hm, not sure why my client didn't show this reply.
> > 
> > Andrew Morton writes:
> > > Risk: some (odd) userspace code will break.  Fixable by manually chmodding
> > > it back again.
> > 
> > The only scenario I can construct in my head is that someone has built
> > something to watch drop_caches for modification, but we already have the
> > kmsg output for that.

The scenario is that something opens /proc/sys/vm/drop_caches for
reading, gets unexpected EPERM and blows up?

> > > Reward: very little.
> > > 
> > > Is the reward worth the risk?
> > 
> > There is evidence that this has already caused confusion[0] for many,
> > judging by the number of views and votes. I think the reward is higher than
> > stated here, since it makes the intent and lack of persistent API in the API
> > clearer, and less likely to cause confusion in future.
> > 
> > 0: https://unix.stackexchange.com/q/17936/10762
> 
> Yes, I should have mentioned this in the changelog, but:
> 
> While mitigating a VM problem at scale in our fleet, there was
> confusion about whether writing to this file will permanently switch
> the kernel into a non-caching mode. This influences the decision
> making in a tense situation, where tens of people are trying to fix
> tens of thousands of affected machines: Do we need a rollback
> strategy? What are the performance implications of operating in a
> non-caching state for several days? It also caused confusion when the
> kernel team said we may need to write the file several times to make
> sure it's effective ("But it already reads back 3?").

OK.  What if we make reads always return "0"?  That will fix the
misleading output and is more backwards-compatible?
