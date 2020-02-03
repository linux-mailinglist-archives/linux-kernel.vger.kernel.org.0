Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 682751509DF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 16:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgBCPgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 10:36:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53828 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgBCPgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:36:02 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6CB6D28F822
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH 17/17] platform/chrome: Drop cros_ec_cmd_xfer_status()
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Evan Green <evgreen@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
 <20200130203106.201894-18-pmalani@chromium.org>
Message-ID: <d4545a76-934d-0bc3-91a2-eb3385d03ef8@collabora.com>
Date:   Mon, 3 Feb 2020 16:35:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200130203106.201894-18-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/1/20 21:31, Prashant Malani wrote:
> Remove cros_ec_cmd_xfer_status() since all usages of that function
> have been converted to cros_ec_send_cmd_msg().
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c     | 42 +++++----------------
>  include/linux/platform_data/cros_ec_proto.h |  3 --
>  2 files changed, 9 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index efd1c0b6a830c8..8b97702ba97393 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -542,35 +542,6 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  }
>  EXPORT_SYMBOL(cros_ec_cmd_xfer);
>  
> -/**
> - * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
> - * @ec_dev: EC device.
> - * @msg: Message to write.
> - *
> - * This function is identical to cros_ec_cmd_xfer, except it returns success
> - * status only if both the command was transmitted successfully and the EC
> - * replied with success status. It's not necessary to check msg->result when
> - * using this function.
> - *
> - * Return: The number of bytes transferred on success or negative error code.
> - */
> -int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> -			    struct cros_ec_command *msg)
> -{
> -	int ret;
> -
> -	ret = cros_ec_cmd_xfer(ec_dev, msg);
> -	if (ret < 0) {
> -		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
> -	} else if (msg->result != EC_RES_SUCCESS) {
> -		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
> -		return -EPROTO;
> -	}
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
> -
>  /**
>   * cros_ec_send_cmd_msg() - Utility function to send commands to ChromeOS EC.
>   * @ec: EC device struct.
> @@ -581,10 +552,15 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
>   * @indata: Data to be received from the EC.
>   * @insize: Size of the &indata buffer.
>   *
> - * This function is a wrapper around &cros_ec_cmd_xfer_status, and performs
> - * some of the common work involved with sending a command to the EC. This
> - * includes allocating and filling up a &struct cros_ec_command message buffer,
> - * and copying the received data to another buffer.
> + * This function is similar to cros_ec_cmd_xfer(), except it returns success
> + * status only if both the command was transmitted successfully and the EC
> + * replied with success status. It's not necessary to check msg->result when
> + * using this function.
> + *
> + * It also performs some of the common work involved with sending a command to
> + * the EC. This includes allocating and filling up a
> + * &struct cros_ec_command message buffer, and copying the received data to
> + * another buffer.

As I said, explain at the first chance for what is this helper, so you don't
need to tweak the description here.

>   *
>   * Return: The number of bytes transferred on success or negative error code.
>   */
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 166ce26bdd79eb..851bd9af582d94 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -198,9 +198,6 @@ int cros_ec_check_result(struct cros_ec_device *ec_dev,
>  int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  		     struct cros_ec_command *msg);
>  
> -int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> -			    struct cros_ec_command *msg);
> -
>  int cros_ec_send_cmd_msg(struct cros_ec_device *ec_dev, unsigned int version,
>  			 unsigned int command, void *outdata,
>  			 unsigned int outsize, void *indata,
> 
