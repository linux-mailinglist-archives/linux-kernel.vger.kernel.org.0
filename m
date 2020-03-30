Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB198197DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 15:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgC3N6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 09:58:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54390 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgC3N63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:58:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02UDdY7V026505;
        Mon, 30 Mar 2020 13:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ydgsqhArEdAPBPPymxIJ1axqtgIEVoHgn8s/XOMQLYI=;
 b=JIk0r7M5s9Uq99WtXRS46PnzFnilicuzjGFxo7Wa0XZSJ0x/c3rHtO/pjGsOBUC1vNZp
 8ZPhECpjPZUXulqaWvnZOBVdq8pVEMFcnenOL9fhdG4SbDVnJeztACxMvWLCUm/cdJBx
 LIbcDxNuv4yQquxZKwwqkFaBbLqciRdz1DAt1rIWtDbO8ZwpSfRQRaGD6YkiTWno6Bph
 Nme82sUXLu7/vqJ22se8dHScQzAf/e1UYNUwcR0/odqg2wNMUFKy0x7g+oNtc3O4C67v
 ftXBmYr4dBya+d5fGBTzwXh07pcY7xK6WZc2fYTh3Z6BRzsHJnkXp6nOL+kVF+jvK22S wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 303ceusq76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 13:40:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02UDauMf050806;
        Mon, 30 Mar 2020 13:40:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 302gc9bhcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 13:40:05 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02UDe0El004741;
        Mon, 30 Mar 2020 13:40:00 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Mar 2020 06:39:59 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id D84776A00D7; Mon, 30 Mar 2020 09:40:04 -0400 (EDT)
Date:   Mon, 30 Mar 2020 09:40:04 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Kairui Song <kasong@redhat.com>, anthony.yznaga@oracle.com,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>
Cc:     Dave Young <dyoung@redhat.com>, Alexander Graf <graf@amazon.com>,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dwmw@amazon.com,
        benh@amazon.com, Jan Kiszka <jan.kiszka@siemens.com>,
        alcioa@amazon.com, aggh@amazon.com, aagch@amazon.com,
        dhr@amazon.com, Laszlo Ersek <lersek@redhat.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        brijesh.singh@amd.com,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
Message-ID: <20200330134004.GA31026@char.us.oracle.com>
References: <20200326162922.27085-1-graf@amazon.com>
 <20200328115733.GA67084@dhcp-128-65.nay.redhat.com>
 <CACPcB9d_Pz9SRhSsRzqygRR6waV7r8MnGcCP952svnZtpFaxnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPcB9d_Pz9SRhSsRzqygRR6waV7r8MnGcCP952svnZtpFaxnQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9575 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003300130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9575 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003300130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 02:06:01PM +0800, Kairui Song wrote:
> On Sat, Mar 28, 2020 at 7:57 PM Dave Young <dyoung@redhat.com> wrote:
> >
> > On 03/26/20 at 05:29pm, Alexander Graf wrote:
> > > The swiotlb is a very convenient fallback mechanism for bounce buffering of
> > > DMAable data. It is usually used for the compatibility case where devices
> > > can only DMA to a "low region".
> > >
> > > However, in some scenarios this "low region" may be bound even more
> > > heavily. For example, there are embedded system where only an SRAM region
> > > is shared between device and CPU. There are also heterogeneous computing
> > > scenarios where only a subset of RAM is cache coherent between the
> > > components of the system. There are partitioning hypervisors, where
> > > a "control VM" that implements device emulation has limited view into a
> > > partition's memory for DMA capabilities due to safety concerns.
> > >
> > > This patch adds a command line driven mechanism to move all DMA memory into
> > > a predefined shared memory region which may or may not be part of the
> > > physical address layout of the Operating System.
> > >
> > > Ideally, the typical path to set this configuration would be through Device
> > > Tree or ACPI, but neither of the two mechanisms is standardized yet. Also,
> > > in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
> > > instead configure the system purely through kernel command line options.
> > >
> > > I'm sure other people will find the functionality useful going forward
> > > though and extend it to be triggered by DT/ACPI in the future.
> >
> > Hmm, we have a use case for kdump, this maybe useful.  For example
> > swiotlb is enabled by default if AMD SME/SEV is active, and in kdump
> > kernel we have to increase the crashkernel reserved size for the extra
> > swiotlb requirement.  I wonder if we can just reuse the old kernel's
> > swiotlb region and pass the addr to kdump kernel.
> >
> 
> Yes, definitely helpful for kdump kernel. This can help reduce the
> crashkernel value.
> 
> Previously I was thinking about something similar, play around the
> e820 entry passed to kdump and let it place swiotlb in wanted region.
> Simply remap it like in this patch looks much cleaner.
> 
> If this patch is acceptable, one more patch is needed to expose the
> swiotlb in iomem, so kexec-tools can pass the right kernel cmdline to
> second kernel.

We seem to be passsing a lot of data to kexec.. Perhaps something
of a unified way since we seem to have a lot of things to pass - disabling
IOMMU, ACPI RSDT address, and then this.

CC-ing Anthony who is working on something - would you by any chance
have a doc on this?

