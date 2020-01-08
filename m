Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C621347E6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 17:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgAHQZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 11:25:27 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41164 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgAHQZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:25:24 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so3112677oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yz35zFP2aSNw0+gIRfSaZMhcsEm+gudXf2tyLjffdvY=;
        b=n7nAnZOxb1mQwuBgopgbgAIm8HNICohqDbNV4OuNrnpq7h3XcwMyhfSZKkjM9XqBK8
         nxzMkdChSNTPypsjlkUJjw6+JwLnTV4bCU+INZAz7zWP8Dn/mPQ6Ks8IBfWF9dIIyBkL
         vb/ME4CqU1IDWxr4IY7INEwlBQz6WQIQxT1H+tuvCF0RKWDkUa6PIh6c4DUD4zqlgavO
         uXZbLnipAlYUr++L6HNMp+62ZeXktvIgeyp0IIGtSaddcx66FoR9ODmLHmTTQhLEZTOn
         BefhDZcVMbbrhyXS9fX76S/u4ep5gFXvXGLoqWnxPuzNVoUs2n25tva3O+NhLVNRw7yJ
         v9QQ==
X-Gm-Message-State: APjAAAUfOAXx60Ol2FQQF+sfwLJhFCjNMJn94e1liV3ArgbpwTpzQIjN
        44pXgEW7M92S2GtSIVilpa1agtc=
X-Google-Smtp-Source: APXvYqwiNU0tpNAdErI03OO34ED/Fycyilur+zXLh4esu3yvYxOdXQlqw+NwknojVEpNub1Q6eKQuA==
X-Received: by 2002:a05:6808:8e6:: with SMTP id d6mr3594177oic.78.1578500723393;
        Wed, 08 Jan 2020 08:25:23 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p83sm1204805oia.51.2020.01.08.08.25.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:25:22 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:25:21 -0600
Date:   Wed, 8 Jan 2020 10:25:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH 1/2] ath10k: Add optional qdss clk
Message-ID: <20200108162521.GA23484@bogus>
References: <20191223054855.3020665-1-bjorn.andersson@linaro.org>
 <20191223054855.3020665-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223054855.3020665-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Dec 2019 21:48:54 -0800, Bjorn Andersson wrote:
> The WiFi firmware found on sm8150 requires that the QDSS clock is
> ticking in order to operate, so add an optional clock to the binding to
> allow this to be specified in the sm8150 dts and add the clock to the
> list of clocks in the driver.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt | 2 +-
>  drivers/net/wireless/ath/ath10k/snoc.c                         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
