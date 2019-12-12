Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B54C11D07A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 16:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfLLPGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 10:06:51 -0500
Received: from foss.arm.com ([217.140.110.172]:49942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbfLLPGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:06:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B06EB30E;
        Thu, 12 Dec 2019 07:06:48 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42FA23F6CF;
        Thu, 12 Dec 2019 07:06:47 -0800 (PST)
Subject: Re: [PATCH v3 0/5] sched/fair: Task placement biasing using uclamp
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, qperret@google.com,
        qais.yousef@arm.com, morten.rasmussen@arm.com
References: <20191211113851.24241-1-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <7c9caf20-de5b-3fa2-2663-e712ba3d7829@arm.com>
Date:   Thu, 12 Dec 2019 16:06:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211113851.24241-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2019 12:38, Valentin Schneider wrote:
> Hi,
> 
> While uclamp restrictions currently only impact schedutil's frequency
> selection, it would make sense to also let them impact CPU selection in
> asymmetric topologies. This would let us steer specific tasks towards
> certain CPU capacities regardless of their actual utilization - I give a
> few examples in patch 4.
> 
> The first three patches are mainly cleanups, the meat of the thing is
> in patches 4 and 5.
> 
> Note that this is in the same spirit as what Patrick had proposed for EAS
> on Android [1]
> 
> [1]: https://android.googlesource.com/kernel/common/+/b61876ed122f816660fe49e0de1b7ee4891deaa2%5E%21

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-By: Dietmar Eggemann <dietmar.eggemann@arm.com>

Tested on Juno-r0 (Arm64) cpumask [0x3f] w/ big [0x06], LITTLE [0x39]
[orig cpu capacity big,LITTLE: 1024,446] and rt-app

4 periodic tasks runtime/period [800/16000], per task uclamp_min/max
[600,1024]

w/o uclamp: EAS puts the tasks on LITTLE CPUs [0x39]
w/  uclamp: EAS puts the tasks on big CPUs [0x06]
