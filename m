Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEBEF1C00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 18:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbfKFRCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 12:02:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728777AbfKFRCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:02:10 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA6Grxs6110778
        for <linux-kernel@vger.kernel.org>; Wed, 6 Nov 2019 12:02:09 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w41wtgj60-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 12:02:09 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Wed, 6 Nov 2019 17:02:06 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Nov 2019 17:02:01 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA6H20Bx41681096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Nov 2019 17:02:00 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A1C74C046;
        Wed,  6 Nov 2019 17:02:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC2054C040;
        Wed,  6 Nov 2019 17:01:56 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.80.236.142])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  6 Nov 2019 17:01:56 +0000 (GMT)
Date:   Wed, 6 Nov 2019 09:01:53 -0800
From:   Ram Pai <linuxram@us.ibm.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
        david@gibson.dropbear.id.au, mpe@ellerman.id.au, paulus@ozlabs.org,
        mdroth@linux.vnet.ibm.com, hch@lst.de, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, ram.n.pai@gmail.com,
        cai@lca.pw, tglx@linutronix.de, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1572902923-8096-1-git-send-email-linuxram@us.ibm.com>
 <1572902923-8096-2-git-send-email-linuxram@us.ibm.com>
 <af0a236f-37b2-ee16-0ebd-576b4e12d8cd@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af0a236f-37b2-ee16-0ebd-576b4e12d8cd@ozlabs.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19110617-4275-0000-0000-0000037B60E4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110617-4276-0000-0000-0000388EAFD6
Message-Id: <20191106170153.GC5201@oc0525413822.ibm.com>
Subject: RE: [RFC v1 1/2] powerpc/pseries/iommu: Share the per-cpu TCE page with the
 hypervisor.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=48 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911060163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 12:58:50PM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 05/11/2019 08:28, Ram Pai wrote:
> > The hypervisor needs to access the contents of the page holding the TCE
> > entries while setting up the TCE entries in the IOMMU's TCE table. For
> > SecureVMs, since this page is encrypted, the hypervisor cannot access
> > valid entries. Share the page with the hypervisor. This ensures that the
> > hypervisor sees the valid entries.
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/platforms/pseries/iommu.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index 8d9c2b1..07f0847 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -37,6 +37,7 @@
> >  #include <asm/mmzone.h>
> >  #include <asm/plpar_wrappers.h>
> >  #include <asm/svm.h>
> > +#include <asm/ultravisor.h>
> >  
> >  #include "pseries.h"
> >  
> > @@ -179,6 +180,19 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
> >  
> >  static DEFINE_PER_CPU(__be64 *, tce_page);
> >  
> > +/*
> > + * Allocate a tce page.  If secure VM, share the page with the hypervisor.
> > + */
> > +static __be64 *alloc_tce_page(void)
> > +{
> > +	__be64 *tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
> > +
> > +	if (tcep && is_secure_guest())
> > +		uv_share_page(PHYS_PFN(__pa(tcep)), 1);
> 
> 
> There is no matching unshare in this patch.

The page is allocated and shared, and stays that way for the life of the
kernel. It is not explicitly unshared or freed.  It is however
implicitly unshared by the guest kernel, through a UV_UNSHARE_ALL_PAGES ucall
when the guest kernel reboots. And it also gets implicitly unshared by
the Ultravisor/Hypervisor, if the SVM abruptly terminates.

> 
> 
> > +
> > +	return tcep;
> > +}
> > +
> >  static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
> >  				     long npages, unsigned long uaddr,
> >  				     enum dma_data_direction direction,
> > @@ -206,8 +220,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
> >  	 * from iommu_alloc{,_sg}()
> >  	 */
> >  	if (!tcep) {
> > -		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
> > -		/* If allocation fails, fall back to the loop implementation */
> > +		tcep = alloc_tce_page();
> >  		if (!tcep) {
> >  			local_irq_restore(flags);
> >  			return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
> > @@ -391,6 +404,7 @@ static int tce_clearrange_multi_pSeriesLP(unsigned long start_pfn,
> >  	return rc;
> >  }
> >  
> > +
> 
> Unrelated.

yes. will fix it.

Thanks,
RP

