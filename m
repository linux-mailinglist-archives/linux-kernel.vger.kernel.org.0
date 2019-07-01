Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B6A10453
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 05:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfEADnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 23:43:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34915 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfEADnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 23:43:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id h1so7801543pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 20:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PZNK8TQA6QxASDcv10s+KmD7Rn3kLnmZaWKpog8pPPs=;
        b=DWZ3Tyz6M6dt6LbxZV1HGVLIzfXTQEEs+kmUxjPEnVWZ0cnnQ9Yj9SS3WgdMmR93R6
         DZwRjmuhrTuWH8lN3NvFeLB1zzh0I5qZonPMKc/g4KHXQE0kD8VHTIsUZVvnjQV4ImrD
         M93pCPAoXIXaZATvRh6tiKgnW3k0QputsjYvZNOIC0+PSyrC9f4JW84O4LA5SrCgq747
         iy29eonVGYCUzyd6Gt4DycC3Z6HmuoTWRU2F2/xq3Kymz+54dIqBqcNEtNPmIXCcR/GM
         tj3NghJvAHCGxO+mCCE3gEsL6gPDZdDbWy1RZP5y+PCmlT+u2zAJ8B/CpA61L7Pg/bQj
         Au5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZNK8TQA6QxASDcv10s+KmD7Rn3kLnmZaWKpog8pPPs=;
        b=VAqRZKhDul1jbk9LJ26tHFEgKgBIwspwf0Rm9r13KMjHPG8+mX/tjeTZEDYbwA0B2w
         VRRLD3yERyfLGct+TNrPdBoTXG8D0hE46TwbzMvBMX65cXGjNnyvgvSy5pUafyp9O+n8
         CBezgzWYFpCDLq/gU5+knRweOIndScSeLXZadcLTYaxle1L66Me7Eii+zL2kDYYlFvzr
         HoLgg3mtn019NqzAffmMSkLSJjdE39VFadnJ0N+rAqKAPSRU7tMiVDvgDntB9+47YXPZ
         dJDzPcxccCDzuJo41TVcFJI2pc1RoJEgyBhuIddy2XzpmgXsgGgbBL3Onk1fxUxovaKT
         ZZow==
X-Gm-Message-State: APjAAAUTX8PTIhCtHkBaqZPPXg5Iy0iYB49nCucbwMUM7H5juo6uM6/p
        N+UdYOnSPbiw2IcdjLj9wUnI+Q==
X-Google-Smtp-Source: APXvYqyIzd9mFhheIg0Jy9agsnkv1bpzxwGdFd9FfLoyMeJtZ4BIsJ13C1S1WTPgB7fVpH/TmgKvwg==
X-Received: by 2002:a63:6fcf:: with SMTP id k198mr70433161pgc.158.1556682194666;
        Tue, 30 Apr 2019 20:43:14 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y3sm15333736pfe.9.2019.04.30.20.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 20:43:13 -0700 (PDT)
Date:   Tue, 30 Apr 2019 20:43:14 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, agross@kernel.org,
        marc.w.gonzalez@free.fr, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/6] clk: qcom: Add MSM8998 Multimedia Clock
 Controller (MMCC) driver
Message-ID: <20190501034314.GE2938@tuxbook-pro>
References: <1556677404-29194-1-git-send-email-jhugo@codeaurora.org>
 <1556677642-29428-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556677642-29428-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30 Apr 19:27 PDT 2019, Jeffrey Hugo wrote:
> +static const struct of_device_id mmcc_msm8998_match_table[] = {
> +	{ .compatible = "qcom,mmcc-msm8998" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mmcc_msm8998_match_table);
> +
> +static int mmcc_msm8998_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +

Don't you want to wait for "xo" here as well?

> +	regmap = qcom_cc_map(pdev, &mmcc_msm8998_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return qcom_cc_really_probe(pdev, &mmcc_msm8998_desc, regmap);
> +}
[..]
> +MODULE_DESCRIPTION("QCOM MMCC MSM8998 Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:mmcc-msm8998");

MODULE_DEVICE_TABLE() will provide the alias for module auto loading, so
drop this.

Regards,
Bjorn
