Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5FF1122A93
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 12:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfLQLsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 06:48:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55096 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLQLsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:48:40 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ihBLB-00086U-8c; Tue, 17 Dec 2019 12:48:37 +0100
Date:   Tue, 17 Dec 2019 12:48:37 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] perf/core: Add SRCU annotation for pmus list walk
Message-ID: <20191217114837.4jkyg3uojyu3f4qr@linutronix.de>
References: <20191119121429.zhcubzdhm672zasg@linutronix.de>
 <20191129200522.GA239292@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191129200522.GA239292@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-29 15:05:22 [-0500], Joel Fernandes wrote:
> On Tue, Nov 19, 2019 at 01:14:29PM +0100, Sebastian Andrzej Siewior wrote:
> > Since commit
> >    28875945ba98d ("rcu: Add support for consolidated-RCU reader checking")
> > 
> > there is an additional check to ensure that a RCU related lock is held
> > while the RCU list is iterated.
> > This section holds the SRCU reader lock instead.
> > 
> > Add annotation to list_for_each_entry_rcu() that pmus_srcu must be
> > acquired during the list traversal.
> > 
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> thanks,
> 
>  - Joel
> 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > 
> > I see the warning in in v5.4-rc during boot. For some reason I don't see
> > it in tip/master during boot but "perf stat w" triggers it again (among
> > other things).

kind ping

Sebastian
