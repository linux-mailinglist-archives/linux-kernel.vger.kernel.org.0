Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE4D17F784
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 13:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgCJMfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 08:35:31 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:60404 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726315AbgCJMfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:35:31 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ACVXt5025950;
        Tue, 10 Mar 2020 05:35:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=VA81lSIxg9w3f1AELJUtxgbm2r4t3slGIK9D59YttKw=;
 b=vYhX2pL4Fnzt+DCnXbYj0YesOedwTF7h2Ezem0cKmZVp+7YZZ2mFADR0Mxz0NjXV7RIN
 Q6//UyV7iTeVga6frj6Beqy781C5XrWtrT7U72sMPiHFBEyRvIlaExwD3dknt695vO0N
 DqJFgL/4akvzsa9hl3jpP935SwcLmL1LLu7B1+ftLyKrynAgKcgKooOq9831hgZ6rqiB
 /M90H/OfJmRVq9LPj+BcYNiPxE1RAIxMl388dAkXRStVkDZlo2JGvMtlnFoJ4sFwWrTd
 uJIQPWvyHKbuvExqfnb9eGV9L6r0jkDHBJKwOwtXbrG446lEM2yHwBXLmwWdbkiItUxo fA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ym9uwntm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 Mar 2020 05:35:11 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 10 Mar
 2020 05:35:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 10 Mar 2020 05:35:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbZbz8p/ZVhmrmirZSCIpoZCQNfMFxcqBQt8TfGbaSiw4Rm6PzO22x65Xb0sJMLrbD8uDA8EnhZVDMMo12tN93Ei56z4YCVeH/D75vpYgdpoiX9UKM3uZNcgckGZYmbOBnFu7CtOjm+s61CH4v1VVUQhnda+YMW/lW8p5rQdMYXcvSZY6MXODMC/hfzgu8nWkhuGSk2+2CJPgM9mJPmYL4Z48xusxtiYLv9rMD+l9t6vqOhioCf04THs1SEwW121yxLaQB25h9WiGK4mwUcjqMoVlemZjowk2KDaUtlgO6F8CT0m23KB+txyO1+AEiwAFmPtAXw5kTsJ30fwSZwY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VA81lSIxg9w3f1AELJUtxgbm2r4t3slGIK9D59YttKw=;
 b=CfRu10DkZrhQpNXxeuy+sv9Vp5Wcy9NQtYrDZJu5RKIpTkMsG2ff9qRvTraOeoUrBmEV9ygaU4wAoigC9dw7ft8003Xl6jcyoJes4NEFf2lVmZ6VrOOWIhBLPD+46KygqHXmK2rgc9vxrp/Cn/85YranaTzoijPo/ceNVa3gP0HYeJ5lBj+Kuzi01akgWv7CwTMBIbMjntSz33Ig0LLirYk059Iiam3iHRXmv9nFHgweniWjb7YuvN7NASWwNz5WNMCthsnFPlo2DYRHsRiUbcbHjmPu5Nj1fg5CfU0+MEn8DzmnzP0yEHsTT4hAZ2aXYUVj+rwllH3Ivyba/r/u0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VA81lSIxg9w3f1AELJUtxgbm2r4t3slGIK9D59YttKw=;
 b=RRjCOjpd1ujs9iGUqfeWHL3i+8RfQzlay5U+st0QQDasskr6uIvGP8KNvn2VM7tLO0v5mNj3r+kC7kVlUoh/eaeuqA2KPT4DiNGDCCcu+q+GP1cI/0eCc+1RTFoi+13DqqKbxFTuvNy6b96TTDx7XybT5IrF0l2Kq5AIGoJzqbg=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB3669.namprd18.prod.outlook.com (2603:10b6:208:260::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 12:35:08 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 12:35:08 +0000
Date:   Tue, 10 Mar 2020 13:34:59 +0100
From:   Robert Richter <rrichter@marvell.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v3 03/32] irqchip/gic-v3: Workaround Cavium TX1 erratum
 when reading GICD_TYPER2
