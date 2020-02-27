Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0EFA17236E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 17:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgB0Qcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 11:32:32 -0500
Received: from foss.arm.com ([217.140.110.172]:54470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730206AbgB0Qcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:32:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 554A21FB;
        Thu, 27 Feb 2020 08:32:31 -0800 (PST)
Received: from [10.0.8.126] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BD7B3F7B4;
        Thu, 27 Feb 2020 08:32:28 -0800 (PST)
Subject: Re: [PATCH 0/2] sched, arm64: enable CONFIG_SCHED_SMT for arm64
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        morten.rasmussen@arm.com, qperret@google.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20200226164118.6405-1-valentin.schneider@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a1e02a5e-4d1a-7b25-b6de-a3cc556a3a1f@arm.com>
Date:   Thu, 27 Feb 2020 16:32:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226164118.6405-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.02.20 16:41, Valentin Schneider wrote:
> Hi,
> 
> Strictly speaking those two patches are independent, but I figured it would
> make sense to send them together (since one led to the other).
> 
> Patch 1 adds a sanity check against EAS + SMT.
> Patch 2 enables CONFIG_SCHED_SMT in the arm64 defconfig.
> 
> Cheers,
> Valentin

With those small questions in 1/2 and 2/2:

Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"

