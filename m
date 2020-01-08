Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E5E1340E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 12:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgAHLn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 06:43:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgAHLn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JF05G3rkot977g2qfc7sNbF8fG7HHlZ96SCciWcuNc8=; b=e6SPGoWALp7vt4ZaOXv/Hi75I
        piaEDXez66PSnE0qWoEJoP792McVIpkPUFfUKmSTPnWE62zSh/j8WHk2twYQcGR4bjcvvXluFlWil
        pRgSuXlI89AFQMwvul++d1zGuS09Rgmkd6CqspXvQwAZNBpj5OY6R21M9S7/SCe2CpwBStgjLSJEJ
        6SBA4MHQPCLw2CKFgDv8bxYlyZgwBFWnj3fvEg6pX6IjFDhvQA0I5MWQMG0ZVMyOeNnHj7vTnnqgO
        eIoaAQt7BBHld3lhErEyqKFCC2I7sBLqM6+yq9gY0DUSIbfZjLRUsrRYHL06t252sEGQrxIWq6LGN
        fXQmu9pQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ip9k0-0006GW-Vg; Wed, 08 Jan 2020 11:43:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 306AC305EDF;
        Wed,  8 Jan 2020 12:41:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 268E329A60326; Wed,  8 Jan 2020 12:43:10 +0100 (CET)
Date:   Wed, 8 Jan 2020 12:43:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair : Improve update_sd_pick_busiest for spare
 capacity case
Message-ID: <20200108114310.GD2844@hirez.programming.kicks-ass.net>
References: <1576839893-26930-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576839893-26930-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 12:04:53PM +0100, Vincent Guittot wrote:
> Similarly to calculate_imbalance() and find_busiest_group(), using the
> number of idle CPUs when there is only 1 CPU in the group is not efficient
> because we can't make a difference between a CPU running 1 task and a CPU
> running dozens of small tasks competing for the same CPU but not enough
> to overload it. More generally speaking, we should use the number of
> running tasks when there is the same number of idle CPUs in a group instead
> of blindly select the 1st one.
> 
> When the groups have spare capacity and the same number of idle CPUs, we
> compare the number of running tasks to select the busiest group.
> 
Thanks!
