Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7250018914B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 23:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgCQWZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 18:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgCQWZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:25:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9C9E206EC;
        Tue, 17 Mar 2020 22:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584483945;
        bh=OiHevbk3bmBxyxPbqaJ83O8jsVIPqM8xvnuAVwvdE0E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sfxDGEi/saW9CAJBqjckkf66Ev9DcSMKx1jXZo5bMrVUrVHjecGE4Qi46t2NDpcud
         jX+x5X5GBcAPBD7CvzLJIWeciX0QsOaxqgL20araA/SEoiJ7bNncVMFQHcylTME6wX
         7Qa9iPPvZ0CvQKneEEDwaGrKWJmTpeEN9XpBpMoU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7B4AC352272E; Tue, 17 Mar 2020 15:25:45 -0700 (PDT)
Date:   Tue, 17 Mar 2020 15:25:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.03.16a 60/68] kernel/rcu/tasks.h:1000:37: error:
 'rcu_tasks_rude' undeclared; did you mean 'rcu_tasks_qs'?
Message-ID: <20200317222545.GO3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202003180521.jou9H4n6%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003180521.jou9H4n6%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 05:28:25AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.03.16a
> head:   ad7a7c12b09555e7c488ee3be512d549cd78a2c0
> commit: 277258c315b7c732948e47718de02c6908d1745e [60/68] rcu-tasks: Add RCU tasks to rcutorture writer stall output
> config: arc-defconfig (attached as .config)
> compiler: arc-elf-gcc (GCC) 9.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 277258c315b7c732948e47718de02c6908d1745e
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.2.0 make.cross ARCH=arc 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/update.c:562:
>    kernel/rcu/tasks.h: In function 'show_rcu_tasks_gp_kthreads':
> >> kernel/rcu/tasks.h:1000:37: error: 'rcu_tasks_rude' undeclared (first use in this function); did you mean 'rcu_tasks_qs'?
>     1000 |  show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
>          |                                     ^~~~~~~~~~~~~~
>          |                                     rcu_tasks_qs
>    kernel/rcu/tasks.h:1000:37: note: each undeclared identifier is reported only once for each function it appears in

Good catch!  Will fix!!!

							Thanx, Paul

> vim +1000 kernel/rcu/tasks.h
> 
>    996	
>    997	void show_rcu_tasks_gp_kthreads(void)
>    998	{
>    999		show_rcu_tasks_generic_gp_kthread(&rcu_tasks, "");
> > 1000		show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
>   1001		show_rcu_tasks_trace_gp_kthread();
>   1002	}
>   1003	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


