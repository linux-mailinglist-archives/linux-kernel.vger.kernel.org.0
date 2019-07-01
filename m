Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2633851C20
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 22:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbfFXUQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 16:16:08 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:60293 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727595AbfFXUQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:16:08 -0400
Received: from [4.30.142.84] (helo=srivatsab-a01.vmware.com)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1hfVNk-000XTK-Vd; Mon, 24 Jun 2019 16:16:05 -0400
Subject: Re: [PATCH BUGFIX IMPROVEMENT 0/7] boost throughput with synced I/O,
 reduce latency and fix a bandwidth bug
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com
References: <20190624194042.38747-1-paolo.valente@linaro.org>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <f3e2d759-911b-f593-9ec5-b6b7a94df71c@csail.mit.edu>
Date:   Mon, 24 Jun 2019 13:15:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190624194042.38747-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/19 12:40 PM, Paolo Valente wrote:
> Hi Jens,
> this series, based against for-5.3/block, contains:
> 1) The improvements to recover the throughput loss reported by
>    Srivatsa [1] (first five patches)
> 2) A preemption improvement to reduce I/O latency
> 3) A fix of a subtle bug causing loss of control over I/O bandwidths
> 

Thanks a lot for these patches, Paolo!

Would you mind adding:

Reported-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Tested-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

to the first 5 patches, as appropriate?

Thank you!

> 
> [1] https://lkml.org/lkml/2019/5/17/755
> 
> Paolo Valente (7):
>   block, bfq: reset inject limit when think-time state changes
>   block, bfq: fix rq_in_driver check in bfq_update_inject_limit
>   block, bfq: update base request service times when possible
>   block, bfq: bring forward seek&think time update
>   block, bfq: detect wakers and unconditionally inject their I/O
>   block, bfq: preempt lower-weight or lower-priority queues
>   block, bfq: re-schedule empty queues if they deserve I/O plugging
> 
>  block/bfq-iosched.c | 952 ++++++++++++++++++++++++++++++--------------
>  block/bfq-iosched.h |  25 +-
>  2 files changed, 686 insertions(+), 291 deletions(-)
> 

Regards,
Srivatsa
VMware Photon OS
