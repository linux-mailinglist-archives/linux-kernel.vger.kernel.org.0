Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD04108CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 12:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfKYLND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 06:13:03 -0500
Received: from foss.arm.com ([217.140.110.172]:48670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfKYLND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:13:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04D8231B;
        Mon, 25 Nov 2019 03:13:03 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C2233F52E;
        Mon, 25 Nov 2019 03:13:01 -0800 (PST)
Subject: Re: [PATCH v4 11/11] sched/fair: rework find_idlest_group
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
 <5b4d204f-ce18-948a-416b-1920bcea7cf7@arm.com>
 <CAKfTPtDHY6oQRyMr0uH69UTCWyptyfdu9uEac3Um=fgGb5-eCQ@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <10684db8-8ecc-9e1e-743a-fcbe1ac1fa67@arm.com>
Date:   Mon, 25 Nov 2019 11:13:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDHY6oQRyMr0uH69UTCWyptyfdu9uEac3Um=fgGb5-eCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2019 09:59, Vincent Guittot wrote:
>>> +     case group_imbalanced:
>>> +     case group_asym_packing:
>>> +             /* Those type are not used in the slow wakeup path */
>>> +             return NULL;
>>
>> I suppose group_asym_packing could be handled similarly to misfit, right?
>> i.e. make the group type group_asym_packing if
>>
>>   !sched_asym_prefer(sg.asym_prefer_cpu, local.asym_prefer_cpu)
> 
> Unlike group_misfit_task that was somehow already taken into account
> through the comparison of spare capacity, group_asym_packing was not
> considered at all in find_idlest_group so I prefer to stay
> conservative and wait for users of asym_packing to come with a need
> before adding this new mechanism.
> 

Right, makes sense.
