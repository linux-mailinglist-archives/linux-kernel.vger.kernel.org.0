Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF83CF4019
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 06:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfKHFtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 00:49:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbfKHFti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:49:38 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA85kkNT071812
        for <linux-kernel@vger.kernel.org>; Fri, 8 Nov 2019 00:49:37 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w5122a28a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 00:49:37 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Fri, 8 Nov 2019 05:49:34 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Nov 2019 05:49:30 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA85ms8x28180780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 05:48:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 646A311C04A;
        Fri,  8 Nov 2019 05:49:29 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4DA311C04C;
        Fri,  8 Nov 2019 05:49:25 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.80.217.215])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Nov 2019 05:49:25 +0000 (GMT)
Date:   Thu, 7 Nov 2019 21:49:22 -0800
From:   Ram Pai <linuxram@us.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
        david@gibson.dropbear.id.au, paulus@ozlabs.org,
        mdroth@linux.vnet.ibm.com, hch@lst.de, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, ram.n.pai@gmail.com,
        aik@ozlabs.ru, cai@lca.pw, tglx@linutronix.de,
        bauerman@linux.ibm.com, linux-kernel@vger.kernel.org
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1572902923-8096-1-git-send-email-linuxram@us.ibm.com>
 <1572902923-8096-2-git-send-email-linuxram@us.ibm.com>
 <1572902923-8096-3-git-send-email-linuxram@us.ibm.com>
 <87k18c56ej.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k18c56ej.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19110805-0016-0000-0000-000002C1CC24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110805-0017-0000-0000-0000332351B9
Message-Id: <20191108054922.GH5201@oc0525413822.ibm.com>
Subject: RE: [RFC v1 2/2] powerpc/pseries/iommu: Use dma_iommu_ops for Secure VMs
 aswell.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=937 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 09:26:28PM +1100, Michael Ellerman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> > This enables IOMMU support for pseries Secure VMs.
> 
> Can you give us some more explanation please?

Yes. Will do. 

The simple explanation is -- it was a mistake. We should 
not have disabled IOMMU ops for secure guests. Though it enabled
us to use virtio devices, with the help of some additional patches to
the virtio subsystem; in hindsight, we should not have disabled IOMMU
ops for secure VMs  :-(. 

RP



> 
> This is basically a revert of commit:
>   edea902c1c1e ("powerpc/pseries/iommu: Don't use dma_iommu_ops on secure guests")
> 
> But neglects to remove the now unnecessary include of svm.h.
> 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index 07f0847..189717b 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -1333,15 +1333,7 @@ void iommu_init_early_pSeries(void)
> >  	of_reconfig_notifier_register(&iommu_reconfig_nb);
> >  	register_memory_notifier(&iommu_mem_nb);
> >  
> > -	/*
> > -	 * Secure guest memory is inacessible to devices so regular DMA isn't
> > -	 * possible.
> > -	 *
> > -	 * In that case keep devices' dma_map_ops as NULL so that the generic
> > -	 * DMA code path will use SWIOTLB to bounce buffers for DMA.
> 
> Please explain what has changed to make this no longer necessary.
> 
> cheers
> 
> > -	 */
> > -	if (!is_secure_guest())
> > -		set_pci_dma_ops(&dma_iommu_ops);
> > +	set_pci_dma_ops(&dma_iommu_ops);
> >  }
> >  
> >  static int __init disable_multitce(char *str)
> > -- 
> > 1.8.3.1

-- 
Ram Pai

