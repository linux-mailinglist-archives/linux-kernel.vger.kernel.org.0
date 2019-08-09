Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D844880B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436874AbfHIRBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 13:01:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39274 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436813AbfHIRBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 13:01:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so45255240pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mQxrbMZs/P0o3fvXA6rWNom+DiEV73SK0CyreYYoeco=;
        b=g6XhQsxjBSHr7B3N+XAUtFobb0a6Qhe5NzHTss0Z3N6hg2Lj+w3Fc0+mmNK2ddfzvi
         ifdSm4AhQex1l9YpBOIBpix6YdbZOV3YEZwpEtlX6mo9FqK78njXXUYna5ZR0htvQx/y
         UKMsMYhVHHTqr8vrEKRG+NgGoxa4/GQCEA7LWdQniWGLP5Vat73a5CUg/j4noYI+DBHB
         w5ozBbNcUGYPs9kTfnRkyzATzV3yR/z7w6sn7p8gS61o5vb4HmQL6NB2JOd2qN8egQsq
         dTFxGmIo15mJ9xI0fyMSsjwVonsgWtbdqRBtGdBK2OKm4wl4HIq5vemoAlCnrSzrzVXR
         RrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mQxrbMZs/P0o3fvXA6rWNom+DiEV73SK0CyreYYoeco=;
        b=HGar83o745iLNd/mhyas3Jg016dMb6AbYcm05zf8vy/Y3ZJzTvmW5c2fQIOdkPx8x+
         JQdfTmnCGZniwVNtxpbPyP+NYpZYokYL9oxX4DFqZdL0Iyhtmxr8gMd5LDfDn7ynCD2k
         hKMWZlw4Gfjj80jBWOfXuEuOcvji+j3ziMFjnrARnl/CvmgNbc9QC0/F/aYQ+FGbsVIb
         sk/u7gjdHD0t43SZiB5A1RTxWnx/KhXIoqU8f83W2AJpYEbMc8Y4jZWubnn1IoZnAwe5
         LAALx3xoI44SDN6F25z3x1rHDTugE5RmHJuPOxmLYi5KZecSQQbZPCjq5B8JDmb7ig//
         GpIw==
X-Gm-Message-State: APjAAAUn3FgD4fmpptvTeM3mLXwCmtfG3biW6AEkkUOimY8gB5mUnSgW
        Rz3vTkzHOZ4XJWFFkPpAjRXbnA==
X-Google-Smtp-Source: APXvYqz/+EaQnfQKxiBOqQ5ZQQWWUCD2VOGKCRvqtpriP1SeTj/ziKt4NAn1mwADltF9GXsvm1S38A==
X-Received: by 2002:a17:902:e613:: with SMTP id cm19mr18634717plb.299.1565370108924;
        Fri, 09 Aug 2019 10:01:48 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 4sm111526529pfc.92.2019.08.09.10.01.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 10:01:48 -0700 (PDT)
Date:   Fri, 9 Aug 2019 10:03:22 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] regulator: qcom-rpmh: Fix pmic5_bob voltage count
Message-ID: <20190809170322.GO26807@tuxbook-pro>
References: <20190809073616.1235-1-vkoul@kernel.org>
 <20190809073616.1235-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809073616.1235-3-vkoul@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09 Aug 00:36 PDT 2019, Vinod Koul wrote:

> pmic5_bob voltages count is 136 [0,135] so update it
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index 0ef2716da3bd..391ed844a251 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -698,7 +698,7 @@ static const struct rpmh_vreg_hw_data pmic5_bob = {
>  	.regulator_type = VRM,
>  	.ops = &rpmh_regulator_vrm_bypass_ops,
>  	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 135, 32000),
> -	.n_voltages = 135,
> +	.n_voltages = 136,
>  	.pmic_mode_map = pmic_mode_map_pmic4_bob,
>  	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
>  };
> -- 
> 2.20.1
> 
