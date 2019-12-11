Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F32D11BB1A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 19:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbfLKSJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 13:09:59 -0500
Received: from foss.arm.com ([217.140.110.172]:41970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731103AbfLKSJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:09:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F5C031B;
        Wed, 11 Dec 2019 10:09:57 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A3C63F6CF;
        Wed, 11 Dec 2019 10:09:57 -0800 (PST)
Subject: Re: [PATCH 11/15] firmware: arm_scmi: Match scmi device by both name
 and protocol id
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191210145345.11616-1-sudeep.holla@arm.com>
 <20191210145345.11616-12-sudeep.holla@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <75b53cc5-1052-de65-dbd6-a2e32c7bed21@arm.com>
Date:   Wed, 11 Dec 2019 18:09:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210145345.11616-12-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 14:53, Sudeep Holla wrote:
> The scmi bus now has support to match the driver with devices not only
> based on their protocol id but also based on their device name if one is
> available. This was added to cater the need to support multiple devices
> and drivers for the same protocol.
> 
> Let us add the name "genpd" to scmi_device_id table in the driver so
> that in matches only with device with the same name and protocol id
> SCMI_PROTOCOL_POWER.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

>  drivers/firmware/arm_scmi/scmi_pm_domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/scmi_pm_domain.c b/drivers/firmware/arm_scmi/scmi_pm_domain.c
> index 87f737e01473..bafbfe358f97 100644
> --- a/drivers/firmware/arm_scmi/scmi_pm_domain.c
> +++ b/drivers/firmware/arm_scmi/scmi_pm_domain.c
> @@ -112,7 +112,7 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
>  }
> 
>  static const struct scmi_device_id scmi_id_table[] = {
> -	{ SCMI_PROTOCOL_POWER },
> +	{ SCMI_PROTOCOL_POWER, "genpd" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> --
> 2.17.1
> 

