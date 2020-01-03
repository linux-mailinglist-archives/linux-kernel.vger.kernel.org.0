Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CACD512F76C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 12:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgACLkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 06:40:15 -0500
Received: from foss.arm.com ([217.140.110.172]:54910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbgACLkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 686661FB;
        Fri,  3 Jan 2020 03:40:14 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D6B73F703;
        Fri,  3 Jan 2020 03:40:13 -0800 (PST)
Date:   Fri, 3 Jan 2020 11:40:11 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
Message-ID: <20200103114011.GB19390@bogus>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
 <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 04:24:04AM +0000, Zengtao (B) wrote:
> > -----Original Message-----
> > From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> > Sent: Thursday, January 02, 2020 9:22 PM
> > To: Zengtao (B); Sudeep Holla
> > Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki;
> > linux-kernel@vger.kernel.org; Morten Rasmussen
> > Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts
> > with lower layer
> >

[...]

> >
> > Right, and that is checked when you have sched_debug on the cmdline
> > (or write 1 to /sys/kernel/debug/sched_debug & regenerate the sched
> > domains)
> >
>
> No, here I think you don't get my issue, please try to understand my example
> First:.
>
> *************************************
> NUMA:         0-2,  3-7
> core_siblings:    0-3,  4-7
> *************************************
> When we are building the sched domain, per the current code:
> (1) For core 3
>  MC sched domain fallbacks to 3~7
>  DIE sched domain is 3~7
> (2) For core 4:
>  MC sched domain is 4~7
>  DIE sched domain is 3~7
>
> When we are build sched groups for the MC level:
> (1). core3's sched groups chain is built like as: 3->4->5->6->7->3
> (2). core4's sched groups chain is built like as: 4->5->6->7->4
> so after (2),
> core3's sched groups is overlapped, and it's not a chain any more.
> In the afterwards usecase of core3's sched groups, deadloop happens.
>
> And it's difficult for the scheduler to find out such errors,
> that is why I think a warning is necessary here.
>

We can figure out a way to warn if it's absolutely necessary, but I
would like to understand the system topology here. You haven't answered
my query on cache topology. Please give more description on why the
NUMA configuration is like the above example with specific hardware
design details. Is this just a case where user can specify anything
they wish ?

--
Regards,
Sudeep
