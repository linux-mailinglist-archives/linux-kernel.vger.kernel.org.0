Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13BD14A8AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 18:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgA0RHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 12:07:19 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2308 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbgA0RHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:07:17 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 7D538FE425EF68D12A98;
        Mon, 27 Jan 2020 17:07:16 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 27 Jan 2020 17:07:15 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jan
 2020 17:07:16 +0000
Date:   Mon, 27 Jan 2020 17:07:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <james.quinlan@broadcom.com>, <lukasz.luba@arm.com>,
        <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH 01/11] firmware: arm_scmi: Add receive buffer
 support for notifications
Message-ID: <20200127170713.000013ee@Huawei.com>
In-Reply-To: <20200120122333.46217-2-cristian.marussi@arm.com>
References: <20200120122333.46217-1-cristian.marussi@arm.com>
        <20200120122333.46217-2-cristian.marussi@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020 12:23:23 +0000
Cristian Marussi <cristian.marussi@arm.com> wrote:

> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> With all the plumbing in place, let's just add the separate dedicated
> receive buffers to handle notifications that can arrive asynchronously
> from the platform firmware to OS.
> 
> Also add check to see if the platform supports any receive channels
> before allocating the receive buffers.

Perhaps hand hold the reader a tiny bit more by saying that we need
to move the initialization later so that we can know *if* the receive
channels are supported.  Took me a moment to figure out why you did that ;)

One minor suggestion inline.

> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 2c96f6b5a7d8..9611e8037d77 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -123,6 +123,7 @@ struct scmi_chan_info {
>   * @version: SCMI revision information containing protocol version,
>   *	implementation version and (sub-)vendor identification.
>   * @tx_minfo: Universal Transmit Message management info
> + * @rx_minfo: Universal Receive Message management info
>   * @tx_idr: IDR object to map protocol id to Tx channel info pointer
>   * @rx_idr: IDR object to map protocol id to Rx channel info pointer
>   * @protocols_imp: List of protocols implemented, currently maximum of
> @@ -136,6 +137,7 @@ struct scmi_info {
>  	struct scmi_revision_info version;
>  	struct scmi_handle handle;
>  	struct scmi_xfers_info tx_minfo;
> +	struct scmi_xfers_info rx_minfo;
>  	struct idr tx_idr;
>  	struct idr rx_idr;
>  	u8 *protocols_imp;
> @@ -690,13 +692,13 @@ int scmi_handle_put(const struct scmi_handle *handle)
>  	return 0;
>  }
>  
> -static int scmi_xfer_info_init(struct scmi_info *sinfo)
> +static int __scmi_xfer_info_init(struct scmi_info *sinfo, bool tx)
>  {
>  	int i;
>  	struct scmi_xfer *xfer;
>  	struct device *dev = sinfo->dev;
>  	const struct scmi_desc *desc = sinfo->desc;
> -	struct scmi_xfers_info *info = &sinfo->tx_minfo;
> +	struct scmi_xfers_info *info = tx ? &sinfo->tx_minfo : &sinfo->rx_minfo;

Perhaps cleaner to just pass in the relevant info structure rather than a boolean
to pick it.  Saves people having to check if the boolean is saying it's
tx or rx when reading the call sites.

>  
>  	/* Pre-allocated messages, no more than what hdr.seq can support */
>  	if (WARN_ON(desc->max_msg >= MSG_TOKEN_MAX)) {
> @@ -731,6 +733,16 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
>  	return 0;
>  }
>  
> +static int scmi_xfer_info_init(struct scmi_info *sinfo)
> +{
> +	int ret = __scmi_xfer_info_init(sinfo, true);
> +
> +	if (!ret && idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE))
> +		ret = __scmi_xfer_info_init(sinfo, false);
> +
> +	return ret;
> +}
> +
>  static int scmi_mailbox_check(struct device_node *np, int idx)
>  {
>  	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells",
> @@ -908,10 +920,6 @@ static int scmi_probe(struct platform_device *pdev)
>  	info->desc = desc;
>  	INIT_LIST_HEAD(&info->node);
>  
> -	ret = scmi_xfer_info_init(info);
> -	if (ret)
> -		return ret;
> -
>  	platform_set_drvdata(pdev, info);
>  	idr_init(&info->tx_idr);
>  	idr_init(&info->rx_idr);
> @@ -924,6 +932,10 @@ static int scmi_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = scmi_xfer_info_init(info);
> +	if (ret)
> +		return ret;
> +
>  	ret = scmi_base_protocol_init(handle);
>  	if (ret) {
>  		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);


