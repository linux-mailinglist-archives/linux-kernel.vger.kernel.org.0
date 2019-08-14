Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7280E8D4DB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfHNNh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 09:37:28 -0400
Received: from foss.arm.com ([217.140.110.172]:54790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfHNNhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:37:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58B8928;
        Wed, 14 Aug 2019 06:37:24 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A73F23F706;
        Wed, 14 Aug 2019 06:37:22 -0700 (PDT)
Subject: Re: [PATCH 2/9] sched: treewide: use is_kthread()
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, akpm@linux-foundation.org,
        bigeasy@linutronix.de, bp@suse.de, catalin.marinas@arm.com,
        davem@davemloft.net, hch@lst.de, kan.liang@intel.com,
        mingo@kernel.org, peterz@infradead.org, riel@surriel.com,
        will@kernel.org
References: <20190814104131.20190-1-mark.rutland@arm.com>
 <20190814104131.20190-3-mark.rutland@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <8647b1da-e654-714a-ce6e-7b92110a066f@arm.com>
Date:   Wed, 14 Aug 2019 14:37:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190814104131.20190-3-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2019 11:41, Mark Rutland wrote:
> Now that we have is_kthread(), let's convert existing open-coded checks
> of the form:
> 
>   task->flags & PF_KTHREAD
> 
> ... over to the new helper, which makes things a little easier to read,
> and sets a consistent example for new code to follow.
> 

[...]

>  kernel/sched/core.c              | 8 ++++----
>  kernel/sched/idle.c              | 2 +-
>  kernel/sched/wait.c              | 2 +-

Looks all sane there for me.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
