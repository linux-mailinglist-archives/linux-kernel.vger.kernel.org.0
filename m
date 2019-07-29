Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11CFF78F75
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 17:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfG2PhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 11:37:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44395 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfG2PhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:37:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so28448485pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Is/zMn554z9J2hxXreLy6XnJ9I6/lu0GO7rlFj5dIE=;
        b=CMiwYhMpeKX7zrj+EhHrELRJlZUUODDg6GvKOLaBfZXN5KAyPrQlwIcseruoh2UEDK
         xbogLEb7lmZfGuO0CEijgBkAzICvFM5Gb6IskDvwdRNha93OUJ2i4YykRzSAqXiTLtTT
         q6npjS0ceX9rYd3VW6cT/STqIfH8XMDBkMO202zXPTC41za3yHZDRmoD7hwn9pRjUh2j
         gWEK5ZZBxzNPc8Qo+dTxGgBa8tDhFfYNSyXFglSRO336K5Real7ddhf02f856DbZraSW
         jGEMygrhtb4JKsJOh1Rr1rgZU5jal0fDc+iRzG4Vh8cQ/oEtRdQ1eMIQJS16VC23+hcG
         L+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Is/zMn554z9J2hxXreLy6XnJ9I6/lu0GO7rlFj5dIE=;
        b=Cfs4MbPt9hQa8dhhGo5F00f2qHJPC+P/8Z7PO7ShuLH0fTnkwLv0ZeMmwrI85NeX6v
         z8zUPbLkSXvrifBeZ2U/YjiMUQZwoXN1yUwZ+hR8V5kB1d7nu12oen/+MSXXClxNwpL2
         Ss/tse4beeBo6Nz5X17Zybp1lBT+7dD0LW705eLltUVTay6MOivD7TM7rXGw9cZtlM5b
         /qrscMFxhZDOdGbGtOlSUhq48Qpfw4ytkEISUZMjlHgIIY5VVTkF2s/Msm3oTzyOuWzL
         1v5BayR1Dx5nFsiGG1sGg/XN0WHxhlWXXg9LTGxnQbmBPrl3T21Ea5Idy6UnOdjcLKb2
         hbUg==
X-Gm-Message-State: APjAAAW8jL2y6ItNlXskn9tIvzZUz+wniBPM+p6z47u9JjbWzEozDdFY
        QblkGNUwWBn5ccysYUa7Bh3auhuz7i0=
X-Google-Smtp-Source: APXvYqyZ2izgeK8bZ2+UGCtJI2YDwDB+LtG/0K711MB8HWKCgCebhIN2V/5yP2YiYDSfGUrDUp+3zA==
X-Received: by 2002:a63:9245:: with SMTP id s5mr106816006pgn.123.1564414622544;
        Mon, 29 Jul 2019 08:37:02 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z24sm109475644pfr.51.2019.07.29.08.37.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:37:01 -0700 (PDT)
Date:   Mon, 29 Jul 2019 08:38:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, vkoul@kernel.org, aneela@codeaurora.org,
        mark.rutland@arm.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        clew@codeaurora.org
Subject: Re: [PATCH 0/6] Add support for Qualcomm SM8150 and SC7180 SoCs
Message-ID: <20190729153826.GT7234@tuxbook-pro>
References: <20190729120633.20451-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729120633.20451-1-sibis@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29 Jul 05:06 PDT 2019, Sibi Sankar wrote:

> This patch series adds SCM, APSS shared mailbox and QMP AOSS PD/clock
> support on SM8150 and SC7180 SoCs.
> 

Thanks Sibi, this looks good.

Could you please update the last 5 patches to ensure/maintain sort order
of the lists they affect.

Regards,
Bjorn

> Sibi Sankar (6):
>   soc: qcom: smem: Update max processor count
>   dt-bindings: firmware: scm: Add SM8150 and SC7180 support
>   dt-bindings: mailbox: Add APSS shared for SM8150 and SC7180 SoCs
>   mailbox: qcom: Add support for Qualcomm SM8150 and SC7180 SoCs
>   dt-bindings: soc: qcom: aoss: Add SM8150 and SC7180 support
>   soc: qcom: aoss: Add AOSS QMP support
> 
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt      | 2 ++
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt    | 2 ++
>  Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt | 5 ++++-
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c                      | 2 ++
>  drivers/soc/qcom/qcom_aoss.c                                 | 2 ++
>  drivers/soc/qcom/smem.c                                      | 2 +-
>  6 files changed, 13 insertions(+), 2 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
