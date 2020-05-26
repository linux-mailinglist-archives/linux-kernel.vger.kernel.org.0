Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F049719BEFB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 11:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbgDBJ6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 05:58:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36819 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgDBJ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:58:18 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jJwc0-00014Q-Gu; Thu, 02 Apr 2020 11:58:12 +0200
Date:   Thu, 2 Apr 2020 11:58:12 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        LKP <lkp@lists.01.org>
Subject: Re: de8f5e4f2d ("lockdep: Introduce wait-type checks"): [ 17.344674]
 EIP: default_idle
Message-ID: <20200402095812.2t2rgx72n3xy35k2@linutronix.de>
References: <20200402081732.GM8179@shao2-debian>
 <87h7y2ns2j.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h7y2ns2j.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-02 11:40:52 [+0200], Thomas Gleixner wrote:
> kernel test robot <lkp@intel.com> writes:
> > Greetings,
> >
> > 0day kernel testing robot got the below dmesg and the first bad commit is
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >
> > commit de8f5e4f2dc1f032b46afda0a78cab5456974f89
> > Author:     Peter Zijlstra <peterz@infradead.org>
> > AuthorDate: Sat Mar 21 12:26:01 2020 +0100
> > Commit:     Peter Zijlstra <peterz@infradead.org>
> > CommitDate: Sat Mar 21 16:00:24 2020 +0100
> >
> >     lockdep: Introduce wait-type checks
> 
> Can you please avoid enabling
> 
> > CONFIG_PROVE_RAW_LOCK_NESTING=y
> 
> for now?
> 
> As the changelog states, there are known issues and that's why the
> config is default=n.

There is that. What puzzled me for a little while was the part that the
call chain itself is *valid* and should not trigger this. After staring
at it for a while I noticed that the test was performed *before* the
hrtimer bits were merged.

> Thanks,
> 
>         tglx

Sebastian
