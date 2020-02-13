Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF94015B99D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 07:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgBMGf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 01:35:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgBMGf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 01:35:28 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 633B62168B;
        Thu, 13 Feb 2020 06:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581575727;
        bh=DdnL9T+dTXoFqpo5mEY7DLQHxSCueJEL/N1xu1Dl1RI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PSexIC8tJOyZVNJxmuaN9WJ1LsVduTsGD7P9lF7NJDLD652MxPLW23AmcaLki5OAs
         34Rbz94dj57Kr9LqBukAKgPr5nE0/cLJ2oeY5JYR5zfLxQSY+9k/ej2x1A6TSbJYaz
         YAw03vzFHUKBMjMEeWIanUZNclsIZwFKAh/3YyNg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 834B43520CBE; Wed, 12 Feb 2020 22:35:25 -0800 (PST)
Date:   Wed, 12 Feb 2020 22:35:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Marco Elver <elver@google.com>, John Hubbard <jhubbard@nvidia.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 5/5] kcsan: Introduce ASSERT_EXCLUSIVE_BITS(var, mask)
Message-ID: <20200213063525.GU2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CANpmjNOWzWB2GgJiZx7c96qoy-e+BDFUx9zYr+1hZS1SUS7LBQ@mail.gmail.com>
 <ED2B665D-CF42-45BD-B476-523E3549F127@lca.pw>
 <20200212214029.GS2935@paulmck-ThinkPad-P72>
 <79934F2A-E151-480F-B1B1-1C713F932CEC@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79934F2A-E151-480F-B1B1-1C713F932CEC@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 07:48:15PM -0500, Qian Cai wrote:
> 
> 
> > On Feb 12, 2020, at 4:40 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > On Wed, Feb 12, 2020 at 07:30:16AM -0500, Qian Cai wrote:
> >> 
> >> 
> >>> On Feb 12, 2020, at 5:57 AM, Marco Elver <elver@google.com> wrote:
> >>> 
> >>> KCSAN is currently in -rcu (kcsan branch has the latest version),
> >>> -tip, and -next.
> >> 
> >> It would like be nice to at least have this patchset can be applied against the linux-next, so I can try it a spin.
> >> 
> >> Maybe a better question to Paul if he could push all the latest kcsan code base to linux-next soon since we are now past the merging window. I also noticed some data races in rcu but only found out some of them had already been fixed in rcu tree but not in linux-next.
> > 
> > I have pushed all that I have queued other than the last set of five,
> > which I will do tomorrow (Prague time) if testing goes well.
> > 
> > Could you please check the -rcu "dev" branch to see if I am missing any
> > of the KCSAN patches?
> 
> Nope. It looks good to me.

Thank you for checking!

							Thanx, Paul
