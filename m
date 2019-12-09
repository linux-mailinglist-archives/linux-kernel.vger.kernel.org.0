Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D183011708E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 16:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfLIPgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 10:36:41 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:36144 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbfLIPgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:36:41 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ieL5J-0002fY-Gf; Mon, 09 Dec 2019 16:36:29 +0100
To:     Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity  for managed interrupt
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Dec 2019 15:36:29 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        <tglx@linutronix.de>, <chenxiang66@hisilicon.com>,
        <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>
In-Reply-To: <fd4192c6-351a-144f-9c31-d5a89c6fdedf@suse.de>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
 <305198e5-f76f-ded4-946b-9cfade18f08c@suse.de>
 <c06752c858229854b37af3b47779b126@www.loen.fr>
 <fd4192c6-351a-144f-9c31-d5a89c6fdedf@suse.de>
Message-ID: <017fd81e113181218b0fe75db737df98@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: hare@suse.de, john.garry@huawei.com, ming.lei@redhat.com, tglx@linutronix.de, chenxiang66@hisilicon.com, bigeasy@linutronix.de, linux-kernel@vger.kernel.org, hare@suse.com, hch@lst.de, axboe@kernel.dk, bvanassche@acm.org, peterz@infradead.org, mingo@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-09 15:25, Hannes Reinecke wrote:
> On 12/9/19 4:17 PM, Marc Zyngier wrote:
>> On 2019-12-09 15:09, Hannes Reinecke wrote:
>> [slight digression]
>>
>>> My idea here is slightly different: can't we leverage SMT?
>>> Most modern CPUs do SMT (I guess even ARM does it nowadays)
>>> (Yes, I know about spectre and things. We're talking performance 
>>> here :-)
>> I only know two of those: Cavium TX2 and ARM Neoverse-E1.
>> ARM SMT CPUs are the absolute minority (and I can't say I'm 
>> displeased).
>
> Ach, too bad.
>
> Still a nice idea, putting SMT finally to some use ...

But isn't your SMT idea just a special case of providing an affinity
for the thread (and in this case relative to the affinity of the hard
IRQ)?

You could apply the same principle to target any CPU affinity, and 
maybe
provide hints for the placement if you're really keen (same L3, for
example).

         M.
-- 
Jazz is not dead. It just smells funny...
