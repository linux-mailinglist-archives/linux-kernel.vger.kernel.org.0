Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC346A214
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 08:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbfGPGEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 02:04:35 -0400
Received: from verein.lst.de ([213.95.11.211]:38912 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfGPGEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 02:04:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6649468C65; Tue, 16 Jul 2019 08:04:31 +0200 (CEST)
Date:   Tue, 16 Jul 2019 08:04:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Paul Pawlowski <paul@mrarm.io>
Subject: Re: [PATCH 2/3] nvme: Retrieve the required IO queue entry size
 from the controller
Message-ID: <20190716060430.GB29414@lst.de>
References: <20190716004649.17799-1-benh@kernel.crashing.org> <20190716004649.17799-2-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716004649.17799-2-benh@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* Use default IOSQES. We'll update it later if needed */
>  	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
>  	ctrl->ctrl_config |= NVME_CC_ENABLE;
>  
> @@ -2698,6 +2699,30 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  		ctrl->hmmin = le32_to_cpu(id->hmmin);
>  		ctrl->hmminds = le32_to_cpu(id->hmminds);
>  		ctrl->hmmaxd = le16_to_cpu(id->hmmaxd);
> +
> +		/* Grab required IO queue size */
> +		ctrl->iosqes = id->sqes & 0xf;
> +		if (ctrl->iosqes < NVME_NVM_IOSQES) {
> +			dev_err(ctrl->device,
> +				"unsupported required IO queue size %d\n", ctrl->iosqes);
> +			ret = -EINVAL;
> +			goto out_free;
> +		}
> +		/*
> +		 * If our IO queue size isn't the default, update the setting
> +		 * in CC:IOSQES.
> +		 */
> +		if (ctrl->iosqes != NVME_NVM_IOSQES) {
> +			ctrl->ctrl_config &= ~(0xfu << NVME_CC_IOSQES_SHIFT);
> +			ctrl->ctrl_config |= ctrl->iosqes << NVME_CC_IOSQES_SHIFT;
> +			ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC,
> +						     ctrl->ctrl_config);
> +			if (ret) {
> +				dev_err(ctrl->device,
> +					"error updating CC register\n");
> +				goto out_free;
> +			}
> +		}

Actually, this doesn't work on a "real" nvme controller, to change CC
values the controller needs to be disabled.  So back to the version
you circulated to me in private mail that just sets q->sqes and has a
comment that this is magic for The Apple controller.  If/when we get
standardized large SQE support we'll need to discover that earlier or
do a disable/enable dance.  Sorry for misleading you down this road and
creating the extra work.  
