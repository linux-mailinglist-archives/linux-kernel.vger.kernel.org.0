Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18774D328E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 22:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfJJUjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 16:39:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54880 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfJJUjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:39:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 12F2128D04A
Subject: Re: [PATCH v2 1/1] blk-mq: fill header with kernel-doc
To:     Bart Van Assche <bvanassche@acm.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, kernel@collabora.com
References: <20191008001416.12656-1-andrealmeid@collabora.com>
 <854l0j19go.fsf@collabora.com> <6aa48cd2-5f23-a4be-f777-d65bf755a976@acm.org>
 <85zhibyt14.fsf@collabora.com> <86de2c88-5812-4a87-b5d8-1b7b1808d013@acm.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <8e20f2c6-c165-5b5f-7497-9472913d0ba8@collabora.com>
Date:   Thu, 10 Oct 2019 17:38:18 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <86de2c88-5812-4a87-b5d8-1b7b1808d013@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/19 5:01 PM, Bart Van Assche wrote:
> On 10/8/19 11:46 AM, Gabriel Krisman Bertazi wrote:
>> Hmm, sorry, but I'm confused.  I'm sure I'm missing something simple,
>> since I haven't touched this in a while, so maybe you can quickly point
>> me in the right direction?
>>
>> I see blk_mq_requeue_request() being used by device drivers to retry
>> requests that failed, but if I read the code correctly, the flushed
>> queue seems to be moved to hctx->dispatch when the device
>> driver returned BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE to
>> blk_mq_dispatch_rq_list(). I thought BLK_STS_RESOURCE was returned by
>> the driver on .queue_rq() to signal there was no more resources on the
>> hardware to service further requests.
> 
> Hi Gabriel,
> 
> The simplified version of how requests are requeued as follows:
> * A block driver calls blk_mq_requeue_request().
> * blk_mq_requeue_request() calls blk_mq_add_to_requeue_list()
> * blk_mq_add_to_requeue_list() executes the following code:
>     list_add_tail(&rq->queuelist, &q->requeue_list)
> * A block driver or the block layer core calls
>   blk_mq_kick_requeue_list() or blk_mq_delay_kick_requeue_list(). Both
>   functions trigger a call of blk_mq_requeue_work().
> * blk_mq_requeue_work() processes q->requeue_list.
> 
> Bart.
> 
> 

Hello Bart,

Seems that it's not clear for me the role of these members. Could you
please check if those definitions make sense for you?

- hctx->dispatch: This queue is used for requests that are ready to be
dispatched to the hardware but for some reason (e.g. lack of resources,
the hardware is to busy and can't get more requests) could not be sent
to the hardware. As soon as the driver can send new requests, those
queued at this list will be sent first for a more fair dispatch. Since
those requests are at the hctx, they can't be requeued or rescheduled
anymore.

- request_queue->requeue_list: This list is used when it's not possible
to send the request to the associated hctx. This can happen if the
associated CPU or hctx is not available anymore. When requeueing those
requests, it will be possible to send them to new and function queues.

Thanks,
	André
