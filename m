Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7D4F3785C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 17:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfFFPng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 11:43:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44177 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbfFFPnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:43:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so1730736pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BfrnQRYKGFgPxF9NSnQflkQWl1ljH2e27gVbldpoCtM=;
        b=G526VcO+jFeP1Kp96oisydppUTR325SAabfAj6XffQwSmnnk1fpfZq2JNrtma3sq9V
         bUQ+A75ziJPPn7hBRksbtk+T6Y9IgGhi5PQaRPJHuJDgvXlkHzG69IUtJZT2vxcD+jqE
         t/h4GMZ5MtaRvM/RjnGdut6SKYqwSYoKWOciJ1uayYOVVUbw5tYFWmPuKRdIl1WHJfwW
         /L6d8b274D1jaWJ8kXV1ogOTs61jy5TB7/STFsPpt+jchl+bIVBKyDB09fNNGZjkYCsF
         VsJ5Y8KS/bPkMbj69HoTBAUL4pgmylrnY2BrgmEpPlDSmvY1EYT46qNmYRFSNpPSKn/4
         LIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BfrnQRYKGFgPxF9NSnQflkQWl1ljH2e27gVbldpoCtM=;
        b=hQebzBfIgsVeKbob1d3quZ6MBr1Fu1xImV62lsoaHA34uGL7G5bFAtZS4UHUOdRUsO
         aHt2aIg2tyxlE96EhrsqujFai4UXAj3SGEwuYG8y6UkiQanA2az/rr3qBUpd06NXQKmm
         pIlN2VpRwESiGrOIITbMjvDGN7eH2/IXHrcCy773k6/w8vGAsvQaw3Sos90dCsRGTbes
         7wOaJYqb+/W1/coNnHOtzp6B0bHDhxElqH381FO7l4DB9R8gF5hHJIav2D96ba7TMcmy
         M2s1qTVAmLAyWz/t37x0fFyfPTPnncdmvuFyTpZltrj5Y3QTfwXIwDyyrffKKSlRn+6L
         A8HA==
X-Gm-Message-State: APjAAAWfrrEUiwqHAA+GtLHE8ZPudk88OldN4FiyOxUFyODPpGc/SeuB
        8U5i7IS6nbsKdlAq52ewecQl/g==
X-Google-Smtp-Source: APXvYqx+sT+/LQuM4S09B7Xt9KV37NrCwBh8IBko+fhwQpGMCytJTR8ZRG5FS309mJBurHzccGKhDA==
X-Received: by 2002:a62:386:: with SMTP id 128mr55122544pfd.10.1559835814740;
        Thu, 06 Jun 2019 08:43:34 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v64sm4919401pfv.172.2019.06.06.08.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 08:43:34 -0700 (PDT)
Date:   Thu, 6 Jun 2019 08:43:32 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] remoteproc: debug: fix va dump format in carveout list
Message-ID: <20190606154332.GB23094@builder>
References: <1559835519-8165-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559835519-8165-1-git-send-email-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06 Jun 08:38 PDT 2019, Arnaud Pouliquen wrote:

> Standardize dump presentation for va, dma and da dumps by adding
> "0x" prefix for virtual address.
> 
> Fixes: 276ec9934231("remoteproc: replace "%p" with "%pK"")
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Applied

Thanks,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> index 6da934b8dc4b..91d3a75f0b41 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -298,7 +298,7 @@ static int rproc_carveouts_show(struct seq_file *seq, void *p)
>  	list_for_each_entry(carveout, &rproc->carveouts, node) {
>  		seq_puts(seq, "Carveout memory entry:\n");
>  		seq_printf(seq, "\tName: %s\n", carveout->name);
> -		seq_printf(seq, "\tVirtual address: %pK\n", carveout->va);
> +		seq_printf(seq, "\tVirtual address: 0x%pK\n", carveout->va);
>  		seq_printf(seq, "\tDMA address: %pad\n", &carveout->dma);
>  		seq_printf(seq, "\tDevice address: 0x%x\n", carveout->da);
>  		seq_printf(seq, "\tLength: 0x%x Bytes\n\n", carveout->len);
> -- 
> 2.7.4
> 
