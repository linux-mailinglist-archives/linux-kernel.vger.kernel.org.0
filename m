Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC49140CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 15:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgAQOhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 09:37:32 -0500
Received: from foss.arm.com ([217.140.110.172]:41922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgAQOhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:37:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A11911D4;
        Fri, 17 Jan 2020 06:37:31 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 026683F534;
        Fri, 17 Jan 2020 06:37:29 -0800 (PST)
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200114101319.GO3466@techsingularity.net>
 <20200116163529.GP3466@techsingularity.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <4cd0dda0-a944-b0ac-a614-6127b60babe6@arm.com>
Date:   Fri, 17 Jan 2020 14:37:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200116163529.GP3466@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2020 16:35, Mel Gorman wrote:
> Any thoughts on whether this is ok for tip or are there suggestions on
> an alternative approach?
> 

My main concern was about using number of tasks instead of number of busy
CPUs, which you're doing here, so I'm happy with that side of things.

As for the simpler imbalance heuristic, I don't have any issue with it
either. It's obvious that it caters to pairs of communicating tasks, and
we can try to extend it later on if required.

So yeah, FWIW:
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
