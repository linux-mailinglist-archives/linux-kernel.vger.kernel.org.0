Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC2D31359A0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 13:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgAIM7A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Jan 2020 07:59:00 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2984 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727701AbgAIM67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:58:59 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 92E2B61989C397F077D1;
        Thu,  9 Jan 2020 20:58:55 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.143]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0439.000;
 Thu, 9 Jan 2020 20:58:45 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpu-topology: warn if NUMA configurations conflicts
 with lower layer
Thread-Topic: [PATCH] cpu-topology: warn if NUMA configurations conflicts
 with lower layer
Thread-Index: AQHVuWnsK0zwK8RxTkqe/SNAoYeaUKfT+S+AgALBI6CAAAyngIAAlqWw//+IwoCAAXt3QP//+lWAgASRonCABMxoAIAAodIA
Date:   Thu, 9 Jan 2020 12:58:44 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340BEDD6@dggemm526-mbx.china.huawei.com>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
 <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
 <20200103114011.GB19390@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340B31E9@dggemm526-mbx.china.huawei.com>
 <20200109104306.GA10914@e105550-lin.cambridge.arm.com>
In-Reply-To: <20200109104306.GA10914@e105550-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Morten Rasmussen [mailto:morten.rasmussen@arm.com]
> Sent: Thursday, January 09, 2020 6:43 PM
> To: Zengtao (B)
> Cc: Sudeep Holla; Valentin Schneider; Linuxarm; Greg Kroah-Hartman;
> Rafael J. Wysocki; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts
> with lower layer
> 
> On Mon, Jan 06, 2020 at 01:37:59AM +0000, Zengtao (B) wrote:
> > > -----Original Message-----
> > > From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> > > Sent: Friday, January 03, 2020 7:40 PM
> > > To: Zengtao (B)
> > > Cc: Valentin Schneider; Linuxarm; Greg Kroah-Hartman; Rafael J.
> Wysocki;
> > > linux-kernel@vger.kernel.org; Morten Rasmussen; Sudeep Holla
> > > Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations
> conflicts
> > > with lower layer
> > >
> > > On Fri, Jan 03, 2020 at 04:24:04AM +0000, Zengtao (B) wrote:
> > > > > -----Original Message-----
> > > > > From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> > > > > Sent: Thursday, January 02, 2020 9:22 PM
> > > > > To: Zengtao (B); Sudeep Holla
> > > > > Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki;
> > > > > linux-kernel@vger.kernel.org; Morten Rasmussen
> > > > > Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations
> > > conflicts
> > > > > with lower layer
> > > > >
> > >
> > > [...]
> > >
> > > > >
> > > > > Right, and that is checked when you have sched_debug on the
> cmdline
> > > > > (or write 1 to /sys/kernel/debug/sched_debug & regenerate the
> sched
> > > > > domains)
> > > > >
> > > >
> > > > No, here I think you don't get my issue, please try to understand my
> > > example
> > > > First:.
> > > >
> > > > *************************************
> > > > NUMA:         0-2,  3-7
> > > > core_siblings:    0-3,  4-7
> > > > *************************************
> > > > When we are building the sched domain, per the current code:
> > > > (1) For core 3
> > > >  MC sched domain fallbacks to 3~7
> > > >  DIE sched domain is 3~7
> > > > (2) For core 4:
> > > >  MC sched domain is 4~7
> > > >  DIE sched domain is 3~7
> > > >
> > > > When we are build sched groups for the MC level:
> > > > (1). core3's sched groups chain is built like as: 3->4->5->6->7->3
> > > > (2). core4's sched groups chain is built like as: 4->5->6->7->4
> > > > so after (2),
> > > > core3's sched groups is overlapped, and it's not a chain any more.
> > > > In the afterwards usecase of core3's sched groups, deadloop
> happens.
> > > >
> > > > And it's difficult for the scheduler to find out such errors,
> > > > that is why I think a warning is necessary here.
> > > >
> > >
> > > We can figure out a way to warn if it's absolutely necessary, but I
> > > would like to understand the system topology here. You haven't
> answered
> > > my query on cache topology. Please give more description on why the
> > > NUMA configuration is like the above example with specific hardware
> > > design details. Is this just a case where user can specify anything
> > > they wish ?
> > >
> >
> > Sorry for the late response, In fact, it's a VM usecase, you can simply
> > understand it as a test case. It's a corner case, but it will hang the
> kernel,
> > that is why I suggest a warning is needed.
> >
> > I think we need an sanity check or just simply warning, either in the
> scheduler
> > or arch topology parsing.
> 
> IIUC, the problem is that virt can set up a broken topology in some
> cases where MPIDR doesn't line up correctly with the defined NUMA
> nodes.
> 
> We could argue that it is a qemu/virt problem, but it would be nice if
> we could at least detect it. The proposed patch isn't really the right
> solution as it warns on some valid topologies as Sudeep already pointed
> out.
> 
> It sounds more like we need a mask subset check in the sched_domain
> building code, if there isn't already one?

Currently no, it's a bit complex to do the check in the sched_domain building code,
I need to take a think of that.
Suggestion welcomed.

Thanks 
Zengtao 

> 
> Morten
