Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D35BA191785
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 18:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgCXRVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 13:21:02 -0400
Received: from foss.arm.com ([217.140.110.172]:38616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbgCXRVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:21:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C77301FB;
        Tue, 24 Mar 2020 10:21:01 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C651E3F71F;
        Tue, 24 Mar 2020 10:21:00 -0700 (PDT)
References: <20200324125533.17447-1-valentin.schneider@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        mgorman@techsingularity.net
Subject: Re: [PATCH] sched/topology: Fix overlapping sched_group build
In-reply-to: <20200324125533.17447-1-valentin.schneider@arm.com>
Date:   Tue, 24 Mar 2020 17:20:52 +0000
Message-ID: <jhjmu85sm8b.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Mar 24 2020, Valentin Schneider wrote:
> Fix
> ===
>
> Sanitize the groups we get out of build_group_from_child_sched_domain()
> with the span of the domain we're currently building - this ensures the
> groups we build only contain CPUs that are the right distance away from the
> base CPU. This also requires modifying build_balance_mask().
>

I somehow missed that this triggers the WARN_ON_ONCE() in
init_overlap_sched_group(). Gotta figure out why.
