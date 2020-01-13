Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D3D1390B9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 13:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgAMMGY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Jan 2020 07:06:24 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2987 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728755AbgAMMGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:06:24 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 5E17B8A45B5013B38E2E;
        Mon, 13 Jan 2020 20:06:22 +0800 (CST)
Received: from DGGEMM506-MBX.china.huawei.com ([169.254.3.174]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0439.000;
 Mon, 13 Jan 2020 20:06:12 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] cpu-topology: Skip the exist but not possible cpu
 nodes
Thread-Topic: [PATCH v2] cpu-topology: Skip the exist but not possible cpu
 nodes
Thread-Index: AQHVyExqmWOdrHr7k0CDA2xXZLn68Kfn3yMAgAChbkA=
Date:   Mon, 13 Jan 2020 12:06:11 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED340E41D1@DGGEMM506-MBX.china.huawei.com>
References: <1578725620-39677-1-git-send-email-prime.zeng@hisilicon.com>
 <20200113101922.GE52694@bogus>
In-Reply-To: <20200113101922.GE52694@bogus>
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
> From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> Sent: Monday, January 13, 2020 6:19 PM
> To: Zengtao (B)
> Cc: Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki; Sudeep Holla;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] cpu-topology: Skip the exist but not possible cpu
> nodes
> 
> On Sat, Jan 11, 2020 at 02:53:40PM +0800, Zeng Tao wrote:
> > When CONFIG_NR_CPUS is smaller than the cpu nodes defined in the
> device
> > tree, all the cpu nodes parsing will fail.
> > And this is not reasonable for a legal device tree configs.
> > In this patch, skip such cpu nodes rather than return an error.
> > With CONFIG_NR_CPUS = 128 and cpus nodes num in device tree is
> 130,
> > The following warning messages will be print during boot:
> > CPU node for /cpus/cpu@128 exist but the possible cpu range
> is :0-127
> > CPU node for /cpus/cpu@129 exist but the possible cpu range
> is :0-127
> > CPU node for /cpus/cpu@130 exist but the possible cpu range
> is :0-127
> >
> > Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
> > ---
> > Changelog:
> > v1->v2:
> >  -Remove redundant -ENODEV assignment in get_cpu_for_node
> >  -Add comment to describe the get_cpu_for_node return values
> >  -Add skip process for cpu threads
> >  -Update the commit log with more detail
> > ---
> >  drivers/base/arch_topology.c | 37
> +++++++++++++++++++++++++++++--------
> >  1 file changed, 29 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/base/arch_topology.c
> b/drivers/base/arch_topology.c
> > index 5fe44b3..01f0e21 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -248,22 +248,44 @@ core_initcall(free_raw_capacity);
> >  #endif
> >
> >  #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
> > +/*
> > + * This function returns the logic cpu number of the node.
> > + * There are totally three kinds of return values:
> > + * (1) logic cpu number which is > 0.
> > + * (2) -ENDEV when the node is valid one which can be found in the
> device tree
> > + * but there is no possible cpu nodes to match, when the
> CONFIG_NR_CPUS is
> > + * smaller than cpus node numbers in device tree, this will happen.
> It's
> > + * suggested to just ignore this case.
> 
> s/ENDEV/ENODEV/
Good catch, thanks.

> 
> Also as I mentioned earlier, I prefer not to add any extra logic here
> other than the above comment to make it explicit. This triggers
> unnecessary
> warnings when someone boots with limited CPUs for valid reasons.
> 

So , what 's your suggestion here? Just keep the comments but remove
 the warning message print? 
> 
> > + * (3) -EINVAL when other errors occur.
> > + */
> >  static int __init get_cpu_for_node(struct device_node *node)
> >  {
> > -	struct device_node *cpu_node;
> > +	struct device_node *cpu_node, *t;
> >  	int cpu;
> > +	bool found = false;
> >
> >  	cpu_node = of_parse_phandle(node, "cpu", 0);
> >  	if (!cpu_node)
> > -		return -1;
> > +		return -EINVAL;
> > +
> > +	for_each_of_cpu_node(t)
> > +		if (t == cpu_node) {
> > +			found = true;
> > +			break;
> > +		}
> > +
> > +	if (!found) {
> > +		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
> > +		return -EINVAL;
> > +	}
> >
> >  	cpu = of_cpu_node_to_id(cpu_node);
> >  	if (cpu >= 0)
> >  		topology_parse_cpu_capacity(cpu_node, cpu);
> >  	else
> > -		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
> > +		pr_warn("CPU node for %pOF exist but the possible cpu range
> is :%*pbl\n",
> > +			cpu_node, cpumask_pr_args(cpu_possible_mask));
> >
> > -	of_node_put(cpu_node);
> 
> Why is this dropped ?

It's unnecessary here since no one get the node ref.

Regards
Zengtao 
