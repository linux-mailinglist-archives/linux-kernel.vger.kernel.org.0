Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4423930F90
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 16:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfEaOC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 10:02:27 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47972 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaOC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:02:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4VE2Nk6016233;
        Fri, 31 May 2019 09:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559311343;
        bh=X4G8CTwe6H4BU9Q2AlV5IeTINpOr1gEaiB74pbXls5I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ny+J7PBHlP59ZfM0ndebblQFBAe15C9shS8AyesYsL2YT7EiO7L3TkoCJpftkzW2q
         0AGSBkO9PV0f0nSQGwMeGBJILYm5ES1pxlB6UNRps3uZyXG6VwsOggj2KmjuSAewkt
         bx6f78kXoglW7D7GrqwYH0EU2Gmuukzt/L2n17NA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4VE2N4q072318
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 May 2019 09:02:23 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 31
 May 2019 09:02:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 31 May 2019 09:02:23 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4VE2N25033657;
        Fri, 31 May 2019 09:02:23 -0500
Subject: Re: [PATCH v2] hwspinlock: ignore disabled device
To:     Fabien Dessenne <fabien.dessenne@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Benjamin Gaignard <benjamin.gaignard@st.com>
References: <1552064026-11415-1-git-send-email-fabien.dessenne@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <b9059d73-9849-7105-6080-5d3d994335f3@ti.com>
Date:   Fri, 31 May 2019 09:02:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1552064026-11415-1-git-send-email-fabien.dessenne@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/19 10:53 AM, Fabien Dessenne wrote:
> Do not wait for hwspinlock device registration if it is not available
> for use.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
> V2: use 'goto out' instead of 'return'
> 
>  drivers/hwspinlock/hwspinlock_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
> index 2bad40d..d806307 100644
> --- a/drivers/hwspinlock/hwspinlock_core.c
> +++ b/drivers/hwspinlock/hwspinlock_core.c
> @@ -333,6 +333,11 @@ int of_hwspin_lock_get_id(struct device_node *np, int index)
>  	if (ret)
>  		return ret;
>  
> +	if (!of_device_is_available(args.np)) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
>  	/* Find the hwspinlock device: we need its base_id */
>  	ret = -EPROBE_DEFER;
>  	rcu_read_lock();
> 

