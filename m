Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84BDB2E02C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 16:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfE2Owr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 10:52:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54874 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfE2Owr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:52:47 -0400
Received: from p200300d06f28ff00b92b307fdbdaf2b9.dip0.t-ipconnect.de ([2003:d0:6f28:ff00:b92b:307f:dbda:f2b9] helo=somnus.fritz.box)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1hVzwZ-0005zw-9x; Wed, 29 May 2019 16:52:43 +0200
Date:   Wed, 29 May 2019 16:52:37 +0200 (CEST)
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [patch 0/3] do not raise timer softirq unconditionally (spinlockless
 version)
In-Reply-To: <20190415201213.600254019@amt.cnet>
Message-ID: <alpine.DEB.2.21.1905291651500.1395@somnus>
References: <20190415201213.600254019@amt.cnet>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had a look at the queue and have several questions about your
implementation. 

First of all, I had some troubles to understand your commit messages. So I
first had to read the code and then tried to understand the commit
messages. It is easier, if it works the other way round.

On Mon, 15 Apr 2019, Marcelo Tosatti wrote:

> For isolated CPUs, we'd like to skip awakening ktimersoftd
> (the switch to and then back from ktimersoftd takes 10us in
> virtualized environments, in addition to other OS overhead,
> which exceeds telco requirements for packet forwarding for
> 5G) from the sched tick.

You would like to prevent raising the timer softirq in general from the
sched tick for isolated CPUs? Or you would like to prevent raising the
timer softirq if no pending timer is available?

Nevertheless, this change is not PREEMPT_RT specific. It is a NOHZ
dependand change. So it would be nice, if the queue is against
mainline. But please correct me, if I'm wrong.

[...]

> This patchset reduces cyclictest latency from 25us to 14us
> on my testbox. 
> 

A lot of information is missing: How does your environment looks like for
this test, what is your workload,...?

Did you also run other tests?

Thanks,

	Anna-Maria
