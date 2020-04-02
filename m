Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48D219BF88
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 12:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387991AbgDBKnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 06:43:01 -0400
Received: from kernel.crashing.org ([76.164.61.194]:37706 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgDBKnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 06:43:00 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 032AfWgw028540
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Apr 2020 05:41:35 -0500
Message-ID: <f763d9d8487e77006b233bc16e0883f956850b6c.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 03/25] powerpc/powernv: Map & release OpenCAPI LPC
 memory
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        "Alastair D'Silva" <alastair@d-silva.org>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Date:   Thu, 02 Apr 2020 21:41:30 +1100
In-Reply-To: <CAPcyv4iGEHJpZctEm+Do1-kOZBUDeKKcREr=BqcK4kCvLWhAQQ@mail.gmail.com>
References: <20200327071202.2159885-1-alastair@d-silva.org>
         <20200327071202.2159885-4-alastair@d-silva.org>
         <CAPcyv4iGEHJpZctEm+Do1-kOZBUDeKKcREr=BqcK4kCvLWhAQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-01 at 01:48 -0700, Dan Williams wrote:
> > 
> > +u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size)
> > +{
> > +       struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> > +       struct pnv_phb *phb = hose->private_data;
> 
> Is calling the local variable 'hose' instead of 'host' on purpose?

Haha that's funny :-)

It's an oooooooold usage that comes iirc from sparc ? or maybe alpha ?
I somewhat accidentally picked it up when adding multiple host-bridge
support on powerpc in the early 2000's and it hasn't quite died yet :)

Cheers,
Ben.

