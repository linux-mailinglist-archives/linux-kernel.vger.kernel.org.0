Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 522A016FDF2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 12:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgBZLiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 06:38:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35944 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgBZLiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:38:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so2675399wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 03:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mQFv2ptApTIAiUn/IDnNgZylYWpvb4JaReKMP2qGRB8=;
        b=TSDY4K1jK4zC8azCDNMC5WXyxnatPyfc/pal1j+EIbnQKW2zaRx9qYncNZj9heQkOO
         JPA+Ec8cjsQg6KPJTGTR298QW22hIk2vO2pSGBmthLDnIMXTxfy4D5uUGGeH/dYYm0ud
         eMcAg3Bu9XFBTe55fTumqTQ3Wa7el+GPollNpMOMT2TW/Qvto6SaX5A8pyz9WNbivBlr
         vFofurtnEsP0LMC65L6LOWe/25tOhrBG5tmt7XQ1Q7ePkCKHLhS3dVhxEPoemgBU+6FQ
         hgqDhOq0ydIzX+XqKIKeRoM+qkoUsa9SbbsP/GG/pObX16rdcmO2HtjTUv2aTs5/gHkc
         +VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mQFv2ptApTIAiUn/IDnNgZylYWpvb4JaReKMP2qGRB8=;
        b=YBxZddk8aRrrU69GwV9bbSxYjPTRYd1Zwz/hwiw7R1L8yU2YyoJvHCtX53Ida18C56
         RzcjWSWbAGd6g1tPeqzCY1dE5+FiwQexMMs/pj4YpD9FSjum3le2z3fJZKltLyE5Lq/6
         5gwmZnwcaCJFHXcSIK+Qr2etXBuNbNY+lmN/X/AFbMSYXhluXfs0wEBxFl/1GLHfOvc7
         E9IyIzA1Lqi1pMVuI5dzGjv0Tqqz4LWhpodUrM3CD+iH0T8RtRGLo4m4iUwumXFSBldz
         3nlcetb2srQVx766LPuo+syB1VaNr8VVDhTtkL0m+06RZRGQLDIq9uFEFkA7DW4j3yyn
         yVVQ==
X-Gm-Message-State: APjAAAWj5ne5dYw+4bZW8NF+wtwBH7/7b0fpjTgjoypKsW4oHXYCasi8
        hr/rfRIYGzSsYVO4RnVqfbP5DA==
X-Google-Smtp-Source: APXvYqyak90IvO19aKLILtWxBiJdRlI2XwGyaViPcGIDLyWqQbmhah1/I7K4BB75W9pOuWCAz2jGYQ==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr5369132wmi.25.1582717095791;
        Wed, 26 Feb 2020 03:38:15 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id h13sm3391406wrw.54.2020.02.26.03.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 03:38:14 -0800 (PST)
Date:   Wed, 26 Feb 2020 11:38:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Adrian Panella <ianchi74@outlook.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: add smb208 support
Message-ID: <20200226113846.GM3494@dell>
References: <20200219163711.479-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200219163711.479-1-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020, Ansuel Smith wrote:

> Smb208 regulators are used on some ipq806x soc.
> Add support for it to make it avaiable on some routers
> that use it.
> 
> Signed-off-by: Adrian Panella <ianchi74@outlook.com>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 4 ++++

Acked-by: Lee Jones <lee.jones@linaro.org>

>  drivers/regulator/qcom_rpm-regulator.c             | 9 +++++++++
>  2 files changed, 13 insertions(+)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
