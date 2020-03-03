Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B74177C9E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 18:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgCCRBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 12:01:17 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47486 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgCCRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:01:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023GsOhe127300;
        Tue, 3 Mar 2020 17:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=YHBXFBSktgQjLaRBFzopaXSA2ylIlKhMSsg5ZAsockc=;
 b=jU4quvUitJTwIwf5TegZ6FvIOBcS7nc9vzYDmvRycgAyYS2EIZXF4yJGEcLYrT3KdvuV
 jhRwojj9cPlXqOkY6n5kvVVh5G0J0mOX6h2eaYotu+Vqjpw4ByxwHjDLm4fFJo61pLRo
 H15BnFMK6Nmmx9uaHL2jKDU5x/l8JQAbgTk30omrZLmb+HN2S+d72h7gTcX1QAQI+pB+
 taCAcpWazu99ZdDj9UPHFQGKFfTGOwvQsMb6orDhb+8sLl+XznEFUvdYGO1dnPpJfAxg
 w/EOHLbWP8RmoSrRnwywhAKt7G3HJdQx4RcbxkUHJw8pUKTOr1XrBUdm//7T8wTxEqYK NQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yffwqrknh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 17:00:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 023GmTDr053801;
        Tue, 3 Mar 2020 17:00:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2yg1p4vf44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Mar 2020 17:00:16 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 023H0AJR001636;
        Tue, 3 Mar 2020 17:00:11 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Mar 2020 09:00:10 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 7873A6A0129; Tue,  3 Mar 2020 12:03:53 -0500 (EST)
Date:   Tue, 3 Mar 2020 12:03:53 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>, hch@lst.de,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, luto@kernel.org, peterz@infradead.org,
        dave.hansen@linux-intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20200303170353.GC31627@char.us.oracle.com>
References: <20191209231346.5602-1-Ashish.Kalra@amd.com>
 <20191220015245.GA7010@localhost.localdomain>
 <20200121200947.GA24884@ashkalra_ubuntu_server>
 <20200121205403.GC75374@Konrads-MacBook-Pro.local>
 <20200124230008.GA1565@ashkalra_ubuntu_server>
 <20200204193500.GA15564@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204193500.GA15564@ashkalra_ubuntu_server>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 07:35:00PM +0000, Ashish Kalra wrote:
> Hello Konrad,
> 
> Looking fwd. to your feedback regarding support of other memory
> encryption architectures such as Power, S390, etc.
> 
> Thanks,
> Ashish
> 
> On Fri, Jan 24, 2020 at 11:00:08PM +0000, Ashish Kalra wrote:
> > On Tue, Jan 21, 2020 at 03:54:03PM -0500, Konrad Rzeszutek Wilk wrote:
> > > > 
> > > > Additional memory calculations based on # of PCI devices and
> > > > their memory ranges will make it more complicated with so
> > > > many other permutations and combinations to explore, it is
> > > > essential to keep this patch as simple as possible by 
> > > > adjusting the bounce buffer size simply by determining it
> > > > from the amount of provisioned guest memory.
> > >> 
> > >> Please rework the patch to:
> > >> 
> > >>  - Use a log solution instead of the multiplication.
> > >>    Feel free to cap it at a sensible value.
> > 
> > Ok.
> > 
> > >> 
> > >>  - Also the code depends on SWIOTLB calling in to the
> > >>    adjust_swiotlb_default_size which looks wrong.
> > >> 
> > >>    You should not adjust io_tlb_nslabs from swiotlb_size_or_default.
> > 
> > >>    That function's purpose is to report a value.
> > >> 
> > >>  - Make io_tlb_nslabs be visible outside of the SWIOTLB code.
> > >> 
> > >>  - Can you utilize the IOMMU_INIT APIs and have your own detect which would
> > >>    modify the io_tlb_nslabs (and set swiotbl=1?).
> > 
> > This seems to be a nice option, but then IOMMU_INIT APIs are
> > x86-specific and this swiotlb buffer size adjustment is also needed
> > for other memory encryption architectures like Power, S390, etc.

Oh dear. That I hadn't considered.
> > 
> > >> 
> > >>    Actually you seem to be piggybacking on pci_swiotlb_detect_4gb - so
> > >>    perhaps add in this code ? Albeit it really should be in it's own
> > >>    file, not in arch/x86/kernel/pci-swiotlb.c
> > 
> > Actually, we piggyback on pci_swiotlb_detect_override which sets
> > swiotlb=1 as x86_64_start_kernel() and invocation of sme_early_init()
> > forces swiotlb on, but again this is all x86 architecture specific.

Then it looks like the best bet is to do it from within swiotlb_init?
We really can't do it from swiotlb_size_or_default - that function
should just return a value and nothing else.

> > 
> > Thanks,
> > Ashish
