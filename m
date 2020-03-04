Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E7717877A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 02:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387581AbgCDBHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 20:07:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387406AbgCDBHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:07:43 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88EBA20661;
        Wed,  4 Mar 2020 01:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583284062;
        bh=he8hFXzurXLh5g7b8+qJIW+YvCJT2XaTX3aqrgZ9otI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=STQYplSzJyTCChQj2ANUycT53d42crYmY/ElGnM/G/Ye3T5bOU3sW2K9IJ+TpdDF2
         SbVZAFlYQ+khTWhBhZu+XTDqLGUmKUTq76DsZIfhGSZjIzYROBQXWa5BvYJAoiQLuD
         pwksw+lZWASlxhhcitbkI2ALgGbtP/tIQIOd/vtI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5544B35226C4; Tue,  3 Mar 2020 17:07:42 -0800 (PST)
Date:   Tue, 3 Mar 2020 17:07:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.03.03b 43/45] kernel/rcu/update.c:583:2: error:
 implicit declaration of function 'rcu_tasks_bootup_oddness'; did you mean
 'rcu_early_boot_tests'?
Message-ID: <20200304010742.GV2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202003040710.OtaUSqj6%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003040710.OtaUSqj6%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 07:59:13AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.03.03b
> head:   647c0bb2da5c14b25d27661fa93de7fca9042daf
> commit: d060bd985c4d160df31659a80cf5fabe1cd508b4 [43/45] rcu-tasks: Refactor RCU-tasks to allow variants to be added
> config: x86_64-defconfig (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
> reproduce:
>         git checkout d060bd985c4d160df31659a80cf5fabe1cd508b4
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/rcu/update.c: In function 'rcupdate_announce_bootup_oddness':
> >> kernel/rcu/update.c:583:2: error: implicit declaration of function 'rcu_tasks_bootup_oddness'; did you mean 'rcu_early_boot_tests'? [-Werror=implicit-function-declaration]
>      rcu_tasks_bootup_oddness();
>      ^~~~~~~~~~~~~~~~~~~~~~~~
>      rcu_early_boot_tests
>    cc1: some warnings being treated as errors

Good catch, will fix, thank you!

							Thanx, Paul

> vim +583 kernel/rcu/update.c
> 
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  567  
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  568  /*
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  569   * Print any significant non-default boot-time settings.
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  570   */
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  571  void __init rcupdate_announce_bootup_oddness(void)
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  572  {
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  573  	if (rcu_normal)
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  574  		pr_info("\tNo expedited grace period (rcu_normal).\n");
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  575  	else if (rcu_normal_after_boot)
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  576  		pr_info("\tNo expedited grace period (rcu_normal_after_boot).\n");
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  577  	else if (rcu_expedited)
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  578  		pr_info("\tAll grace periods are expedited (rcu_expedited).\n");
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  579  	if (rcu_cpu_stall_suppress)
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  580  		pr_info("\tRCU CPU stall warnings suppressed (rcu_cpu_stall_suppress).\n");
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  581  	if (rcu_cpu_stall_timeout != CONFIG_RCU_CPU_STALL_TIMEOUT)
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  582  		pr_info("\tRCU CPU stall warnings timeout set to %d (rcu_cpu_stall_timeout).\n", rcu_cpu_stall_timeout);
> 59d80fd8351b7b Paul E. McKenney 2017-04-28 @583  	rcu_tasks_bootup_oddness();
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  584  }
> 59d80fd8351b7b Paul E. McKenney 2017-04-28  585  
> 
> :::::: The code at line 583 was first introduced by commit
> :::::: 59d80fd8351b7b9a5dc7bbfa8bc4ca19f6ff3dad rcu: Print out rcupdate.c non-default boot-time settings
> 
> :::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> :::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


