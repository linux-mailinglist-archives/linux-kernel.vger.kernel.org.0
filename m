Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64FDD16241A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 11:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgBRKBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 05:01:20 -0500
Received: from foss.arm.com ([217.140.110.172]:48980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgBRKBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:01:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2F141FB;
        Tue, 18 Feb 2020 02:01:19 -0800 (PST)
Received: from [10.1.195.59] (ifrit.cambridge.arm.com [10.1.195.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 838ED3F6CF;
        Tue, 18 Feb 2020 02:01:18 -0800 (PST)
Subject: Re: [PATCH 1/3] sched/rt: cpupri_find: implement fallback mechanism
 for !fit case
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-2-qais.yousef@arm.com>
 <3feb31bb-3412-b38c-07a3-136433c87e66@arm.com>
 <20200217233413.pzwod3y4y6tl3ogh@e107158-lin>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <769315c6-5e1c-ad13-5ac2-a50303693ad6@arm.com>
Date:   Tue, 18 Feb 2020 10:01:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217233413.pzwod3y4y6tl3ogh@e107158-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/20 11:34 PM, Qais Yousef wrote:
> On 02/17/20 17:07, Valentin Schneider wrote:
>> Just a drive-by comment; could you split that code move into its own patch?
>> It'd make the history a bit easier to read IMO.
> 
> Hmm I don't see how it would help the history.
> 
> In large series with big churn splitting helps to facilitate review, but
> I don't think reviewing this patch is hard because of creating the new
> function.
> 
> And git-blame will have this patch all over the new function, so people who
> care to know the reason of the split will land at the right place directly
> without any extra level of indirection.
> 

As a git-blame addict I yearn for nice clean splits, and this is a code move
plus a new behaviour; having them in the same patch doesn't make for the
prettiest diff there is (also helps for review, yadda yadda). That said, I'm
not going to argue further over it, I'm barely a tenant in this house.

> Thanks
> 
> --
> Qais Yousef
> 
