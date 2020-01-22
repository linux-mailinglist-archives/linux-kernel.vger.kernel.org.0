Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4610A1455D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 14:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgAVNZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 08:25:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37738 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgAVNZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:25:43 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iuG0o-0004k5-DC; Wed, 22 Jan 2020 14:25:38 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0DCA3101F92; Wed, 22 Jan 2020 14:25:38 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH V4] sched/isolation: isolate from handling managed interrupt
In-Reply-To: <20200120091625.17912-1-ming.lei@redhat.com>
References: <20200120091625.17912-1-ming.lei@redhat.com>
Date:   Wed, 22 Jan 2020 14:25:38 +0100
Message-ID: <87eevrei7h.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ming,

Ming Lei <ming.lei@redhat.com> writes:
>  
> +static bool hk_should_isolate(struct irq_data *data,
> +			      const struct cpumask *affinity, unsigned int cpu)
> +{

the *affinity argument is unused.

I'll remove it myself.

Thanks,

        tglx
