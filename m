Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF05200BF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 09:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfEPH64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 03:58:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59944 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfEPH64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 03:58:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6698F6030E; Thu, 16 May 2019 07:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557993535;
        bh=QT8q5Z4MoVm6vzoPng3HVqefya1GCaZkTFqKfaIzjGI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mi5DJ22/p80wrXEGco9iXj/IrVaQSZ/8MQNUZcTxEIAarrqQYLVUU1B7HBIKaDpnT
         PxizZaM/hXCSSBsXAYKNWI5AVE3zAndTg/pbDz4QbUwNFwgGdH7wgAT5eNomJxasbD
         j1FW6LqeW9eLwBSvzFtHu6E1EltDgx9n2sriXi0M=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1E2E6076A;
        Thu, 16 May 2019 07:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557993534;
        bh=QT8q5Z4MoVm6vzoPng3HVqefya1GCaZkTFqKfaIzjGI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cv5k4QM0UsszKFCj3vXH5cK4MYuC6/1MEC+Tfu1OBtjdXs2Yh/3o9D9iHw5ymBru9
         3mFjHl58He96toOyBGRsTub3KLKzB6OfHSW+qzLW4Z2XP2kEiWW2WpOro0QKOMyOTF
         cNNfOXeZeW2rMrlrnDUj58vSe6FYXyYwq+HMCkzo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1E2E6076A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v3 1/1] bsr: do not use assignment in if condition
To:     parna.naveenkumar@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20190515161746.29034-1-parna.naveenkumar@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <8f969496-c895-088f-eef2-ec6a70e19505@codeaurora.org>
Date:   Thu, 16 May 2019 13:28:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515161746.29034-1-parna.naveenkumar@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/15/2019 9:47 PM, parna.naveenkumar@gmail.com wrote:
> From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
>
> checkpatch.pl does not like assignment in if condition
>
> Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
> Changes in v3:
> The first patch has an extra space in if statement, so fixed it in v2 but
> forgot add what changed from the previous version. In v3 added the
> complete change history.
>
>   drivers/char/bsr.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
> index a6cef548e01e..70de334554a8 100644
> --- a/drivers/char/bsr.c
> +++ b/drivers/char/bsr.c
> @@ -322,7 +322,8 @@ static int __init bsr_init(void)
>   		goto out_err_2;
>   	}
>   
> -	if ((ret = bsr_create_devs(np)) < 0) {
> +	ret = bsr_create_devs(np);
> +	if (ret < 0) {
>   		np = NULL;
>   		goto out_err_3;
>   	}
