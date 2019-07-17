Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFDA6B8A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 10:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfGQIx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 04:53:29 -0400
Received: from mail.monom.org ([188.138.9.77]:41954 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfGQIx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:53:29 -0400
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jul 2019 04:53:28 EDT
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 0A8CD50048A;
        Wed, 17 Jul 2019 10:45:09 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from [192.168.154.175] (b9168f23.cgn.dg-w.de [185.22.143.35])
        by mail.monom.org (Postfix) with ESMTPSA id 369EA500294;
        Wed, 17 Jul 2019 10:45:08 +0200 (CEST)
Subject: Re: [patch 1/1] Kconfig: Introduce CONFIG_PREEMPT_RT
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <clark.williams@gmail.com>,
        Julia Cartwright <julia@ni.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20190715150402.798499167@linutronix.de>
 <20190715150601.205143057@linutronix.de>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <8845b6bd-34ec-d989-d16f-23f523f8233e@monom.org>
Date:   Wed, 17 Jul 2019 10:45:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190715150601.205143057@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/15/19 5:04 PM, Thomas Gleixner wrote:
> Add a new entry to the preemption menu which enables the real-time support
> for the kernel. The choice is only enabled when an architecture supports
> it.
> 
> It selects PREEMPT as the RT features depend on it. To achieve that the
> existing PREEMPT choice is renamed to PREEMPT_LL which select PREEMPT as
> well.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

As one of the stable-rt maintainers I love to see this move forward!

Acked-by: Daniel Wagner <wagi@monom.org>
