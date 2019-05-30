Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C732FF17
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 17:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfE3POC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 11:14:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48000 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbfE3POC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:14:02 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9535BBF56C35CC8F4E14;
        Thu, 30 May 2019 23:13:58 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 30 May 2019
 23:13:54 +0800
Subject: Re: [PATCH -next] phy: ti: am654-serdes: Make serdes_am654_xlate()
 static
To:     <kishon@ti.com>, <rogerq@ti.com>
References: <20190418133633.3908-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <27bd7584-174f-5f1d-c8a6-68d819d6fa00@huawei.com>
Date:   Thu, 30 May 2019 23:13:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190418133633.3908-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping...

On 2019/4/18 21:36, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/phy/ti/phy-am654-serdes.c:250:12: warning:
>  symbol 'serdes_am654_xlate' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/phy/ti/phy-am654-serdes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
> index d376920..f8edd08 100644
> --- a/drivers/phy/ti/phy-am654-serdes.c
> +++ b/drivers/phy/ti/phy-am654-serdes.c
> @@ -247,8 +247,8 @@ static void serdes_am654_release(struct phy *x)
>  	mux_control_deselect(phy->control);
>  }
>  
> -struct phy *serdes_am654_xlate(struct device *dev, struct of_phandle_args
> -				 *args)
> +static struct phy *serdes_am654_xlate(struct device *dev,
> +				      struct of_phandle_args *args)
>  {
>  	struct serdes_am654 *am654_phy;
>  	struct phy *phy;
> 

