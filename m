Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEC6449C28
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 10:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfFRIir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 04:38:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59772 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfFRIiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:38:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 83956260DF9
Subject: Re: [PATCH 1/2] platform/chrome: wilco_ec: Fix unreleased lock in
 event_read()
To:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        djkurtz@chromium.org, dtor@google.com, sjg@chromium.org,
        kernel-janitors@vger.kernel.org, dan.carpenter@oracle.com
References: <20190614205631.90222-1-ncrews@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f77eda75-70f4-e276-21f7-cb64a65d121f@collabora.com>
Date:   Tue, 18 Jun 2019 10:38:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190614205631.90222-1-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/6/19 22:56, Nick Crews wrote:
> When copying an event to userspace failed, the event queue
> lock was never released. This fixes that.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>  drivers/platform/chrome/wilco_ec/event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
> index 4d2776f77dbd..1eed55681598 100644
> --- a/drivers/platform/chrome/wilco_ec/event.c
> +++ b/drivers/platform/chrome/wilco_ec/event.c
> @@ -342,7 +342,7 @@ static ssize_t event_read(struct file *filp, char __user *buf, size_t count,
>  				 struct ec_event_entry, list);
>  	n_bytes_written = entry->size;
>  	if (copy_to_user(buf, &entry->event, n_bytes_written))
> -		return -EFAULT;
> +		n_bytes_written = -EFAULT;
>  	list_del(&entry->list);
>  	kfree(entry);
>  	dev_data->num_events--;
> 

Applied for chrome-platform-5.3

Thanks,
~ Enric
