Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300F513A041
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 05:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgANEaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 23:30:24 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39066 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgANEaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 23:30:23 -0500
Received: by mail-pj1-f65.google.com with SMTP id e11so3719417pjt.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 20:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iVr9yAoZJuPT+wI1kzCXAwKFTOLQvGUMRGn0vgwmpYw=;
        b=uk6cugxOn0gyvgxJ338/RfwMLRVtyKEGffiIZLmHpX1kXOjtW8v9C1lDoB6P1RATQf
         Rf8lnj8xXV8TU5G7AuV9eOO9++qiaDpjLFNCDpaI9BodYB6/h55KgrekPE6r7H8j8fjk
         9ybHWCFAtoLYx8VRzWT83ZX9qTq7fWZ8nglOE8RvcWXTLZ3Pc6Hpy1hwIlVeAfG3iCD0
         TmA1KM5YSve5wyJ0IGU9ldi9kF9lzlYXHqCf9bMjcvpX/GIW4rctveoSyngwcDE7HmL+
         Xo6rA5FdjJg+muFTBKi7TihYTkgl3syhBFFPASeGOsk3bAhww4aLRejvFSOzgfdPgkXe
         vcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iVr9yAoZJuPT+wI1kzCXAwKFTOLQvGUMRGn0vgwmpYw=;
        b=JRv+AQATZPan8NAwRKpMqy2DNbr4/2ATw1GpFDWhlx+f9Tt4xIrqyi4MoTjZXekavu
         LwPf6ytRW8mDJU8gbw5nwP1PODKFF7VtOqYDrxD0B1d3vads+mujO5maDZKPXEPuu3w2
         PYvgWMiRSfX1MMCO/STwicRU5UFCdhkJdNI9Egowc3D7w3Mcz9sePzHXLkIQUxS73rki
         1iBP/ikBh9iwIoVs0OMCXFlxCwiKkNjW2nui1oAyjgj/OljnqOXZXnr5y5UEJftKncKV
         b2W8dzdBUNhQd1S5s9EMW88y8p6YVn0dtpqOv2snx+ZfDX6/M3Y8s6aY/tUL9V2aWHJz
         ZJyw==
X-Gm-Message-State: APjAAAV1mYNI+mUlrTjC6xHC7H5p9CMqMRgChDq1l9uXOZ1UonAwN/gA
        9VhWQY2XgDF9a0ayiFkvMA2tBg==
X-Google-Smtp-Source: APXvYqwl+qwYqVRNB1p2rvrTovb/wGz3fEtHSoB4mx14jTJ+/G5hSEPL7yh4AtUL5EnCcwJvgtv7cA==
X-Received: by 2002:a17:902:a715:: with SMTP id w21mr18029458plq.244.1578976222640;
        Mon, 13 Jan 2020 20:30:22 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id i4sm15444898pgc.51.2020.01.13.20.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2020 20:30:22 -0800 (PST)
Date:   Tue, 14 Jan 2020 10:00:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vireshk@kernel.org, b.zolnierkie@samsung.com, axboe@kernel.dk,
        vkoul@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ata: pata_arasan_cf: Use dma_request_chan() instead
 dma_request_slave_channel()
Message-ID: <20200114043020.fecmhepuvlvtcknd@vireshk-i7>
References: <20200113142747.15240-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113142747.15240-1-peter.ujfalusi@ti.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-01-20, 16:27, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> The dma_request_chan() is the standard API to request slave channel,
> clients should be moved away from the legacy API to allow us to retire
> them.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> Changes since v1:
> - Fixed type in subject
> - Removed reference to deferred probing in commit message
> 
> Regards,
> Peter
> 
>  drivers/ata/pata_arasan_cf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
> index 391dff0f25a2..e9cf31f38450 100644
> --- a/drivers/ata/pata_arasan_cf.c
> +++ b/drivers/ata/pata_arasan_cf.c
> @@ -526,9 +526,10 @@ static void data_xfer(struct work_struct *work)
>  
>  	/* request dma channels */
>  	/* dma_request_channel may sleep, so calling from process context */
> -	acdev->dma_chan = dma_request_slave_channel(acdev->host->dev, "data");
> -	if (!acdev->dma_chan) {
> +	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
> +	if (IS_ERR(acdev->dma_chan)) {
>  		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
> +		acdev->dma_chan = NULL;
>  		goto chan_request_fail;
>  	}
>  
> @@ -539,6 +540,7 @@ static void data_xfer(struct work_struct *work)
>  	}
>  
>  	dma_release_channel(acdev->dma_chan);
> +	acdev->dma_chan = NULL;
>  
>  	/* data xferred successfully */
>  	if (!ret) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
