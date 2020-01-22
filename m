Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E11A914493C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 02:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAVBQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 20:16:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgAVBQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:16:19 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30DE924656;
        Wed, 22 Jan 2020 01:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579655779;
        bh=+mgh5vdBGfPdilfxyRAlgyY+0LtJYno8wnF6S4RUnwA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QWe/PI1T8+7bio5RX7eyRHSKdOfwKaEFSH81DUHSLZeDn4hFf0NeQvqVxu6fY8dYh
         6QhSUjtC+oSgssRxzpxNCyD4Z23m8mh3DHUs4Gb7MyVQCJ21uXD6gcc2rdH+yQIGn6
         ObcqAZPNz2oEZh+pSw/cKpZ0HIMN2ZoPbJiTfvLc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EC3B83520DC0; Tue, 21 Jan 2020 17:16:18 -0800 (PST)
Date:   Tue, 21 Jan 2020 17:16:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [v2 PATCH 0/2] enhance kfree_rcu() throughput
Message-ID: <20200122011618.GB2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200120144226.27538-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120144226.27538-1-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 03:42:24PM +0100, Uladzislau Rezki (Sony) wrote:
> Here we go with V2 version of the "support kfree_bulk() interface in
> kfree_rcu()" patchest. Apart of that there is one more, it just adds
> a trace event for kfree_bulk() call.
> 
> Boths patches are based on "dev.2020.01.10a" branch of the linux-rcu.git
> 
> V1 -> V2:
>    - fix and support debugobjects;
>    - updated the commit message of [1]. Added test results
>      of CONFIG_SLAB / CONFIG_SLUB configurations together
>      with recent new parameter kfree_vary_obj_size=1;
>    - add more comments.
> 
> Rezki (Sony) (2):
> [1]  rcu/tree: support kfree_bulk() interface in kfree_rcu()
> [2]  rcu/tree: add a trace invoke event of the kfree_bulk()
> 
>  include/trace/events/rcu.h |  28 +++++
>  kernel/rcu/tree.c          | 207 ++++++++++++++++++++++++++++++-------
>  2 files changed, 200 insertions(+), 35 deletions(-)

Both queued for further review and testing, thank you!

							Thanx, Paul
