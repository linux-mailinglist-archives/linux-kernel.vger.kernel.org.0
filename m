Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3B315B2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 22:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgBLVkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 16:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727564AbgBLVkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:40:32 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1512173E;
        Wed, 12 Feb 2020 21:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581543631;
        bh=OwCUlnLwm+aIcdgk3vyMZM72dWcOtOjU+VOccXeTPys=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ti//QRKWgnGi2NYAPYGCTtElDhNlofhgZFbA5ciWvj1UFYlm+hD0f71IkqjFEaWc5
         YfkGlVtnpX0K7v8NjSanUgcTf0ifx9J8agw5q/Vg8IT1pEGZKC7wfo9JKyYZERP9wn
         5n/5LCLSr+7KTqUoSvInmukJbGbstD5gAioEo90g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F19FD3522725; Wed, 12 Feb 2020 13:40:29 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:40:29 -0800
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
Message-ID: <20200212214029.GS2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CANpmjNOWzWB2GgJiZx7c96qoy-e+BDFUx9zYr+1hZS1SUS7LBQ@mail.gmail.com>
 <ED2B665D-CF42-45BD-B476-523E3549F127@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED2B665D-CF42-45BD-B476-523E3549F127@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 07:30:16AM -0500, Qian Cai wrote:
> 
> 
> > On Feb 12, 2020, at 5:57 AM, Marco Elver <elver@google.com> wrote:
> > 
> > KCSAN is currently in -rcu (kcsan branch has the latest version),
> > -tip, and -next.
> 
> It would like be nice to at least have this patchset can be applied against the linux-next, so I can try it a spin.
> 
> Maybe a better question to Paul if he could push all the latest kcsan code base to linux-next soon since we are now past the merging window. I also noticed some data races in rcu but only found out some of them had already been fixed in rcu tree but not in linux-next.

I have pushed all that I have queued other than the last set of five,
which I will do tomorrow (Prague time) if testing goes well.

Could you please check the -rcu "dev" branch to see if I am missing any
of the KCSAN patches?

							Thanx, Paul
