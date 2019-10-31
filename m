Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 442CFEB817
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 20:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfJaTnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 15:43:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39791 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfJaTnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 15:43:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id t12so3156138plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g1if5nriHYRKv6a330swRl8Fwtu7wBAUyc8gaOYrmSI=;
        b=o2wezMlojw5AoM6sew3VYJIMktLGzoiC+uc4MBI1+72/GXmhWfmE/8uXKlj/sHwyHu
         dBxpdxGsGk495zOn3vydx+mbleQhPMlcYNL48AqTMi7ddJE5rfKdVGs/NEPDtB35gISr
         5iGkl5x+PQzbgOXN1Ym+gFPAt/tbBmsXnYE6ir+FOE/gsuRuVB0cEBVx3fEtvgEMZPws
         hW2vNImzraxelY/u/Ce+uTmlCY1bTjZVrapiJyEzBOIb46Efcbw5Eb1cqZ9CnhkaPYmW
         yTJQprJ8r7gCRqrM7pP+9Z/Bh+y9dpVWbiYdQu5TIvbjA2S3cA/hh97n24CoYWmZpKBg
         ijNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g1if5nriHYRKv6a330swRl8Fwtu7wBAUyc8gaOYrmSI=;
        b=HAQPH6D8tXdt32sWAJK/UKHZ8zzlHw5jGjcv7yGGpmImJF/ejxiKt8T5G2BxgjUJ0v
         dX0m+WAw08tLDLIhlvrj17MV+mRvI9pA3yPpcFHPkdq5Li5hHYA3hZRK0u5c0Mk/SxUm
         25L4Bgt4BriN2Vg57J4bcX36lN6rtI2LiAbVMggFXZt3C/6HWmlxOr7g7pFL93NqE9ro
         WO9Ha65onI4zrsRDcLC+naOY47PqTABtZfDbGOEKtKPsvtu3B30ipjuaQBrWJOiiA8tc
         1WeaNnhtMZ3koWup4KFP8iE6IZ89ZY8toYVXQ4g60M8aSUs262xNhxZCPsgvJFUDBjMw
         d5Fw==
X-Gm-Message-State: APjAAAXQNGUMg43TvFG5vQ7A4K2IpH7Q6QepnMpucYIyrJvMdc/sLGV5
        5HjGtffdWjWGjk6FJW6eCjlWbzmObNc=
X-Google-Smtp-Source: APXvYqz64LJZBCZi7IJmZoG7rdqd0c1/7p4In5Sa3aXBlDsYKhtwYQ/LjV5W4ctHdcCx62Czq2THzw==
X-Received: by 2002:a17:902:7783:: with SMTP id o3mr8154786pll.313.1572551030893;
        Thu, 31 Oct 2019 12:43:50 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z4sm5616342pjt.20.2019.10.31.12.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 12:43:50 -0700 (PDT)
Date:   Thu, 31 Oct 2019 12:43:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] remoteproc: qcom_q6v5_mss: Don't reassign mpss
 region on shutdown
Message-ID: <20191031194347.GO1929@tuxbook-pro>
References: <20191031184632.2938295-1-bjorn.andersson@linaro.org>
 <20191031184632.2938295-2-bjorn.andersson@linaro.org>
 <CAOCk7Noq8dvKsWzAfAXRGhmoMG4_tHD0kw8_KVEBvyjm_fGc5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCk7Noq8dvKsWzAfAXRGhmoMG4_tHD0kw8_KVEBvyjm_fGc5A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31 Oct 12:36 PDT 2019, Jeffrey Hugo wrote:

> On Thu, Oct 31, 2019 at 12:48 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > Trying to reclaim mpss memory while the mba is not running causes the
> > system to crash on devices with security fuses blown, so leave it
> > assigned to the remote on shutdown and recover it on a subsequent boot.
> >
> > Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem ownership switch")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> 
> Excellent.  This addresses the issue I was seeing with the Lenovo Miix 630
> 

Sweet!

> Reviewed-by: Jeffrey Hugo<jeffrey.l.hugo@gmail.com>
> Tested-by: Jeffrey Hugo<jeffrey.l.hugo@gmail.com>

Thanks!

Regards,
Bjorn
