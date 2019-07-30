Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D08F17AC75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 17:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbfG3Pd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 11:33:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:58257 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731791AbfG3Pd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:33:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 08:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="scan'208";a="255640802"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 30 Jul 2019 08:33:27 -0700
Date:   Tue, 30 Jul 2019 09:30:44 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v3] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
Message-ID: <20190730153044.GA13948@localhost.localdomain>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 03:31:02PM +1000, Benjamin Herrenschmidt wrote:
> From 8dcba2ef5b1466b023b88b4eca463b30de78d9eb Mon Sep 17 00:00:00 2001
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Fri, 19 Jul 2019 15:03:06 +1000
> Subject: 
> 
> Another issue with the Apple T2 based 2018 controllers seem to be
> that they blow up (and shut the machine down) if there's a tag
> collision between the IO queue and the Admin queue.
> 
> My suspicion is that they use our tags for their internal tracking
> and don't mix them with the queue id. They also seem to not like
> when tags go beyond the IO queue depth, ie 128 tags.
> 
> This adds a quirk that marks tags 0..31 of the IO queue reserved
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

One problem is that we've an nvme parameter, io_queue_depth, that a user
could set to something less than 32, and then you won't be able to do
any IO. I'd recommend enforce the admin queue to QD1 for this device so
that you have more potential IO tags.

 
> Thanks Damien, reserved tags work and make this a lot simpler !
> 
>  drivers/nvme/host/nvme.h |  5 +++++
>  drivers/nvme/host/pci.c  | 19 ++++++++++++++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index ced0e0a7e039..8732da6df555 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -102,6 +102,11 @@ enum nvme_quirks {
>  	 * Use non-standard 128 bytes SQEs.
>  	 */
>  	NVME_QUIRK_128_BYTES_SQES		= (1 << 11),
> +
> +	/*
> +	 * Prevent tag overlap between queues
> +	 */
> +	NVME_QUIRK_SHARED_TAGS                  = (1 << 12),
>  };
>  
>  /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7088971d4c42..fc74395a028b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2106,6 +2106,14 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  	unsigned long size;
>  
>  	nr_io_queues = max_io_queues();
> +
> +	/*
> +	 * If tags are shared with admin queue (Apple bug), then
> +	 * make sure we only use one IO queue.
> +	 */
> +	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
> +		nr_io_queues = 1;
> +
>  	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
>  	if (result < 0)
>  		return result;
> @@ -2278,6 +2286,14 @@ static int nvme_dev_add(struct nvme_dev *dev)
>  		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
>  		dev->tagset.driver_data = dev;
>  
> +		/*
> +		 * Some Apple controllers requires tags to be unique
> +		 * across admin and IO queue, so reserve the first 32
> +		 * tags of the IO queue.
> +		 */
> +		if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
> +			dev->tagset.reserved_tags = NVME_AQ_DEPTH;
> +
>  		ret = blk_mq_alloc_tag_set(&dev->tagset);
>  		if (ret) {
>  			dev_warn(dev->ctrl.device,
> @@ -3057,7 +3073,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
>  		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
> -				NVME_QUIRK_128_BYTES_SQES },
> +				NVME_QUIRK_128_BYTES_SQES |
> +				NVME_QUIRK_SHARED_TAGS },
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, nvme_id_table);
> 
> 
