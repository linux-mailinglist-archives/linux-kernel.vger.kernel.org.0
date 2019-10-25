Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B3BE564C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 23:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfJYVze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 17:55:34 -0400
Received: from ale.deltatee.com ([207.54.116.67]:36700 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfJYVzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:55:33 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iO7YI-0008W9-RF; Fri, 25 Oct 2019 15:55:23 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20191025202535.12036-1-logang@deltatee.com>
 <20191025202535.12036-4-logang@deltatee.com>
 <28b40ab8-c695-784e-3f52-03a18b891d25@grimberg.me>
 <11006dd2-718f-b569-4ef3-c01232354d5f@deltatee.com>
 <952c93fa-ef69-e113-a285-b1e9a0ddcafc@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <55aaecf5-e094-1ef6-e4ac-3460d5eaf02c@deltatee.com>
Date:   Fri, 25 Oct 2019 15:55:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <952c93fa-ef69-e113-a285-b1e9a0ddcafc@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com, hch@lst.de, maxg@mellanox.com, kbusch@kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [RFC PATCH 3/3] nvme: Introduce nvme_execute_passthru_rq_nowait()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-10-25 3:40 p.m., Sagi Grimberg wrote:
>> Hmm, that's going to be a bit tricky. Seeing the work_struct belongs
>> potentially to a number of different requests, we can't just flush the
>> individual work items. I think we'd have to create a work-queue per ctrl
>> and flush that. Any objections to that?
> 
> I'd object to that overhead...
> 
> How about marking the request if the workqueue path is taken and
> in nvme_stop_ctrl you add a blk_mq_tagset_busy_iter and cancel
> it in the callback?

Oh, cool. That looks great, I'll do that. Thanks!

Logan

> Something like:
> -- 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fa7ba09dca77..13dbbec5497d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3955,12 +3955,33 @@ void nvme_complete_async_event(struct nvme_ctrl
> *ctrl, __le16 status,
>  }
>  EXPORT_SYMBOL_GPL(nvme_complete_async_event);
> 
> +static bool nvme_flush_async_passthru_request(struct request *rq,
> +               void *data, bool reserved)
> +{
> +       if (!(nvme_req(rq)->flags & NVME_REQ_ASYNC_PASSTHRU))
> +               return true;
> +
> +       dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
> +                               "Cancelling passthru I/O %d", req->tag);
> +       flush_work(&nvme_req(rq)->work);
> +       return true;
> +}
> +
> +static void nvme_flush_async_passthru_requests(struct nvme_ctrl *ctrl)
> +{
> +       blk_mq_tagset_busy_iter(ctrl->tagset,
> +               nvme_flush_async_passthru_request, ctrl);
> +       blk_mq_tagset_busy_iter(ctrl->admin_tagset,
> +               nvme_flush_async_passthru_request, ctrl);
> +}
> +
>  void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>  {
>         nvme_mpath_stop(ctrl);
>         nvme_stop_keep_alive(ctrl);
>         flush_work(&ctrl->async_event_work);
>         cancel_work_sync(&ctrl->fw_act_work);
> +       nvme_flush_async_passthru_requests(ctrl);
>  }
>  EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
> -- 
