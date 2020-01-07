Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B87F1334ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 22:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgAGVcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 16:32:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:54884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgAGVcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:32:51 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A95206F0;
        Tue,  7 Jan 2020 21:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578432770;
        bh=NKq/ShjDukyYkHHXytvAGFQmdmj1FmVZVGP2CEl4g08=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TIWQtPwo83QIR4B+6NO13f0GHH3ZcvmB2Ii3csb3mV4s4/7tujZLSKEJ0eToItHlC
         7D3oduy2WB67GgcjgEMmL2JxixGSrhMPhTaz8pqmOnzC3t/nZG1A7TtuXwb8OXgd/1
         ZRxJw4Ps7/7CLxxFmV1jgrcRQi8c/nQI6QRjSrEI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B86473522735; Tue,  7 Jan 2020 13:32:50 -0800 (PST)
Date:   Tue, 7 Jan 2020 13:32:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     corbet@lwn.net, madhuparnabhowmik04@gmail.com, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v3 0/7] Fix trivial nits in RCU docs
Message-ID: <20200107213250.GE13449@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200106200802.26994-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106200802.26994-1-sj38.park@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 09:07:55PM +0100, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> This patchset fixes trivial nits in the RCU documentations.
> 
> It is based on the latest dev branch of Paul's linux-rcu git repository.
> The Complete git tree is also available at
> https://github.com/sjp38/linux/tree/patches/rcu/docs/2019-12-31/v3.

I have queued these for further review and testing, thank you!

							Thanx, Paul

> Changes from v2
> (https://lore.kernel.org/linux-doc/20200106191852.22973-1-sjpark@amazon.de/)
>  - Apply author email (sjpark@amazon.de) correctly
> 
> Changes from v1
> (https://lore.kernel.org/linux-doc/20191231151549.12797-1-sjpark@amazon.de/)
>  - Add 'Reviewed-by' from Madhuparna
>  - Fix wrong author email address
>  - Rebased on latest dev branch of Paul's linux-rcu git repository.
> 
> SeongJae Park (7):
>   doc/RCU/Design: Remove remaining HTML tags in ReST files
>   doc/RCU/listRCU: Fix typos in a example code snippets
>   doc/RCU/listRCU: Update example function name
>   doc/RCU/rcu: Use ':ref:' for links to other docs
>   doc/RCU/rcu: Use absolute paths for non-rst files
>   doc/RCU/rcu: Use https instead of http if possible
>   rcu: Fix typos in beginning comments
> 
>  .../Tree-RCU-Memory-Ordering.rst               |  8 ++++----
>  Documentation/RCU/listRCU.rst                  | 10 +++++-----
>  Documentation/RCU/rcu.rst                      | 18 +++++++++---------
>  kernel/rcu/srcutree.c                          |  2 +-
>  kernel/rcu/tree.c                              |  4 ++--
>  5 files changed, 21 insertions(+), 21 deletions(-)
> 
> -- 
> 2.17.1
> 
