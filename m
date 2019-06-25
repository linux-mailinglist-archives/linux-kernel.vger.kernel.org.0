Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDAC05240F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 09:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfFYHJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 03:09:08 -0400
Received: from verein.lst.de ([213.95.11.211]:60150 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfFYHJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:09:08 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D31E168B05; Tue, 25 Jun 2019 09:08:35 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:08:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        palmer@sifive.com, paul.walmsley@sifive.com
Subject: Re: [PATCH] nvme-pci: Avoid leak if pci_p2pmem_virt_to_bus()
 returns null
Message-ID: <20190625070835.GC30123@lst.de>
References: <1561420642-21186-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561420642-21186-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 04:57:22PM -0700, Alan Mikhak wrote:
> Modify nvme_alloc_sq_cmds() to call pci_free_p2pmem()
> to free the memory it allocated using pci_alloc_p2pmem()
> in case pci_p2pmem_virt_to_bus() returns null.
> 
> Make sure not to call pci_free_p2pmem() if pci_alloc_p2pmem()
> returned null which can happen if CONFIG_PCI_P2PDMA is not
> configured.

Can you 

> 
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/nvme/host/pci.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 524d6bd6d095..5dfa067f6506 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1456,11 +1456,15 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
>  
>  	if (qid && dev->cmb_use_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
>  		nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(depth));
> -		nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
> -						nvmeq->sq_cmds);
> -		if (nvmeq->sq_dma_addr) {
> -			set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
> -			return 0; 
> +		if (nvmeq->sq_cmds) {
> +			nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
> +							nvmeq->sq_cmds);
> +			if (nvmeq->sq_dma_addr) {
> +				set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
> +				return 0;
> +			}
> +
> +			pci_free_p2pmem(pdev, nvmeq->sq_cmds, SQ_SIZE(depth));

pci_p2pmem_virt_to_bus should only fail when
pci_p2pmem_virt_to_bus failed.  That being said I think doing the
error check on pci_alloc_p2pmem instead of relying on 
pci_p2pmem_virt_to_bus "passing through" the error seems odd, I'd
rather check the pci_alloc_p2pmem return value directly.
