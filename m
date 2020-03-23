Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 823C518F990
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 17:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCWQWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 12:22:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41988 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgCWQWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:22:08 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jGPpw-00021O-Na; Mon, 23 Mar 2020 17:22:00 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 138461040AA; Mon, 23 Mar 2020 17:22:00 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>, Vu Tran <vu.tran@windriver.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] affine kernel threads to specified cpumask
In-Reply-To: <20200323135414.GA28634@fuller.cnet>
References: <20200323135414.GA28634@fuller.cnet>
Date:   Mon, 23 Mar 2020 17:22:00 +0100
Message-ID: <87k13boxcn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
Marcelo Tosatti <mtosatti@redhat.com> writes:

the subject lacks a prefix and the CC list a few people.

> This is a kernel enhancement to configure the cpu affinity of kernel
> threads via kernel boot option kthread_cpus=<cpulist>.
>
> With kthread_cpus specified, the cpumask is immediately applied upon
> thread launch. This does not affect kernel threads that specify cpu
> and node.
>
> This allows CPU isolation (that is not allowing certain threads
> to execute on certain CPUs) without using the isolcpus= parameter,
> making it possible to enable load balancing on such CPUs 
> during runtime.

I'm surely missing some background information, but that sentence does
not make any sense to me.

Thanks,

        tglx
