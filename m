Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38FDE18534
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 08:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfEIGOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 02:14:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33394 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfEIGOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 02:14:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id s18so3410077wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 23:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G2pFARh3jD41YsPZaIcRDmvVTe/jSjp+MpRky9XD4Eg=;
        b=eqeTUq9Ocp1R9Rjg1wN0c5jKiDqvsCwbgj7KfR3B2lLAEAYpUHpIVlwl+uGAH+W7ue
         6FSNSdzpuJZc8MmBxj5YszI/Mrzt7zgYrbiv6TPNeJeirpuDY6Hh2GT0CDMZX8k9vCrQ
         WSEc0hvWQbRt6dAO5QJ5J3yUMCpAjrLUEzsT0hGpCvuDCiPnZneDUfivhTkQ7FojsBZc
         ADEGBemkbUzbpZ9lW9U0WBKmM/Pgd8VxZ2MNaFDT1ACYDYbd82dHE4ZhtjEiyv8+/vTS
         mfC84gqO2kemvx7+nWaPa4iVFl1sQgwX3nScHhGFeu3BzbzybCqIrwOYPI+0b3+WTOr/
         RsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G2pFARh3jD41YsPZaIcRDmvVTe/jSjp+MpRky9XD4Eg=;
        b=WNgxBJes3G/QtlVrlmO0DvCpb2mDlpnpqFJetV5TYXhfVFjjuyaEonb5nZwSt1D4NO
         82zsrSAMO6lqeAJ0Kh+7J79W3L5PzxIvLGESNPUAqGfVYxblRfl8OZPUFlQRX3HPYI3N
         g52PwtGH/yVG4sNW0E/3e/dBp8DL40oI97IScwUEah4w2gYrq5u0Ont1dbeR4FVaDXY0
         1JTBsGCZgFZGN3RgZOS4mz/3BdY+Qvphmu2Q8++wYgM9+mq1P0Xoo4AR9LOIFLYA0Nhh
         ceK/Ta5lVd6Eo3ps1v7Z5KB8/pPMsitVZU3Q81M7XrBIrmuBXim7WupTCsy8GvrFXco2
         RwOg==
X-Gm-Message-State: APjAAAXgiZ83s3pUEXAyW6yR2oYpipQ74/CJ2V+tx4X++7cBK/Jo3uLc
        0WISvyCi9P4C7XaXl0gWC89yXA==
X-Google-Smtp-Source: APXvYqxPIY1jQd4apWassxYYY8E0vNc4BXFm7KQORVOgWIQh/Ycw0ajJvSoEbk5ioXZ8ypDLevQcdA==
X-Received: by 2002:a7b:c743:: with SMTP id w3mr1384464wmk.22.1557382485439;
        Wed, 08 May 2019 23:14:45 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id t2sm1104419wma.13.2019.05.08.23.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 23:14:44 -0700 (PDT)
Date:   Thu, 9 May 2019 07:14:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH next v2] mfd: Use dev_get_drvdata()
Message-ID: <20190509061443.GU31645@dell>
References: <20190508103202.GJ3995@dell>
 <20190508135257.134747-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190508135257.134747-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 May 2019, Kefeng Wang wrote:

> Using dev_get_drvdata directly.
> 
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2:
> -use dev_get_drvdata() instead of to_ssbi()
> 
>  drivers/mfd/ssbi.c     |  6 ++----
>  drivers/mfd/t7l66xb.c  | 12 ++++--------
>  drivers/mfd/tc6387xb.c | 12 ++++--------
>  drivers/mfd/tc6393xb.c | 21 +++++++--------------
>  4 files changed, 17 insertions(+), 34 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
