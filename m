Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2D3A813A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 13:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfIDLjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 07:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfIDLjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:39:23 -0400
Received: from oasis.local.home (bl11-233-114.dsl.telepac.pt [85.244.233.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A9BB20820;
        Wed,  4 Sep 2019 11:39:20 +0000 (UTC)
Date:   Wed, 4 Sep 2019 07:39:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20190904073915.4a145a91@oasis.local.home>
In-Reply-To: <20190903132602.3440-2-viktor.rosendahl@gmail.com>
References: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
        <20190903132602.3440-2-viktor.rosendahl@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Sep 2019 15:25:59 +0200
Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:

> +void latency_fsnotify_stop(void)
> +{
> +	/* Make sure all CPUs see caller's previous actions to stop tracer */
> +	smp_wmb();

These memory barriers just look wrong. What exactly are you trying to protect here?

Where's the matching rmbs?

-- Steve

> +	static_branch_disable(&latency_notify_key);
> +	latency_fsnotify_process();
> +}
> +
> +void latency_fsnotify_start(void)
> +{
> +	static_branch_enable(&latency_notify_key);
> +	/* Make sure all CPUs see key value before caller continue */
> +	smp_wmb();
> +}
> +