Thanks!
> 
> > >
> > > Signed-off-by: Alexander Graf <graf@amazon.com>
> > > ---
> > >  Documentation/admin-guide/kernel-parameters.txt |  3 +-
> > >  Documentation/x86/x86_64/boot-options.rst       |  4 ++-
> > >  kernel/dma/swiotlb.c                            | 46 +++++++++++++++++++++++--
> > >  3 files changed, 49 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index c07815d230bc..d085d55c3cbe 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -4785,11 +4785,12 @@
> > >                       it if 0 is given (See Documentation/admin-guide/cgroup-v1/memory.rst)
> > >
> > >       swiotlb=        [ARM,IA-64,PPC,MIPS,X86]
> > > -                     Format: { <int> | force | noforce }
> > > +                     Format: { <int> | force | noforce | addr=<phys addr> }
> > >                       <int> -- Number of I/O TLB slabs
> > >                       force -- force using of bounce buffers even if they
> > >                                wouldn't be automatically used by the kernel
> > >                       noforce -- Never use bounce buffers (for debugging)
> > > +                     addr=<phys addr> -- Try to allocate SWIOTLB at defined address
> > >
> > >       switches=       [HW,M68k]
> > >
> > > diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
> > > index 2b98efb5ba7f..ca46c57b68c9 100644
> > > --- a/Documentation/x86/x86_64/boot-options.rst
> > > +++ b/Documentation/x86/x86_64/boot-options.rst
> > > @@ -297,11 +297,13 @@ iommu options only relevant to the AMD GART hardware IOMMU:
> > >  iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
> > >  implementation:
> > >
> > > -    swiotlb=<pages>[,force]
> > > +    swiotlb=<pages>[,force][,addr=<phys addr>]
> > >        <pages>
> > >          Prereserve that many 128K pages for the software IO bounce buffering.
> > >        force
> > >          Force all IO through the software TLB.
> > > +      addr=<phys addr>
> > > +        Try to allocate SWIOTLB at defined address
> > >
> > >  Settings for the IBM Calgary hardware IOMMU currently found in IBM
> > >  pSeries and xSeries machines
> > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > index c19379fabd20..83da0caa2f93 100644
> > > --- a/kernel/dma/swiotlb.c
> > > +++ b/kernel/dma/swiotlb.c
> > > @@ -46,6 +46,7 @@
> > >  #include <linux/init.h>
> > >  #include <linux/memblock.h>
> > >  #include <linux/iommu-helper.h>
> > > +#include <linux/io.h>
> > >
> > >  #define CREATE_TRACE_POINTS
> > >  #include <trace/events/swiotlb.h>
> > > @@ -102,6 +103,12 @@ unsigned int max_segment;
> > >  #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
> > >  static phys_addr_t *io_tlb_orig_addr;
> > >
> > > +/*
> > > + * The TLB phys addr may be defined on the command line. Store it here if it is.
> > > + */
> > > +static phys_addr_t io_tlb_addr = INVALID_PHYS_ADDR;
> > > +
> > > +
> > >  /*
> > >   * Protect the above data structures in the map and unmap calls
> > >   */
> > > @@ -119,11 +126,23 @@ setup_io_tlb_npages(char *str)
> > >       }
> > >       if (*str == ',')
> > >               ++str;
> > > -     if (!strcmp(str, "force")) {
> > > +     if (!strncmp(str, "force", 5)) {
> > >               swiotlb_force = SWIOTLB_FORCE;
> > > -     } else if (!strcmp(str, "noforce")) {
> > > +             str += 5;
> > > +     } else if (!strncmp(str, "noforce", 7)) {
> > >               swiotlb_force = SWIOTLB_NO_FORCE;
> > >               io_tlb_nslabs = 1;
> > > +             str += 7;
> > > +     }
> > > +
> > > +     if (*str == ',')
> > > +             ++str;
> > > +     if (!strncmp(str, "addr=", 5)) {
> > > +             char *addrstr = str + 5;
> > > +
> > > +             io_tlb_addr = kstrtoul(addrstr, 0, &str);
> > > +             if (addrstr == str)
> > > +                     io_tlb_addr = INVALID_PHYS_ADDR;
> > >       }
> > >
> > >       return 0;
> > > @@ -239,6 +258,25 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> > >       return 0;
> > >  }
> > >
> > > +static int __init swiotlb_init_io(int verbose, unsigned long bytes)
> > > +{
> > > +     unsigned __iomem char *vstart;
> > > +
> > > +     if (io_tlb_addr == INVALID_PHYS_ADDR)
> > > +             return -EINVAL;
> > > +
> > > +     vstart = memremap(io_tlb_addr, bytes, MEMREMAP_WB);
> > > +     if (!vstart)
> > > +             return -EINVAL;
> > > +
> > > +     if (swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose)) {
> > > +             memunmap(vstart);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  /*
> > >   * Statically reserve bounce buffer space and initialize bounce buffer data
> > >   * structures for the software IO TLB used to implement the DMA API.
> > > @@ -257,6 +295,10 @@ swiotlb_init(int verbose)
> > >
> > >       bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> > >
> > > +     /* Map IO TLB from device memory */
> > > +     if (!swiotlb_init_io(verbose, bytes))
> > > +             return;
> > > +
> > >       /* Get IO TLB memory from the low pages */
> > >       vstart = memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
> > >       if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
> > > --
> > > 2.16.4
> > >
> > >
> > >
> > >
> > > Amazon Development Center Germany GmbH
> > > Krausenstr. 38
> > > 10117 Berlin
> > > Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> > > Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> > > Sitz: Berlin
> > > Ust-ID: DE 289 237 879
> > >
> > >
> > >
> >
> > Thanks
> > Dave
> >
> 
> 
> -- 
> Best Regards,
> Kairui Song
> 
