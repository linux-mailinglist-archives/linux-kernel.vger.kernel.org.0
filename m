Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D733175D8F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 15:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCBOwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 09:52:17 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2496 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727112AbgCBOwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:52:17 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 9916AECE61B444B501C5;
        Mon,  2 Mar 2020 14:52:15 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 2 Mar 2020 14:52:15 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 14:52:14 +0000
Date:   Mon, 2 Mar 2020 14:52:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sudeep.holla@arm.com>,
        <lukasz.luba@arm.com>, <james.quinlan@broadcom.com>
Subject: Re: [RFC PATCH v3 01/13] firmware: arm_scmi: Add receive buffer
 support for notifications
Message-ID: <20200302145213.00003304@Huawei.com>
In-Reply-To: <20200224144124.2008-2-cristian.marussi@arm.com>
References: <20200224144124.2008-1-cristian.marussi@arm.com>
        <20200224144124.2008-2-cristian.marussi@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 14:41:12 +0000
Cristian Marussi <cristian.marussi@arm.com> wrote:

> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> With all the plumbing in place, let's just add the separate dedicated
> receive buffers to handle notifications that can arrive asynchronously
> from the platform firmware to OS.
> 
> Also add one check to see if the platform supports any receive channels
> before allocating the receive buffers: since those buffers are optionally
> supported though, the whole xfer initialization is also postponed to be
> able to check for their existence in advance.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> [Changed parameters in __scmi_xfer_info_init()]
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> V1 --> V2:
> - reviewed commit message
> - reviewed parameters of __scmi_xfer_info_init()
> ---
>  drivers/firmware/arm_scmi/driver.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index dbec767222e9..efb660c34b57 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -76,6 +76,7 @@ struct scmi_xfers_info {
>   *	implementation version and (sub-)vendor identification.
>   * @handle: Instance of SCMI handle to send to clients
>   * @tx_minfo: Universal Transmit Message management info
> + * @rx_minfo: Universal Receive Message management info
>   * @tx_idr: IDR object to map protocol id to Tx channel info pointer
>   * @rx_idr: IDR object to map protocol id to Rx channel info pointer
>   * @protocols_imp: List of protocols implemented, currently maximum of
> @@ -89,6 +90,7 @@ struct scmi_info {
>  	struct scmi_revision_info version;
>  	struct scmi_handle handle;
>  	struct scmi_xfers_info tx_minfo;
> +	struct scmi_xfers_info rx_minfo;
>  	struct idr tx_idr;
>  	struct idr rx_idr;
>  	u8 *protocols_imp;
> @@ -525,13 +527,13 @@ int scmi_handle_put(const struct scmi_handle *handle)
>  	return 0;
>  }
>  
> -static int scmi_xfer_info_init(struct scmi_info *sinfo)
> +static int __scmi_xfer_info_init(struct scmi_info *sinfo,
> +				 struct scmi_xfers_info *info)
>  {
>  	int i;
>  	struct scmi_xfer *xfer;
>  	struct device *dev = sinfo->dev;
>  	const struct scmi_desc *desc = sinfo->desc;
> -	struct scmi_xfers_info *info = &sinfo->tx_minfo;
>  
>  	/* Pre-allocated messages, no more than what hdr.seq can support */
>  	if (WARN_ON(desc->max_msg >= MSG_TOKEN_MAX)) {
> @@ -566,6 +568,16 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
>  	return 0;
>  }
>  
> +static int scmi_xfer_info_init(struct scmi_info *sinfo)
> +{
> +	int ret = __scmi_xfer_info_init(sinfo, &sinfo->tx_minfo);
> +
> +	if (!ret && idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE))
> +		ret = __scmi_xfer_info_init(sinfo, &sinfo->rx_minfo);
> +
> +	return ret;
> +}
> +
>  static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
>  			   int prot_id, bool tx)
>  {
> @@ -699,10 +711,6 @@ static int scmi_probe(struct platform_device *pdev)
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
> @@ -715,6 +723,10 @@ static int scmi_probe(struct platform_device *pdev)
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


