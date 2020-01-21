Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 303D01445A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 21:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAUUJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 15:09:58 -0500
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:6134
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbgAUUJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 15:09:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNYAksSQ/a1DjbhCeDLSTqkvNbwhipSIaKoj6evXs9S4dHNixxywnlsJ5lzFwia89ncntKa8aylR7imPFzOM6AAkia1yc4McD+uyysBJOookKbmrsMXBbN5CAPsTqC3NPHd5NIewYdb9gcVKMxS+eAqrsiICI/evABU8vz0hlJphynnJCwgderM6ryoBBAskqhs3Yt7mC3tHgbKnuS3PW7nQJiqcmck8PXMGw8S8IH5iBLCz/asIiLWRUApOyKakpZ/Xzxkn1Uc0N9BhEMhDIN/4QUhGkCYz/ijd9DYx1Lj9M3ZSVIXRn2onzBuNc1QKldtMLF4ZMCMlpDRAuWUhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI0cBqZKuGRuC4ia8Flphx2so19JCK0sC27NUbcrKNc=;
 b=NkK1bPbtghSml9i1XNZ4pL3V7wZ/p+Ev9w7OSLln0YhtHrseMXB8ncaBqIs57ILn29GTSVpqC7NuQJSmzzjYzKuyBt573M4Y8KcBjporJKpKxhOHs754nfXueO/cqqi4PWDd4Gu+6BNxbRS2JzqLDfsXV2/ZgdinQclgpfIVSSKUPW9u01LorEM0H3tvYR3575C7GyoEasxTdBx9+evhQScANF1k7ZmI0qjQEZ3DYCOuWaUIBuEr557oDGR7i+TP52sRv/AzwcHHK1u9xvSTjc/1WDjJWAbGjBYcMpM0sN8T7Q8URR1QZpxNEl+AjRpmokkQ80JqIArDs0DRdFcdZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI0cBqZKuGRuC4ia8Flphx2so19JCK0sC27NUbcrKNc=;
 b=VSLj6DYTLrzyrhSIHOpPZpqUXW4x7n+DVeYUtTPz86ghhSYdc2dm3D/2T9ftM5YpZnWR8L+wt4w2BCkp6l6BZDaZ3Fl1L398tVvLfvG6R1oyOl9NygPL9pm8YoJZubkZPNNmwiWPHv8x9DRMmBGBcbxyKibwdBhnUDj8GNQjTCw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ashish.Kalra@amd.com; 
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (52.132.196.33) by
 SN1SPR01MB0001.namprd12.prod.outlook.com (52.132.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 20:09:55 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::fd48:9921:dd63:c6e1]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::fd48:9921:dd63:c6e1%7]) with mapi id 15.20.2644.026; Tue, 21 Jan 2020
 20:09:55 +0000
Date:   Tue, 21 Jan 2020 20:09:47 +0000
From:   Ashish Kalra <ashish.kalra@amd.com>
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     hch@lst.de, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        konrad.wilk@oracle.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20200121200947.GA24884@ashkalra_ubuntu_server>
References: <20191209231346.5602-1-Ashish.Kalra@amd.com>
 <20191220015245.GA7010@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220015245.GA7010@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: DM3PR12CA0136.namprd12.prod.outlook.com
 (2603:10b6:0:51::32) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
MIME-Version: 1.0
Received: from ashkalra_ubuntu_server (165.204.77.1) by DM3PR12CA0136.namprd12.prod.outlook.com (2603:10b6:0:51::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Tue, 21 Jan 2020 20:09:53 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bcf013a8-e6ee-4958-0d49-08d79eade199
X-MS-TrafficTypeDiagnostic: SN1SPR01MB0001:|SN1SPR01MB0001:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1SPR01MB000148DD9882F0F629A111508E0D0@SN1SPR01MB0001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(86362001)(4326008)(33716001)(8676002)(81156014)(26005)(6916009)(9686003)(55016002)(186003)(16526019)(5660300002)(2906002)(33656002)(316002)(956004)(52116002)(6666004)(478600001)(6496006)(44832011)(81166006)(66476007)(8936002)(66946007)(1076003)(7416002)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1SPR01MB0001;H:SN1PR12MB2528.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ie4qgwXp1ydlBdCqOrXhC2LO/SizoSAEnRpLgf4ZyuIsQIcTS3Lb1DM9M0y5d66Nb8AK3klFdJkFDA0IgluhcBs3tieHqOooSyzE06PAOKqFYJhg+teDZRrwVTVfg+skk8IW65BnpfLdUD5ho+IZGeuuh8lHynnwWi2fj62y6E4PfETvEtfNIZ7/gvzvzaJK2De4DdQxXNYw0sSK8eMVLL2eEBC8/YGOm+7UiyXFYUMcZ5HjysZCcXlSXPFPpkkq5EG2S0Eq6HjGn+58vS0+t6+XAQ9pVfqlZGqsYMFPAZfpiiH1m8/0BMhSmuv3MIktGVula1qKGl4TgpQpQVetofOcF/3+rNAI7Yb9erEPva9oqJxD/Ub+668nrSW4D+/tlrWa84m+IrdQwMf2QkZn9PJkDjL8wHFAT+U1inCDXBvehM1bEq10rJi3FMb9NR3l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf013a8-e6ee-4958-0d49-08d79eade199
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 20:09:55.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O44NrDU3q8CMjr8EonvHqIQkwyz6jRmFHFqmfFmZ3ARI6L4j0g47engoxBXwYVaGIUaEZthwXkf9nUnSyB9Lpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1SPR01MB0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 08:52:45PM -0500, Konrad Rzeszutek Wilk wrote:
> On Mon, Dec 09, 2019 at 11:13:46PM +0000, Ashish Kalra wrote:
> > From: Ashish Kalra <ashish.kalra@amd.com>
> > 
> > For SEV, all DMA to and from guest has to use shared
> > (un-encrypted) pages. SEV uses SWIOTLB to make this happen
> > without requiring changes to device drivers. However,
> > depending on workload being run, the default 64MB of SWIOTLB
> > might not be enough and SWIOTLB may run out of buffers to
> > use for DMA, resulting in I/O errors.
> > 
> > Increase the default size of SWIOTLB for SEV guests using
> > a minimum value of 128MB and a maximum value of 512MB,
> > determining on amount of provisioned guest memory.
> > 
> > The SWIOTLB default size adjustment is added as an
> > architecture specific interface/callback to allow
> > architectures such as those supporting memory encryption
> > to adjust/expand SWIOTLB size for their use.
> 
> What if this was made dynamic? That is if there is a memory
> pressure you end up expanding the SWIOTLB dynamically?

As of now we want to keep it as simple as possible and more
like a stop-gap arrangement till something more elegant is
available.

> 
>> Also is it worth doing this calculation based on memory or
>> more on the # of PCI devices + their MMIO ranges size?

Additional memory calculations based on # of PCI devices and
their memory ranges will make it more complicated with so
many other permutations and combinations to explore, it is
essential to keep this patch as simple as possible by 
adjusting the bounce buffer size simply by determining it
from the amount of provisioned guest memory.

Thanks,
Ashish
