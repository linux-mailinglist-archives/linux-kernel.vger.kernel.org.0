Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7457A154CCA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 21:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgBFUPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 15:15:35 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:27074 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727872AbgBFUPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:15:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581020135; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=dG2tUlRMLlas7O8WcJ1xF+DqSR0HVSJjyLr0E/FdeAo=; b=j95RYD5w80HkYwIpaqPxNOSznnjvjPSWvO/z8z/5o/R4Jx8ivW2Gv9u6H/WIEOR3ICW0EQg8
 b1c0Mx2GPUZeSZBFdrLemLHRf5iftHJpjYUYI/MHFnQRnHc60SxmtXeOUp3BbLJRxnZGYwLZ
 hvesA7WTiSW4JVk03myZNV4G6so=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3c73e5.7f12d10dfd88-smtp-out-n01;
 Thu, 06 Feb 2020 20:15:33 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6D3D2C447A0; Thu,  6 Feb 2020 20:15:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F44BC433A2;
        Thu,  6 Feb 2020 20:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F44BC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2 08/16] bus: mhi: core: Add support for downloading
 firmware over BHIe
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, kvalo@codeaurora.org,
        bjorn.andersson@linaro.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
 <20200131135009.31477-9-manivannan.sadhasivam@linaro.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <8cd6f7cd-7a14-e790-3828-372e5b242906@codeaurora.org>
Date:   Thu, 6 Feb 2020 13:15:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200131135009.31477-9-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/2020 6:50 AM, Manivannan Sadhasivam wrote:
> MHI supports downloading the device firmware over BHI/BHIe (Boot Host
> Interface) protocol. Hence, this commit adds necessary helpers, which
> will be called during device power up stage.
> 
> This is based on the patch submitted by Sujeev Dias:
> https://lkml.org/lkml/2018/7/9/989
> 
> Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> [mani: splitted the data transfer patch and cleaned up for upstream]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