Message-ID: <20200310123459.d5i4bwrg7lq4fwmo@rric.localdomain>
References: <20191224111055.11836-1-maz@kernel.org>
 <20191224111055.11836-4-maz@kernel.org>
 <20200309221137.5pjh4vkc62ft3h2a@rric.localdomain>
 <b1b7db1f0e1c47b7d9e2dfbbe3409b77@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b7db1f0e1c47b7d9e2dfbbe3409b77@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR0301CA0008.eurprd03.prod.outlook.com
 (2603:10a6:3:76::18) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0301CA0008.eurprd03.prod.outlook.com (2603:10a6:3:76::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend Transport; Tue, 10 Mar 2020 12:35:05 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87f98d58-d58f-4df1-9372-08d7c4ef7771
X-MS-TrafficTypeDiagnostic: MN2PR18MB3669:
X-Microsoft-Antispam-PRVS: <MN2PR18MB366975A2944AF82DB1C27C77D9FF0@MN2PR18MB3669.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39850400004)(376002)(396003)(366004)(199004)(189003)(7696005)(1076003)(186003)(5660300002)(2906002)(6916009)(4326008)(16526019)(26005)(53546011)(956004)(6506007)(52116002)(7416002)(54906003)(9686003)(8936002)(81156014)(81166006)(6666004)(316002)(66946007)(86362001)(8676002)(66476007)(66556008)(55016002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3669;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqndTi5l/4p72G1I7dcR4UdI4hZNl/6L9qWACznB9dxgoOijD28+zUp/dN0uXrbpJMT1xXCdZ1MtMJ5YStd0m1bFycnd9yHP0rIAMojBfCFNho8ChvAoCvTRpXTfvuQZT7RrddEzPM9XgHtgG2eQHQlvx29c6jLYPEQy9vUUb269K9lRwJQVBQN3m5bSVVY63tGRoQSCVdElhdEDuOh/FeUBt4Vf1iU3Ql2dHfq56C6Aw0CUAcc8b0Sclwhy8tEWVbfpChv6axPGkknRLA2OzFw+EO/KeZ8PWXboBy0QcLMAu6E6A7R8CBGVWEgZoki1QBfIOuo2/OlZNU6rX77mSB/Q7U1iMB5y/vYAMPf3Dqkqb69aquwOcSjr0X53savg4MghEQreE3gSGjqsGNYTJiwRVLo4CbQYxDwe39c56TA4ainPL9o0GhOMD1O8OvJ9
X-MS-Exchange-AntiSpam-MessageData: 4JJIemrC9zA/KUUnUv1xosM5Cjw3Gj9XCZXKeVYrU5L1uzH9tMsy56tlopkPUr+q/4/sGjF+2OEy3uHED2PH0GHAk+t1Xtbh8awIBCLeondfD6hIjx+zcW+ZQ1dUVGz30uuE6pyBhOjpJ5o6cbzwbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f98d58-d58f-4df1-9372-08d7c4ef7771
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 12:35:07.8473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVUtdL5uzY1KJ4E6NwEeva8klUCCcejT+JBay7DSINUKQetU9qk8Jct9J1Vq7D0w2VwQQMUIJ1/PZ/bB+FysAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3669
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_06:2020-03-10,2020-03-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.20 11:41:09, Marc Zyngier wrote:
> On 2020-03-09 22:11, Robert Richter wrote:
> > On 24.12.19 11:10:26, Marc Zyngier wrote:

> > > @@ -1502,6 +1512,12 @@ static const struct gic_quirk gic_quirks[] = {
> > >  		.mask	= 0xffffffff,
> > >  		.init	= gic_enable_quirk_hip06_07,
> > >  	},
> > > +	{
> > > +		.desc	= "GICv3: Cavium TX1 GICD_TYPER2 erratum",
> > 
> > There is no errata number yet.
> 
> Please let me know when/if you obtain one.

Yes, will do.

> 
> > 
> > > +		.iidr	= 0xa100034c,
> > > +		.mask	= 0xfff00fff,
> > > +		.init	= gic_enable_quirk_tx1,
> > 
> > All TX1 and OcteonTX parts are affected, which is a0-a7 and b0-b7. So
> > the iidr/mask should be:
> > 
> > 		.iidr   = 0xa000034c,
> > 		.mask   = 0xe8f00fff,
> 
> Thanks, that's pretty helpful. I'll update the patch with these values
> and the corresponding description.

Thanks for the update.

> 
> > > +	},
> > >  	{
> > >  	}
> > >  };
> > > @@ -1577,7 +1593,12 @@ static int __init gic_init_bases(void __iomem
> > > *dist_base,
> > >  	pr_info("%d SPIs implemented\n", GIC_LINE_NR - 32);
> > >  	pr_info("%d Extended SPIs implemented\n", GIC_ESPI_NR);
> > > 
> > > -	gic_data.rdists.gicd_typer2 = readl_relaxed(gic_data.dist_base +
> > > GICD_TYPER2);
> > > +	/*
> > > +	 * ThunderX1 explodes on reading GICD_TYPER2, in total violation
> > > +	 * of the spec (which says that reserved addresses are RES0).
> > > +	 */
> > > +	if (!(gic_data.flags & FLAGS_WORKAROUND_GICD_TYPER2_TX1))
> > > +		gic_data.rdists.gicd_typer2 = readl_relaxed(gic_data.dist_base +
> > > GICD_TYPER2);
> > 
> > You already said that checking for ArchRev of GICD_PIDR2 isn't an
> > option here. Though, it could...
> 
> Once GICv3.2 starts using this register as well (because GICD_TYPER is
> already completely full), we'd have to fix it again. There is also the thing
> you hinted at in the other thread: TX1 will generate a SEA on every reserved
> GICD registers, so we may need to protect more than just this one over time,
> and maybe more than just in the distributor.

I am fine with both. And right, it would be possibly needed for other
ranges too.

Thanks,

-Robert

> 
> Thanks,
> 
>         M.
> -- 
> Jazz is not dead. It just smells funny...
