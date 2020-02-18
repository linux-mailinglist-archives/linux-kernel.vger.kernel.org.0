Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85685162752
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 14:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBRNo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 08:44:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgBRNo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:44:58 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 975F32173E;
        Tue, 18 Feb 2020 13:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582033497;
        bh=Rbxck2G9nSUDEYE6925sca3MuMnhJXXRiHTueyZHji0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hYKsnDNOnpOz8gQhIqUYMMx5iHGzNkQTwte6r8XsdU/XoJS5OcvftFTgJg5/9peb1
         uDM9gNqFQ8PMaRHxiwxnyZ71xPlcS9haHeX1M5nOeJOxDPlK6DfZ0B8wvwxbwEwQoe
         kpVrYWR0xR+j8zNpthr6WnfVxZEiB4Dc9ojKkyQ4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4165235226EF; Tue, 18 Feb 2020 05:44:57 -0800 (PST)
Date:   Tue, 18 Feb 2020 05:44:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.02.15b 33/33] kernel/rcu/tree_plugin.h:396:2:
 error: expected identifier or '(' before 'if'
Message-ID: <20200218134457.GC2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202002181731.hrgvGnlt%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202002181731.hrgvGnlt%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:06:32PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.02.15b
> head:   163cebf16e83ee2e6494976e396ab1a8f8aa9b17
> commit: 163cebf16e83ee2e6494976e396ab1a8f8aa9b17 [33/33] rcu: Don't use negative nesting depth in __rcu_read_unlock()
> config: nds32-defconfig (attached as .config)
> compiler: nds32le-linux-gcc (GCC) 9.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 163cebf16e83ee2e6494976e396ab1a8f8aa9b17
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.2.0 make.cross ARCH=nds32 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/tree.c:4030:
> >> kernel/rcu/tree_plugin.h:396:2: error: expected identifier or '(' before 'if'
>      396 |  if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
>          |  ^~
> >> kernel/rcu/tree_plugin.h:401:1: error: expected identifier or '(' before '}' token
>      401 | }
>          | ^

This has since been fixed by a new version 756b5aea6df6 ("rcu: Don't use
negative nesting depth in __rcu_read_unlock()") in -rcu.

							Thanx, Paul

> vim +396 kernel/rcu/tree_plugin.h
> 
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  379  
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  380  /*
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  381   * Preemptible RCU implementation for rcu_read_unlock().
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  382   * Decrement ->rcu_read_lock_nesting.  If the result is zero (outermost
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  383   * rcu_read_unlock()) and ->rcu_read_unlock_special is non-zero, then
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  384   * invoke rcu_read_unlock_special() to clean up after a context switch
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  385   * in an RCU read-side critical section and other special cases.
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  386   */
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  387  void __rcu_read_unlock(void)
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  388  {
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  389  	struct task_struct *t = current;
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  390  
> 163cebf16e83ee Lai Jiangshan    2020-02-15  391  	if (rcu_preempt_read_exit() == 0)
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  392  		barrier();  /* critical section before exit code. */
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  393  		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  394  			rcu_read_unlock_special(t);
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  395  	}
> 5f1a6ef3746f53 Paul E. McKenney 2018-10-29 @396  	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
> 77339e61aa3093 Lai Jiangshan    2019-11-15  397  		int rrln = rcu_preempt_depth();
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  398  
> 5f1a6ef3746f53 Paul E. McKenney 2018-10-29  399  		WARN_ON_ONCE(rrln < 0 && rrln > RCU_NEST_NMAX);
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  400  	}
> 0e5da22e3f809a Paul E. McKenney 2018-03-19 @401  }
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  402  EXPORT_SYMBOL_GPL(__rcu_read_unlock);
> 0e5da22e3f809a Paul E. McKenney 2018-03-19  403  
> 
> :::::: The code at line 396 was first introduced by commit
> :::::: 5f1a6ef3746f536157922197d98676fa21154549 rcu: Avoid signed integer overflow in rcu_preempt_deferred_qs()
> 
> :::::: TO: Paul E. McKenney <paulmck@linux.ibm.com>
> :::::: CC: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


