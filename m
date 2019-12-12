Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295C011D839
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 21:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbfLLU61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 15:58:27 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38296 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730895AbfLLU60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:58:26 -0500
Received: by mail-pj1-f67.google.com with SMTP id l4so29374pjt.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 12:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FGjQzF0iKScXXFdM9JyIEL8mVJUWt3ih5NTxXqTlgWE=;
        b=iVNKJCwr+xuHXTJtsLemsYjlS79bMKUifmCLbob6M3lvrmBC0K910BTYSyXsTSHW/B
         DO1gmpZMZFYVmXapGtfEwWetW2lkuTUkqPYXnr47RhMrCgYuv2VRuBZj6R/J+CW8EhPv
         /PZcnOW5zZoa4aCVtCzIj3X9nhks2xL8EmKyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FGjQzF0iKScXXFdM9JyIEL8mVJUWt3ih5NTxXqTlgWE=;
        b=Z6Vy7uUMs47l4Ow3xPouf8UpMgKKMl7SfKZv2d/gB3sTT4PYDgGT8prhx530mT/Ujr
         0QJL1TMlbmzOa0x5e3jLL1V1QLZOiQw/sgnHX7Z2u6GFYeaWhIQR07I2643/oJ9wgYIE
         iooYglbbHpzMUrC4eXvFYg8uFCT42X7BoGdN6NKvaKKbBHn9hPeqxufe+NYI+KHJs8R4
         DmPLYKldA7b9pSrNV2SPh41Yd081jgouWgVwlMydOv9IQMiM7aKcLgBQ+vY6FpCHnAsd
         0sxkORCZx6FxPKteglgrT2Xa+dZQdTQfZDymwAyr8mW4FnD7dVQE896rho3P1Attpz+i
         XfSA==
X-Gm-Message-State: APjAAAWk2yjydETp59R+idBZxFFQbaesYl31VHIrsGEi1DsH42o8YKga
        75gmcBOVweQBIlHelSqbP58z/Q==
X-Google-Smtp-Source: APXvYqw8d7KvyNToM0AiNFq3Pm1ocL+6ODQlQfYD5UvuACYtqwlHLA2yWKnFX3iNF+jHnoJEdX24qw==
X-Received: by 2002:a17:902:9a91:: with SMTP id w17mr11383362plp.96.1576184305763;
        Thu, 12 Dec 2019 12:58:25 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id k9sm6929652pje.26.2019.12.12.12.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 12:58:25 -0800 (PST)
Date:   Thu, 12 Dec 2019 12:58:23 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajeshwari <rkambl@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Fix order of nodes
Message-ID: <20191212205823.GT228856@google.com>
References: <20191212115443.1.I55198466344789267ed1eb5ec555fd890c9fc6e1@changeid>
 <CAD=FV=XD2GKPc5qeMakvW8Ej9-y7n0Hi2qAie-gUM=DJOSv6sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=XD2GKPc5qeMakvW8Ej9-y7n0Hi2qAie-gUM=DJOSv6sw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 12:45:46PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Thu, Dec 12, 2019 at 11:55 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > +               pdc: interrupt-controller@b220000 {
> > +                       compatible = "qcom,sc7180-pdc", "qcom,pdc";
> > +                       reg = <0 0xb220000 0 0x30000>;
> 
> nit: when applying, maybe Bjorn / Andy could change 0xb220000 to
> 0x0b220000 to match the convention elsewhere in this file.  That's not
> a new problem introduced in your patch, but it seems like it could be
> part of the same patch and it feels like a waste to re-send just for
> that.  ;-)

haha, I also stumbled across this and doubted whether to change it in this
patch ;-)

Sure, I can send a v2 that includes it.

> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!
