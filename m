Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E292FEBD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfE3PAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 11:00:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41604 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727376AbfE3PAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:00:50 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 81F9B30B3F2D8BFF60BF;
        Thu, 30 May 2019 23:00:41 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 30 May 2019
 23:00:39 +0800
Subject: Re: [PATCH v2] powerpc/pseries: Use correct event modifier in
 rtas_parse_epow_errlog()
To:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <mahesh@linux.vnet.ibm.com>,
        <npiggin@gmail.com>, <ganeshgr@linux.ibm.com>, <anton@samba.org>,
        <ruscur@russell.cc>
References: <20190423143533.26952-1-yuehaibing@huawei.com>
 <20190424021739.20916-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <dde2fea7-2f85-040d-00d4-95c869180084@huawei.com>
Date:   Thu, 30 May 2019 23:00:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190424021739.20916-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping:

Who can take this?

On 2019/4/24 10:17, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> rtas_parse_epow_errlog() should pass 'modifier' to
> handle_system_shutdown, because event modifier only use
> bottom 4 bits.
> 
> Fixes: 55fc0c561742 ("powerpc/pseries: Parse and handle EPOW interrupts")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: fix compile issue by 'event_modifier'-->'modifier'
> ---
>  arch/powerpc/platforms/pseries/ras.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index c97d153..744604d 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -285,7 +285,7 @@ static void rtas_parse_epow_errlog(struct rtas_error_log *log)
>  		break;
>  
>  	case EPOW_SYSTEM_SHUTDOWN:
> -		handle_system_shutdown(epow_log->event_modifier);
> +		handle_system_shutdown(modifier);
>  		break;
>  
>  	case EPOW_SYSTEM_HALT:
> 

