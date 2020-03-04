Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8021B17896D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 05:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCDEQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 23:16:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgCDEQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 23:16:06 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0244F0eZ085193
        for <linux-kernel@vger.kernel.org>; Tue, 3 Mar 2020 23:16:04 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yhs0thd9v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 23:16:04 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Wed, 4 Mar 2020 04:16:02 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Mar 2020 04:15:56 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0244Evro45351336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Mar 2020 04:14:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 520F3A405B;
        Wed,  4 Mar 2020 04:15:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADE1EA4054;
        Wed,  4 Mar 2020 04:15:54 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Mar 2020 04:15:54 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id CF1D6A023A;
        Wed,  4 Mar 2020 15:15:49 +1100 (AEDT)
Subject: Re: [PATCH v3 13/27] powerpc/powernv/pmem: Read the capability
 registers & wait for device ready
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
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
Date:   Wed, 04 Mar 2020 15:15:53 +1100
In-Reply-To: <3d2de7c1-ee95-ed6c-0346-4a1d20a0b75e@linux.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
         <20200221032720.33893-14-alastair@au1.ibm.com>
         <3d2de7c1-ee95-ed6c-0346-4a1d20a0b75e@linux.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030404-0012-0000-0000-0000038CF424
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030404-0013-0000-0000-000021C9ACE1
Message-Id: <b1157d7a777049d417818884eed5e027b1008f7e.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_08:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-02 at 18:51 +0100, Frederic Barrat wrote:
> 
> Le 21/02/2020 à 04:27, Alastair D'Silva a écrit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > This patch reads timeouts & firmware version from the controller,
> > and
> > uses those timeouts to wait for the controller to report that it is
> > ready
> > before handing the memory over to libnvdimm.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >   arch/powerpc/platforms/powernv/pmem/Makefile  |  2 +-
> >   arch/powerpc/platforms/powernv/pmem/ocxl.c    | 92
> > +++++++++++++++++++
> >   .../platforms/powernv/pmem/ocxl_internal.c    | 19 ++++
> >   .../platforms/powernv/pmem/ocxl_internal.h    | 24 +++++
> >   4 files changed, 136 insertions(+), 1 deletion(-)
> >   create mode 100644
> > arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
> > 
> > diff --git a/arch/powerpc/platforms/powernv/pmem/Makefile
> > b/arch/powerpc/platforms/powernv/pmem/Makefile
> > index 1c55c4193175..4ceda25907d4 100644
> > --- a/arch/powerpc/platforms/powernv/pmem/Makefile
> > +++ b/arch/powerpc/platforms/powernv/pmem/Makefile
> > @@ -4,4 +4,4 @@ ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
> >   
> >   obj-$(CONFIG_OCXL_PMEM) += ocxlpmem.o
> >   
> > -ocxlpmem-y := ocxl.o
> > +ocxlpmem-y := ocxl.o ocxl_internal.o
> > diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl.c
> > b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> > index 3c4eeb5dcc0f..431212c9f0cc 100644
> > --- a/arch/powerpc/platforms/powernv/pmem/ocxl.c
> > +++ b/arch/powerpc/platforms/powernv/pmem/ocxl.c
> > @@ -8,6 +8,7 @@
> >   
> >   #include <linux/module.h>
> >   #include <misc/ocxl.h>
> > +#include <linux/delay.h>
> >   #include <linux/ndctl.h>
> >   #include <linux/mm_types.h>
> >   #include <linux/memory_hotplug.h>
> > @@ -215,6 +216,36 @@ static int register_lpc_mem(struct ocxlpmem
> > *ocxlpmem)
> >   	return 0;
> >   }
> >   
> > +/**
> > + * is_usable() - Is a controller usable?
> > + * @ocxlpmem: the device metadata
> > + * @verbose: True to log errors
> > + * Return: true if the controller is usable
> > + */
> > +static bool is_usable(const struct ocxlpmem *ocxlpmem, bool
> > verbose)
> > +{
> > +	u64 chi = 0;
> > +	int rc = ocxlpmem_chi(ocxlpmem, &chi);
> > +
> > +	if (rc < 0)
> > +		return false;
> > +
> > +	if (!(chi & GLOBAL_MMIO_CHI_CRDY)) {
> > +		if (verbose)
> > +			dev_err(&ocxlpmem->dev, "controller is not
> > ready.\n");
> > +		return false;
> > +	}
> > +
> > +	if (!(chi & GLOBAL_MMIO_CHI_MA)) {
> > +		if (verbose)
> > +			dev_err(&ocxlpmem->dev,
> > +				"controller does not have memory
> > available.\n");
> > +		return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> >   /**
> >    * allocate_minor() - Allocate a minor number to use for an
> > OpenCAPI pmem device
> >    * @ocxlpmem: the device metadata
> > @@ -328,6 +359,48 @@ static void ocxlpmem_remove(struct pci_dev
> > *pdev)
> >   	}
> >   }
> >   
> > +/**
> > + * read_device_metadata() - Retrieve config information from the
> > AFU and save it for future use
> > + * @ocxlpmem: the device metadata
> > + * Return: 0 on success, negative on failure
> > + */
> > +static int read_device_metadata(struct ocxlpmem *ocxlpmem)
> > +{
> > +	u64 val;
> > +	int rc;
> > +
> > +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> > GLOBAL_MMIO_CCAP0,
> > +				     OCXL_LITTLE_ENDIAN, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	ocxlpmem->scm_revision = val & 0xFFFF;
> > +	ocxlpmem->read_latency = (val >> 32) & 0xFF;
> > +	ocxlpmem->readiness_timeout = (val >> 48) & 0x0F;
> > +	ocxlpmem->memory_available_timeout = val >> 52;
> > +
> > +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> > GLOBAL_MMIO_CCAP1,
> > +				     OCXL_LITTLE_ENDIAN, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	ocxlpmem->max_controller_dump_size = val & 0xFFFFFFFF;
> > +
> > +	// Extract firmware version text
> > +	rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> > GLOBAL_MMIO_FWVER,
> > +				     OCXL_HOST_ENDIAN, (u64 *)ocxlpmem-
> > >fw_version);
> > +	if (rc)
> > +		return rc;
> > +
> > +	ocxlpmem->fw_version[8] = '\0';
> > +
> > +	dev_info(&ocxlpmem->dev,
> > +		 "Firmware version '%s' SCM revision %d:%d\n",
> > ocxlpmem->fw_version,
> > +		 ocxlpmem->scm_revision >> 4, ocxlpmem->scm_revision &
> > 0x0F);
> > +
> > +	return 0;
> > +}
> > +
> >   /**
> >    * probe_function0() - Set up function 0 for an OpenCAPI
> > persistent memory device
> >    * This is important as it enables templates higher than 0 across
> > all other functions,
> > @@ -368,6 +441,7 @@ static int probe(struct pci_dev *pdev, const
> > struct pci_device_id *ent)
> >   {
> >   	struct ocxlpmem *ocxlpmem;
> >   	int rc;
> > +	u16 elapsed, timeout;
> >   
> >   	if (PCI_FUNC(pdev->devfn) == 0)
> >   		return probe_function0(pdev);
> > @@ -422,6 +496,24 @@ static int probe(struct pci_dev *pdev, const
> > struct pci_device_id *ent)
> >   		goto err;
> >   	}
> >   
> > +	if (read_device_metadata(ocxlpmem)) {
> > +		dev_err(&pdev->dev, "Could not read metadata\n");
> 
> 
> Need to set rc
> 
> 
Whoops :)

> 
> > +		goto err;
> > +	}
> > +
> > +	elapsed = 0;
> > +	timeout = ocxlpmem->readiness_timeout + ocxlpmem-
> > >memory_available_timeout;
> > +	while (!is_usable(ocxlpmem, false)) {
> > +		if (elapsed++ > timeout) {
> > +			dev_warn(&ocxlpmem->dev, "OpenCAPI Persistent
> > Memory ready timeout.\n");
> > +			(void)is_usable(ocxlpmem, true);
> 
> I guess that extra call to is_usable() is just to log the cause of
> the 
> error. However, with some bad luck, the call could now succeed.
> 

Yeah, that's pretty ugly, I'll re-engineer it.

> 
>    Fred
> 
> 
> > +			rc = -ENXIO;
> > +			goto err;
> > +		}
> > +
> > +		msleep(1000);
> > +	}
> > +
> >   	rc = register_lpc_mem(ocxlpmem);
> >   	if (rc) {
> >   		dev_err(&pdev->dev, "Could not register OpenCAPI
> > persistent memory with libnvdimm\n");
> > diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
> > b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
> > new file mode 100644
> > index 000000000000..617ca943b1b8
> > --- /dev/null
> > +++ b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
> > @@ -0,0 +1,19 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +// Copyright 2019 IBM Corp.
> > +
> > +#include <misc/ocxl.h>
> > +#include <linux/delay.h>
> > +#include "ocxl_internal.h"
> > +
> > +int ocxlpmem_chi(const struct ocxlpmem *ocxlpmem, u64 *chi)
> > +{
> > +	u64 val;
> > +	int rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu,
> > GLOBAL_MMIO_CHI,
> > +					 OCXL_LITTLE_ENDIAN, &val);
> > +	if (rc)
> > +		return rc;
> > +
> > +	*chi = val;
> > +
> > +	return 0;
> > +}
> > diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> > b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> > index 9cf3e42750e7..ba0301533d00 100644
> > --- a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> > +++ b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
> > @@ -97,4 +97,28 @@ struct ocxlpmem {
> >   	void *metadata_addr;
> >   	struct resource pmem_res;
> >   	struct nd_region *nd_region;
> > +	char fw_version[8+1];
> > +
> > +	u32 max_controller_dump_size;
> > +	u16 scm_revision; // major/minor
> > +	u8 readiness_timeout;  /* The worst case time (in seconds) that
> > the host shall
> > +				* wait for the controller to become
> > operational following a reset (CHI.CRDY).
> > +				*/
> > +	u8 memory_available_timeout;   /* The worst case time (in
> > seconds) that the host shall
> > +					* wait for memory to become
> > available following a reset (CHI.MA).
> > +					*/
> > +
> > +	u16 read_latency; /* The nominal measure of latency (in
> > nanoseconds)
> > +			   * associated with an unassisted read of a
> > memory block.
> > +			   * This represents the capability of the raw
> > media technology without assistance
> > +			   */
> >   };
> > +
> > +/**
> > + * ocxlpmem_chi() - Get the value of the CHI register
> > + * @ocxlpmem: the device metadata
> > + * @chi: returns the CHI value
> > + *
> > + * Returns 0 on success, negative on error
> > + */
> > +int ocxlpmem_chi(const struct ocxlpmem *ocxlpmem, u64 *chi);
> > 
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

