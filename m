Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E31619BECA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 11:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387800AbgDBJlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 05:41:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36786 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgDBJlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:41:02 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJwLF-0000q4-JB; Thu, 02 Apr 2020 11:40:53 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id CDF1C100D52; Thu,  2 Apr 2020 11:40:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        LKP <lkp@lists.01.org>
Subject: Re: de8f5e4f2d ("lockdep: Introduce wait-type checks"): [   17.344674] EIP: default_idle
In-Reply-To: <20200402081732.GM8179@shao2-debian>
References: <20200402081732.GM8179@shao2-debian>
Date:   Thu, 02 Apr 2020 11:40:52 +0200
Message-ID: <87h7y2ns2j.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:
> Greetings,
>
> 0day kernel testing robot got the below dmesg and the first bad commit is
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>
> commit de8f5e4f2dc1f032b46afda0a78cab5456974f89
> Author:     Peter Zijlstra <peterz@infradead.org>
> AuthorDate: Sat Mar 21 12:26:01 2020 +0100
> Commit:     Peter Zijlstra <peterz@infradead.org>
> CommitDate: Sat Mar 21 16:00:24 2020 +0100
>
>     lockdep: Introduce wait-type checks

Can you please avoid enabling

> CONFIG_PROVE_RAW_LOCK_NESTING=y

for now?

As the changelog states, there are known issues and that's why the
config is default=n.

Thanks,

        tglx
