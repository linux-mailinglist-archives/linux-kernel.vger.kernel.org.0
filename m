Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C44781318E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 20:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgAFTwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 14:52:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgAFTwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:52:43 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47B772072E;
        Mon,  6 Jan 2020 19:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578340362;
        bh=P7RifdT06T772dwOoK4koYvLm7Pt0vr8o0AB6bu6BMA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=2VyobgkjORYH/J07rphHQ7iVAi5isqI+7hQvd6wJnHIRMkI8tJvk9wqHZePhDfsaO
         PYkXbsD95dSU1i+7ukULvWHyo4R9h3RDbDLiZ1ihYv7ExsBB/GyYk2gIK4acX+VqYM
         BpLmj5V6cH4bhtNUVlmmFSIhPWcIg0EQEBDHAeJA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 249A3352274D; Mon,  6 Jan 2020 11:52:42 -0800 (PST)
Date:   Mon, 6 Jan 2020 11:52:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, madhuparnabhowmik04@gmail.com,
        rcu@vger.kernel.org, sjpark@amazon.de
Subject: Re: [PATCH v2 0/7] Fix trivial nits in RCU docs
Message-ID: <20200106195242.GT13449@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200106191852.22973-1-sjpark@amazon.de>
 <20200106194330.24687-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106194330.24687-1-sj38.park@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 08:43:30PM +0100, SeongJae Park wrote:
> Author email (sjpark@amazon.de) is not applied to this patch set mails...
> Maybe my git send-email setting is somewhere broken.  Sorry, I will correct
> this and send v3 soon.

Given my recent change in email address, I can certainly sympathize!  ;-)

							Thanx, Paul

> Thanks,
> SeongJae Park
> 
> On   Mon,  6 Jan 2020 20:18:45 +0100   SeongJae Park <sj38.park@gmail.com> wrote:
> 
> > This patchset fixes trivial nits in the RCU documentations.
> > 
> > It is based on the latest dev branch of Paul's linux-rcu git repository.
> > The Complete git tree is also available at
> > https://github.com/sjp38/linux/tree/patches/rcu/docs/2019-12-31/v2.
> > 
> > Changes from v1
> > (https://lore.kernel.org/linux-doc/20191231151549.12797-1-sjpark@amazon.de/)
> > 
> >  - Add 'Reviewed-by' from Madhuparna
> >  - Fix wrong author email address
> >  - Rebased on latest dev branch of Paul's linux-rcu git repository.
> > 
> > SeongJae Park (7):
> >   doc/RCU/Design: Remove remaining HTML tags in ReST files
> >   doc/RCU/listRCU: Fix typos in a example code snippets
> >   doc/RCU/listRCU: Update example function name
> >   doc/RCU/rcu: Use ':ref:' for links to other docs
> >   doc/RCU/rcu: Use absolute paths for non-rst files
> >   doc/RCU/rcu: Use https instead of http if possible
> >   rcu: Fix typos in beginning comments
> > 
> >  .../Tree-RCU-Memory-Ordering.rst               |  8 ++++----
> >  Documentation/RCU/listRCU.rst                  | 10 +++++-----
> >  Documentation/RCU/rcu.rst                      | 18 +++++++++---------
> >  kernel/rcu/srcutree.c                          |  2 +-
> >  kernel/rcu/tree.c                              |  4 ++--
> >  5 files changed, 21 insertions(+), 21 deletions(-)
> > 
> > -- 
> > 2.17.1
> > 
