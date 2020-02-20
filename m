Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9EF166173
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 16:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgBTPwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 10:52:24 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39160 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgBTPwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:52:23 -0500
Received: by mail-pj1-f68.google.com with SMTP id e9so1055430pjr.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+/WxyvwzefS6yg5iKEGluqHuzG/pj5Si1hZf4+0mRQQ=;
        b=i4puWcdvj1CWZtYIbzpGUOtJ5pIC79iIjAxMWCCZXdxq6G24+mGBTIIpnPCBHn0GNK
         WAdSvxkSCdvSQdp9mPapKBWY/kV3xMOpF+OhcGriTMhwNaieg2/upGs/gMBYJU7jUkYL
         EJM8Zl2RHkroltyGpXo2njZr5wkKWBHs4jsNOJTjSwWhKOSrn4hK033+7URfqA6fASVo
         VRqv1xhTq9t5LCC/tsHJlJc136PxLRUc2xF/eNLZvdLHA0mnMVcXzkvNAfTV7LBAAVVo
         KsWWXFx7m/oM5aks9F1su6hIUUJ6k2wPyhaPNDTQQq0U2jSlzth3PkhHSVgDK9vsxiaY
         bOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+/WxyvwzefS6yg5iKEGluqHuzG/pj5Si1hZf4+0mRQQ=;
        b=pt411EiyfYKMrw5zwyX8FEg/UZ/G8QJHKIaIynRe4fCH0q1cbhjDDwZ3eMpnuKzmij
         yytPoe6/kBZB1AxkaxLfvJqc7ohxjuj7/Bdv8Hd8EEuv/vl0UJCi1jZd8xowC6gDKNRx
         CiG5VrRGf7Hl0Fof2aWKKc0Divbf1kXLsXxWxX4iArwEDS+NqXGJoAOvQHtGLZxTT8JQ
         2tg7iUC5umyhYgFKYki3+w0n51kkXdcj9HfFxk55jeY95gjEsg84suY1iskWrlpGF8da
         YjTsg5v8cltXM52bHeP6wS+j0ck+v3r9ljLkIy0Wsbtkf8aVuIC/3AyxkCwkPXdh8xQv
         A8Ig==
X-Gm-Message-State: APjAAAXVUp8OqQtbPoFWSaZ6ZTYRt0dPnE3yDKT3ESaqyYraI9ePHoxB
        T5el5eqq8ERpULeG87jOmvlbGA==
X-Google-Smtp-Source: APXvYqxJJRxwW5yt25an2UYEwvvA6N2u9Fzw+67nN1An6ph5EUR36LLQWDArLfHBLz9LPNR1QNd6LQ==
X-Received: by 2002:a17:902:9b8b:: with SMTP id y11mr32790865plp.189.1582213942056;
        Thu, 20 Feb 2020 07:52:22 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s23sm3774686pjq.17.2020.02.20.07.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:52:21 -0800 (PST)
Date:   Thu, 20 Feb 2020 07:51:26 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     adrian.hunter@intel.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, ppvk@codeaurora.org,
        rampraka@codeaurora.org, vbadigan@codeaurora.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, mka@chromium.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-mmc-owner@vger.kernel.org
Subject: Re: [PATCH RFC] Toggle fifo write clk after ungating sdcc clk
Message-ID: <20200220155126.GC955802@ripper>
References: <1582190446-4778-1-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582190446-4778-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20 Feb 01:20 PST 2020, Sayali Lokhande wrote:

> During GCC level clock gating of MCLK, the async FIFO
> gets into some hang condition, such that for the next
> transfer after MCLK ungating, first bit of CMD response
> doesn't get written in to the FIFO. This cause the CPSM
> to hang eventually leading to SW timeout.
> 
> To fix the issue, toggle the FIFO write clock after
> MCLK ungated to get the FIFO pointers and flags to
> valid states.
> 

Please don't provide cover letters for a single patch.

Regards,
Bjorn

> Ram Prakash Gupta (1):
>   mmc: sdhci-msm: Toggle fifo write clk after ungating sdcc clk
> 
>  drivers/mmc/host/sdhci-msm.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
