Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F1818CD41
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 12:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCTLuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 07:50:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35428 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCTLuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:50:22 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFGAH-0002xt-1n; Fri, 20 Mar 2020 12:50:13 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 8A7CA100375; Fri, 20 Mar 2020 12:50:12 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Waiman Long <longman@redhat.com>
Cc:     Qian Cai <cai@lca.pw>,
        "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Hard lockups due to "tick/common: Make tick_periodic() check for missing ticks"
In-Reply-To: <20200320130017.6457a1e8@canb.auug.org.au>
References: <CA9BD318-A8C8-4F22-828A-65C355931A5C@lca.pw> <F95F95DE-77D9-4A1D-AA5C-CAC165F6B4C8@lca.pw> <11BEA1A5-2E93-4E01-A05C-A6BA73A74CEB@lca.pw> <218eed57-27c8-12c0-6f5f-111874798c21@redhat.com> <20200320130017.6457a1e8@canb.auug.org.au>
Date:   Fri, 20 Mar 2020 12:50:12 +0100
Message-ID: <87zhcb2qkr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
 Thu, 19 Mar 2020 15:00:35 -0400 Waiman Long <longman@redhat.com> wrote:
>> I am fine for reverting the patch for now. I am still having some
>> trouble reproducing it and I have other tasks to work on right now. I
>> will get to the bottom of it and resubmit a new patch later on.
>
> I have reverted that commit from linux-next today.

I did the same in the tip tree.
