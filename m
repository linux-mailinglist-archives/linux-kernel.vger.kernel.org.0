Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59EFE82B3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 07:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfHFFsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 01:48:46 -0400
Received: from verein.lst.de ([213.95.11.211]:53346 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfHFFsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:48:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EBE5268B02; Tue,  6 Aug 2019 07:48:41 +0200 (CEST)
Date:   Tue, 6 Aug 2019 07:48:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>
Subject: Re: [PATCH v3 13/16] powerpc/pseries/iommu: Don't use
 dma_iommu_ops on secure guests
Message-ID: <20190806054841.GA14197@lst.de>
References: <20190806052237.12525-1-bauerman@linux.ibm.com> <20190806052237.12525-14-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806052237.12525-14-bauerman@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 02:22:34AM -0300, Thiago Jung Bauermann wrote:
> @@ -1318,7 +1319,10 @@ void iommu_init_early_pSeries(void)
>  	of_reconfig_notifier_register(&iommu_reconfig_nb);
>  	register_memory_notifier(&iommu_mem_nb);
>  
> -	set_pci_dma_ops(&dma_iommu_ops);
> +	if (is_secure_guest())
> +		set_pci_dma_ops(NULL);
> +	else
> +		set_pci_dma_ops(&dma_iommu_ops);

Shoudn't:

	if (!is_secure_guest())
		set_pci_dma_ops(&dma_iommu_ops);

be enough here, given that NULL is the default?

Also either way I think this conditional needs a comment explaining
why it is there.
