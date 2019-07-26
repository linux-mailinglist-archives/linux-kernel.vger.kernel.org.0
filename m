Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97B5C772EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 22:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfGZUlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 16:41:12 -0400
Received: from ms.lwn.net ([45.79.88.28]:52136 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfGZUlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:41:12 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 885E44BF;
        Fri, 26 Jul 2019 20:41:11 +0000 (UTC)
Date:   Fri, 26 Jul 2019 14:41:10 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Phil Frost <indigo@bitglue.com>
Cc:     Ingo Molnar <mingo@elte.hu>, trivial@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Correct documentation for /proc/schedstat
Message-ID: <20190726144110.3b12ae56@lwn.net>
In-Reply-To: <20190724185029.26822-1-indigo@bitglue.com>
References: <20190724185029.26822-1-indigo@bitglue.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019 11:50:27 -0700
Phil Frost <indigo@bitglue.com> wrote:

> Commit 425e0968a25fa3f111f9919964cac079738140b5 ("sched: move code into
> kernel/sched_stats.h") appears to have inadvertently changed the unit of
> time from jiffies to nanoseconds as part of the implementation of CFS.
> 
> Signed-off-by: Phil Frost <indigo@bitglue.com>
> ---
>  Documentation/scheduler/sched-stats.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/scheduler/sched-stats.txt b/Documentation/scheduler/sched-stats.txt
> index 8259b34a66ae..b6c1807a01b3 100644
> --- a/Documentation/scheduler/sched-stats.txt
> +++ b/Documentation/scheduler/sched-stats.txt
> @@ -19,6 +19,11 @@ are no architectures which need more than three domain levels. The first
>  field in the domain stats is a bit map indicating which cpus are affected
>  by that domain.
>  
> +2.6.23 introduced the CFS scheduler, and also an inadvertent
> +backwards-incompatible change to the statistics. Although the schedstat version
> +is 14 in either case, in 2.6.23 and later, counters accumulate time in
> +nanoseconds. Prior to that, jiffies.

Clearly, making the documentation correct is a good thing to do.  I do
have to wonder if we really have to document how things were 12 years ago
as well, though.  Anybody who is unfortunate enough to be dealing with a
pre-2.6.23 kernel will want to refer to the documentation files shipped
with that kernel rather than what we have now.  So I'd recommend just
making the file reflect the current state of affairs.

Thanks,

jon
