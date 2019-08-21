Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C123D9712D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 06:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfHUEgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 00:36:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:53878 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfHUEgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 00:36:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7L4Zr77013135;
        Tue, 20 Aug 2019 23:35:54 -0500
Message-ID: <a1cbb068b3b264c22792fda5f62f4fe9f1f1733b.camel@kernel.crashing.org>
Subject: Re: [PATCH] fsi: scom: Don't abort operations for minor errors
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Eddie James <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Date:   Wed, 21 Aug 2019 14:35:53 +1000
In-Reply-To: <1565896134-22749-1-git-send-email-eajames@linux.ibm.com>
References: <1565896134-22749-1-git-send-email-eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-15 at 14:08 -0500, Eddie James wrote:
> The scom driver currently fails out of operations if certain system
> errors are flagged in the status register; system checkstop, special
> attention, or recoverable error. These errors won't impact the ability
> of the scom engine to perform operations, so the driver should continue
> under these conditions.
> Also, don't do a PIB reset for these conditions, since it won't help.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  drivers/fsi/fsi-scom.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
> index 343153d..004dc03 100644
> --- a/drivers/fsi/fsi-scom.c
> +++ b/drivers/fsi/fsi-scom.c
> @@ -38,8 +38,7 @@
>  #define SCOM_STATUS_PIB_RESP_MASK	0x00007000
>  #define SCOM_STATUS_PIB_RESP_SHIFT	12
>  
> -#define SCOM_STATUS_ANY_ERR		(SCOM_STATUS_ERR_SUMMARY | \
> -					 SCOM_STATUS_PROTECTION | \
> +#define SCOM_STATUS_ANY_ERR		(SCOM_STATUS_PROTECTION | \
>  					 SCOM_STATUS_PARITY |	  \
>  					 SCOM_STATUS_PIB_ABORT | \
>  					 SCOM_STATUS_PIB_RESP_MASK)
> @@ -251,11 +250,6 @@ static int handle_fsi2pib_status(struct scom_device *scom, uint32_t status)
>  	/* Return -EBUSY on PIB abort to force a retry */
>  	if (status & SCOM_STATUS_PIB_ABORT)
>  		return -EBUSY;
> -	if (status & SCOM_STATUS_ERR_SUMMARY) {
> -		fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG, &dummy,
> -				 sizeof(uint32_t));
> -		return -EIO;
> -	}
>  	return 0;
>  }
>  

