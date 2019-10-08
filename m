Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B891D0013
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 19:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfJHRng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 13:43:36 -0400
Received: from foss.arm.com ([217.140.110.172]:42238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfJHRnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:43:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD54315BE;
        Tue,  8 Oct 2019 10:36:53 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F35B3F6C4;
        Tue,  8 Oct 2019 10:36:52 -0700 (PDT)
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
 <c752dd1a-731e-aae3-6a2c-aecf88901ac0@arm.com>
 <CAKfTPtBQNJfNmBqpuaefsLzsTrGxJ=2bTs+tRdbOAa9J3eKuVw@mail.gmail.com>
 <31cac0c1-98e4-c70e-e156-51a70813beff@arm.com>
 <20191008141642.GQ2294@hirez.programming.kicks-ass.net>
 <b4e29e48-a97c-67e5-a284-6ddc13222c5b@arm.com>
 <20191008163357.GF2328@hirez.programming.kicks-ass.net>
 <5de71c9f-cd6b-0284-f4a0-0d1fe4059099@arm.com>
Message-ID: <df8cff7b-a83c-42d1-f1c7-1a711dc1b2ce@arm.com>
Date:   Tue, 8 Oct 2019 18:36:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5de71c9f-cd6b-0284-f4a0-0d1fe4059099@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2019 17:39, Valentin Schneider wrote:
>>
>> But -fno-strict-overflow mandates 2s complement for all such signed
>> issues.
>>
> 
> So then there really shouldn't be any ambiguity. I have no idea if
> -fno-strict-overflow then also lifts the undefinedness of the right shifts,
> gotta get my spade and dig some more.
> 

Bleh, no luck really.

Thinking about it some more you can't overflow by right shifting
(logical/arithmetic), so I dunno if signed right shift counts as "such
signed issues".
