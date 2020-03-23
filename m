Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8FF18F5C5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 14:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgCWNbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 09:31:04 -0400
Received: from foss.arm.com ([217.140.110.172]:49076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgCWNbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:31:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71F9A1FB;
        Mon, 23 Mar 2020 06:31:03 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D0113F52E;
        Mon, 23 Mar 2020 06:31:02 -0700 (PDT)
References: <20200320151245.21152-1-mgorman@techsingularity.net> <20200320151245.21152-4-mgorman@techsingularity.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] sched/fair: Clear SMT siblings after determining the core is not idle
In-reply-to: <20200320151245.21152-4-mgorman@techsingularity.net>
Date:   Mon, 23 Mar 2020 13:31:00 +0000
Message-ID: <jhjzhc7kxkb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Mar 20 2020, Mel Gorman wrote:
> The clearing of SMT siblings from the SIS mask before checking for an idle
> core is a small but unnecessary cost. Defer the clearing of the siblings
> until the scan moves to the next potential target. The cost of this was
> not measured as it is borderline noise but it should be self-evident.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
