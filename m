Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F7515AABD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 15:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgBLOH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 09:07:29 -0500
Received: from foss.arm.com ([217.140.110.172]:33338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbgBLOH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:07:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 512B6328;
        Wed, 12 Feb 2020 06:07:28 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5EAC3F6CF;
        Wed, 12 Feb 2020 06:07:26 -0800 (PST)
Subject: Re: [RFC PATCH 00/11] Reconcile NUMA balancing decisions with the
 load balancer
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200212093654.4816-1-mgorman@techsingularity.net>
 <CAKfTPtA7LVe0wccghiQbRArfZZFz7xZwV3dsoQ_Jcdr4swVWZQ@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <33127d22-5199-d4f2-8ee6-8b5a0491d40e@arm.com>
Date:   Wed, 12 Feb 2020 14:07:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtA7LVe0wccghiQbRArfZZFz7xZwV3dsoQ_Jcdr4swVWZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/02/2020 13:22, Vincent Guittot wrote:
> Don't know if it's only me but I can't find patches 9-11 on mailing list
> 

Same here, doesn't show up on lore either:
https://lore.kernel.org/lkml/20200212093654.4816-1-mgorman@techsingularity.net/#r
