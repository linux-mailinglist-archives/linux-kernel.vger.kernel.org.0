Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF0EB2147
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 15:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390343AbfIMNm4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Sep 2019 09:42:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34450 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388473AbfIMNm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:42:56 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i8lqV-0000oE-Sw; Fri, 13 Sep 2019 15:42:43 +0200
Date:   Fri, 13 Sep 2019 15:42:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sean V Kelley <sean.v.kelley@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG RT] backtrace on v5.2.9-rt3
Message-ID: <20190913134243.3zoliue6yqfzyatl@linutronix.de>
References: <20190830120106.301bd9f3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190830120106.301bd9f3@gandalf.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-30 12:01:06 [-0400], Steven Rostedt wrote:
> 
> I'm triggering the following call splat on 5.2-rt.
> 
> [   63.099414] 006: BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:968
> [   63.108423] 006: in_atomic(): 0, irqs_disabled(): 1, pid: 173, name: kworker/6:1
…
> [   63.141041] 006: Call Trace:
> [   63.143916] 006:  dump_stack+0x5c/0x80
> [   63.147654] 006:  ___might_sleep.cold.92+0x8d/0x9a
> [   63.152423] 006:  rt_spin_lock+0x31/0x40
> [   63.156332] 006:  intel_engine_breadcrumbs_irq+0x56/0x320 [i915]
> [   63.162350] 006:  intel_engine_signal_breadcrumbs+0x11/0x20 [i915]
> [   63.168540] 006:  i915_hangcheck_elapsed+0x199/0x420 [i915]
…
> [   63.309375] 006:  process_one_work+0x1e8/0x4c0
…
> Attached is the config and the full dmesg.

just for book keeping: Clark reported the same thing, posted patches and
will try an alternative on Monday (as far as I'm been told). I will
continue to reply in the other thread.

Sebastian
