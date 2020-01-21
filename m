Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3150C143790
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 08:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgAUH2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 02:28:02 -0500
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:42354 "EHLO
        3.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 02:28:02 -0500
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jan 2020 02:28:01 EST
Received: from player695.ha.ovh.net (unknown [10.108.54.119])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 6CFBA12D604
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 08:12:11 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player695.ha.ovh.net (Postfix) with ESMTPSA id 478D9E528FFF;
        Tue, 21 Jan 2020 07:11:28 +0000 (UTC)
Date:   Tue, 21 Jan 2020 08:11:26 +0100
From:   Greg Kurz <groug@kaod.org>
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
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
        =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 05/27] powerpc: Map & release OpenCAPI LPC memory
Message-ID: <20200121081126.2f9c6972@bahia.lan>
In-Reply-To: <f33979a2-a083-dd0e-3273-7ebff66d6385@linux.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
        <20191203034655.51561-6-alastair@au1.ibm.com>
        <f33979a2-a083-dd0e-3273-7ebff66d6385@linux.ibm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11838274572983900498
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudejgddutdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 17:46:12 +1100
Andrew Donnellan <ajd@linux.ibm.com> wrote:

> On 3/12/19 2:46 pm, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > This patch adds platform support to map & release LPC memory.
> 
> Might want to explain what LPC is.
> 
> Otherwise:
> 
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
> 
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >   arch/powerpc/include/asm/pnv-ocxl.h   |  2 ++
> >   arch/powerpc/platforms/powernv/ocxl.c | 42 +++++++++++++++++++++++++++
> >   2 files changed, 44 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
> > index 7de82647e761..f8f8ffb48aa8 100644
> > --- a/arch/powerpc/include/asm/pnv-ocxl.h
> > +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> > @@ -32,5 +32,7 @@ extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
> >   
> >   extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
> >   extern void pnv_ocxl_free_xive_irq(u32 irq);
> > +extern u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size);
> > +extern void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev);
> 
> nit: I don't think these need to be extern?
> 
> 

And even if they were, as verified by checkpatch:

"extern prototypes should be avoided in .h files"
