Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C02A171599
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 12:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgB0LEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 06:04:15 -0500
Received: from foss.arm.com ([217.140.110.172]:48622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728744AbgB0LEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:04:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 383881FB;
        Thu, 27 Feb 2020 03:04:14 -0800 (PST)
Received: from [10.1.195.59] (ifrit.cambridge.arm.com [10.1.195.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E1653F73B;
        Thu, 27 Feb 2020 03:04:13 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Fix kernel build warning in test_idle_cores()
 for !SMT NUMA
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, mgorman@techsingularity.net
References: <20200227110053.2514-1-lukasz.luba@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d2e0fe2d-5891-a2bf-a4c5-2a1f14754c1d@arm.com>
Date:   Thu, 27 Feb 2020 11:04:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227110053.2514-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 2/27/20 11:00 AM, Lukasz Luba wrote:
> Fix kernel build warning in kernel/sched/fair.c when CONFIG_SCHED_SMT is
> not set and CONFIG_NUMA_BALANCING is set.
> 
> kernel/sched/fair.c:1524:20: warning: ‘test_idle_cores’ declared ‘static’ but never defined [-Wunused-function]
> 

I've sent a similar fix yesterday at:

https://lore.kernel.org/lkml/20200226121244.7524-1-valentin.schneider@arm.com/
