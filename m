Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFED1163769
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 00:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgBRXod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 18:44:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8792 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbgBRXod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:44:33 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01INhn28184196
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:44:32 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6cbb2s76-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:44:32 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Tue, 18 Feb 2020 23:44:29 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Feb 2020 23:44:21 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01INiKuw32571890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 23:44:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE065A405B;
        Tue, 18 Feb 2020 23:44:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B470A4054;
        Tue, 18 Feb 2020 23:44:20 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Feb 2020 23:44:20 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A1042A00DF;
        Wed, 19 Feb 2020 10:44:15 +1100 (AEDT)
Subject: Re: [PATCH v2 05/27] powerpc: Map & release OpenCAPI LPC memory
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Date:   Wed, 19 Feb 2020 10:44:18 +1100
In-Reply-To: <85e5a3d4-bac2-a8fc-8fc7-865be539dc3c@linux.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
         <20191203034655.51561-6-alastair@au1.ibm.com>
         <85e5a3d4-bac2-a8fc-8fc7-865be539dc3c@linux.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021823-0016-0000-0000-000002E8165D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021823-0017-0000-0000-0000334B2C77
Message-Id: <91440c75bacf29ac7423e67b71199695ebf636d0.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_08:2020-02-18,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=2 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 mlxscore=0 mlxlogscore=667 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-14 at 12:09 +0100, Frederic Barrat wrote:
> 
> Le 03/12/2019 à 04:46, Alastair D'Silva a écrit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > This patch adds platform support to map & release LPC memory.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >   arch/powerpc/include/asm/pnv-ocxl.h   |  2 ++
> >   arch/powerpc/platforms/powernv/ocxl.c | 42
> > +++++++++++++++++++++++++++
> >   2 files changed, 44 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/pnv-ocxl.h
> > b/arch/powerpc/include/asm/pnv-ocxl.h
> > index 7de82647e761..f8f8ffb48aa8 100644
> > --- a/arch/powerpc/include/asm/pnv-ocxl.h
> > +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> > @@ -32,5 +32,7 @@ extern int pnv_ocxl_spa_remove_pe_from_cache(void
> > *platform_data, int pe_handle)
> >   
> >   extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
> >   extern void pnv_ocxl_free_xive_irq(u32 irq);
> > +extern u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64
> > size);
> > +extern void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev);
> >   
> >   #endif /* _ASM_PNV_OCXL_H */
> > diff --git a/arch/powerpc/platforms/powernv/ocxl.c
> > b/arch/powerpc/platforms/powernv/ocxl.c
> > index 8c65aacda9c8..b56a48daf48c 100644
> > --- a/arch/powerpc/platforms/powernv/ocxl.c
> > +++ b/arch/powerpc/platforms/powernv/ocxl.c
> > @@ -475,6 +475,48 @@ void pnv_ocxl_spa_release(void *platform_data)
> >   }
> >   EXPORT_SYMBOL_GPL(pnv_ocxl_spa_release);
> >   
> > +u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size)
> > +{
> > +	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> > +	struct pnv_phb *phb = hose->private_data;
> > +	u32 bdfn = pci_dev_id(pdev);
> > +	__be64 base_addr_be64;
> > +	u64 base_addr;
> > +	int rc;
> > +
> > +	rc = opal_npu_mem_alloc(phb->opal_id, bdfn, size,
> > &base_addr_be64);
> > +	if (rc) {
> > +		dev_warn(&pdev->dev,
> > +			 "OPAL could not allocate LPC memory, rc=%d\n",
> > rc);
> > +		return 0;
> > +	}
> > +
> > +	base_addr = be64_to_cpu(base_addr_be64);
> > +
> > +	rc = check_hotplug_memory_addressable(base_addr >> PAGE_SHIFT,
> > +					      size >> PAGE_SHIFT);
> 
> check_hotplug_memory_addressable() is only declared if 
> CONFIG_MEMORY_HOTPLUG_SPARSE is selected.
> I think we also need a #ifdef here.
> 

Agreed. I think that since any actual use of the memory is going to be
dependant on both hotplug & sparse, moving the ifdef to wrap the
functions & declarations makes sense.


>    Fred
> 
> 
> > +	if (rc)
> > +		return 0;
> > +
> > +	return base_addr;
> > +}
> > +EXPORT_SYMBOL_GPL(pnv_ocxl_platform_lpc_setup);
> > +
> > +void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev)
> > +{
> > +	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> > +	struct pnv_phb *phb = hose->private_data;
> > +	u32 bdfn = pci_dev_id(pdev);
> > +	int rc;
> > +
> > +	rc = opal_npu_mem_release(phb->opal_id, bdfn);
> > +	if (rc)
> > +		dev_warn(&pdev->dev,
> > +			 "OPAL reported rc=%d when releasing LPC
> > memory\n", rc);
> > +}
> > +EXPORT_SYMBOL_GPL(pnv_ocxl_platform_lpc_release);
> > +
> > +
> >   int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int
> > pe_handle)
> >   {
> >   	struct spa_data *data = (struct spa_data *) platform_data;
> > 
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

