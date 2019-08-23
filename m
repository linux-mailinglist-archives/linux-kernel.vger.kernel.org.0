Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A359B485
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 18:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436748AbfHWQcf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Aug 2019 12:32:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36275 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfHWQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:32:35 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i1CUK-00061b-MW; Fri, 23 Aug 2019 18:32:32 +0200
Date:   Fri, 23 Aug 2019 18:32:32 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 3/3] rcu: Disable use_softirq on PREEMPT_RT
Message-ID: <20190823163232.zvs3gdcf2sxffbg5@linutronix.de>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-4-swood@redhat.com>
 <20190821234018.GW28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190821234018.GW28441@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-21 16:40:18 [-0700], Paul E. McKenney wrote:
> Save a couple of lines?
> 
> static bool use_softirq = !IS_ENABLED(CONFIG_PREEMPT_RT_FULL);
> 
> And if I understand your point above, the module_param() might be
> able to be the same either way given the new RCU.  But if not,
> at least we get rid of the #else.

I *think* we wanted this. And while I took the RCU patches for v5.2 I
forgot to enable it by default…

> 							Thanx, Paul

Sebastian
