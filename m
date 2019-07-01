Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5FF64FB36
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2019 13:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfFWLQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 07:16:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33221 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfFWLQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 07:16:14 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf0Tf-00086e-Rm; Sun, 23 Jun 2019 13:16:07 +0200
Date:   Sun, 23 Jun 2019 13:16:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Anders Roxell <anders.roxell@linaro.org>
cc:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] seqlock: mark raw_read_seqcount and read_seqcount_retry
 as __always_inline
In-Reply-To: <20190611154751.10923-1-anders.roxell@linaro.org>
Message-ID: <alpine.DEB.2.21.1906231314030.32342@nanos.tec.linutronix.de>
References: <20190611154751.10923-1-anders.roxell@linaro.org>
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

On Tue, 11 Jun 2019, Anders Roxell wrote:

> With the function graph tracer, each traced function calls sched_clock()
> to take a timestamp. As sched_clock() uses
> raw_read_seqcount()/read_seqcount_retry(), we must ensure that these
> do not in turn trigger the graph tracer.
> Both functions is marked as inline. However, if CONFIG_OPTIMIZE_INLINING
> is set that may make the two functions tracable which they shouldn't.
> 
> Rework so that functions raw_read_seqcount and read_seqcount_retry are
> marked with __always_inline so they will be inlined even if
> CONFIG_OPTIMIZE_INLINING is turned on.

Why just those two? The same issue can happen in other places with other
clocks which can be utilized by the tracer.

Aside of your particular issue, there is no reason why any of those
functions should ever trigger a graph.

Thanks,

	tglx


