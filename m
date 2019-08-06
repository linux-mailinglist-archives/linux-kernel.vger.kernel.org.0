Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1DCB8306E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 13:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732771AbfHFLPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 07:15:24 -0400
Received: from foss.arm.com ([217.140.110.172]:60344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbfHFLPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:15:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BC0B337;
        Tue,  6 Aug 2019 04:15:23 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 690503F694;
        Tue,  6 Aug 2019 04:15:22 -0700 (PDT)
Subject: Re: [PATCH] coresight: tmc-etr: Fix updating buffer in not-snapshot
 mode.
To:     yabinc@google.com, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190805233738.136357-1-yabinc@google.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <fa08b60a-8098-34f3-cc4d-6b1fc9f50594@arm.com>
Date:   Tue, 6 Aug 2019 12:15:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805233738.136357-1-yabinc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yabin

On 06/08/2019 00:37, Yabin Cui wrote:
> TMC etr always copies all available data to perf aux buffer, which
> may exceed the available space in perf aux buffer. It isn't suitable
> for not-snapshot mode, because:
> 1) It may overwrite previously written data.
> 2) It may make the perf_event_mmap_page->aux_head report having more
> or less data than the reality.

Thanks for debugging and the fix.

> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 17006705287a..697e68d492af 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1410,9 +1410,10 @@ static void tmc_free_etr_buffer(void *config)
>    * tmc_etr_sync_perf_buffer: Copy the actual trace data from the hardware
>    * buffer to the perf ring buffer.
>    */
> -static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
> +static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf,
> +				     unsigned long to_copy)
>   {
> -	long bytes, to_copy;
> +	long bytes;
>   	long pg_idx, pg_offset, src_offset;
>   	unsigned long head = etr_perf->head;
>   	char **dst_pages, *src_buf;
> @@ -1423,7 +1424,6 @@ static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
>   	pg_offset = head & (PAGE_SIZE - 1);
>   	dst_pages = (char **)etr_perf->pages;
>   	src_offset = etr_buf->offset;
> -	to_copy = etr_buf->len;
>   
>   	while (to_copy > 0) {
>   		/*
> @@ -1501,7 +1501,11 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>   	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>   
>   	size = etr_buf->len;
> -	tmc_etr_sync_perf_buffer(etr_perf);
> +	if (!etr_perf->snapshot && size > handle->size) {
> +		size = handle->size;
> +		lost = true;
> +	}
> +	tmc_etr_sync_perf_buffer(etr_perf, size);

The patch as such looks good to me.
I was thinking if we should limit the ETR buffer to the perf ring buffer,
in case the perf buffer is smaller than the ETR configured size.
Irrespective of snapshot mode or not, we can't save more than what the ring
buffer offers us with. Even though for the cpu-wide trace, we could have "n"
such ring buffers, we end up using only one ring buffer(the last one scheduled 
out). May be we could explore if we could improve the handling of large buffer
into multiple ring buffers (which may require perf core changes).

Anyways, for this patch:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
