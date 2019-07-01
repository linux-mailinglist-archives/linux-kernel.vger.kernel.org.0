Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0992DC98
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 14:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfE2MWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 08:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfE2MWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:22:53 -0400
Received: from oasis.local.home (unknown [12.156.218.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74BF92081C;
        Wed, 29 May 2019 12:22:51 +0000 (UTC)
Date:   Wed, 29 May 2019 08:22:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, williams@redhat.com,
        daniel@bristot.me, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC 1/3] softirq: Use preempt_latency_stop/start to trace
 preemption
Message-ID: <20190529082248.76bb7a6c@oasis.local.home>
In-Reply-To: <20190529093056.GA146079@google.com>
References: <cover.1559051152.git.bristot@redhat.com>
        <b6bb4705efb0c01c11008ae3c46bc74555245303.1559051152.git.bristot@redhat.com>
        <20190529093056.GA146079@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 05:30:56 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> Yes, I think so. Also this patch changes CALLER_ADDR0 passed to the
> tracepoint because there's one more level of a non-inlined function call
> in the call chain right?  Very least the changelog should document this
> change in functional behavior, IMO.

This sounds more like a break in behavior not a functional change. I
guess moving it to a header and making it a static __always_inline
should be fine though.

-- Steve
