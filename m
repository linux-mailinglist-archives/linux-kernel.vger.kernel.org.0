Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D4515101B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 20:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgBCTE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 14:04:58 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:37654 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgBCTE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:04:57 -0500
Received: by mail-il1-f193.google.com with SMTP id v13so13591793iln.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 11:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=97aEmxESg/so8tXkPc073p79P/7cEPQ1fScRZgx/fXY=;
        b=E1ef4idqVp0c4TcX0CnKnMXmGEU6WuELl/R68FylR2HK5eki3rm/gsOBkVvK8voBkN
         wfsJlL4qWLX1zU2YEn08tQZDwqD38Umc1qpPMKx0pzk7xi9DX+abpJV8WhYz6LUgC6br
         chnS509h7vWCOFQA7kAk5cO1OxZ7TJEG6sTL6TwSM2M9mWLoR/Yhlt3Rd8aI2tPyVgHS
         YmymaGgZMzabRYsRZnuQjDZ0NfCf0eCd1ckh/plYUe6BdzvHFwIIvE0mj7MetbUbNqWt
         68Qi+8KY/MFJtvf8cNN5rk/NNzXH+BVnVhxZsFP5y59BLqX44OdsF9HGtPLhEq5JTqQO
         hzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=97aEmxESg/so8tXkPc073p79P/7cEPQ1fScRZgx/fXY=;
        b=RbWmsMnV7GJVFLxDUWQOmCVsBCfuOTXuPisKc89Xl7CwHweJQp9son/dnjdH1cG5ID
         UKscOQj88+PRItz/3U9RZL5nGr1PGYU/ASQX5KE/Vsj6O+qXKr0Ayi7r97muj32wtW5o
         2pdAPmhW8tem+jiJ7zhx2ZMeVpsXE7j8wOcih+/gtX9dclR0Yw5uoBQ+5cPOJhuV65f6
         jgYjCHjN+IFxqCeTIC0xRbK22IkszoAY5VlKuhzCOVhRPSImGkmjnIGRFsgCaZwdLHPM
         3tr93MjeB9fj6MH30ByFJDsA/rzvTla5CUm8wUvw7/cEtJJyzDb7kT4YJLLB6cBliiFO
         SE3g==
X-Gm-Message-State: APjAAAXP865Xrohhzs1xC2Z6iNMvKkW43dv/1SbZc6fAq9MmYiZ+e6+y
        8PvjxUH5zWJev/DeLzkkjBB2w3BmNlU=
X-Google-Smtp-Source: APXvYqy4Zg7wQ0KEOWah1d0pZpZmS64CGA4jRFd6aMNOh9S4n+gd4kx/+J9T2On7mYUuvkyd33h4VA==
X-Received: by 2002:a63:d442:: with SMTP id i2mr27690020pgj.349.1580756212037;
        Mon, 03 Feb 2020 10:56:52 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m26sm174673pgc.84.2020.02.03.10.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:56:51 -0800 (PST)
Date:   Mon, 3 Feb 2020 10:56:49 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Sandeep Maheswaram <sanm@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/8] Add QUSB2 PHY support for SC7180
Message-ID: <20200203185649.GK3948@builder>
References: <1580305919-30946-1-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580305919-30946-1-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Jan 05:51 PST 2020, Sandeep Maheswaram wrote:

Kishon, afaict this is all reviewed, let me know when you're taking the
phy pieces and I'll pick up the dts changes.

Regards,
Bjorn

> Converting dt binding to yaml.
> Adding compatible for SC7180 in dt bindings.
> Added generic QUSB2 V2 PHY support and using the same SC7180 and SDM845.
> 
> Changes in v4:
> *Addressed Rob Herrings comments in dt bindings.
> *Added new structure for all the overriding tuning params.
> *Removed the sc7180 and sdm845 compatible from driver and added qusb2 v2 phy. 
> *Added the qusb2 v2 phy compatible in device tree for sc7180 and sdm845. 
> 
> Changes in v3:
> *Using the generic phy cfg table for QUSB2 V2 phy.
> *Added support for overriding tuning parameters in QUSB2 V2 PHY
> from device tree.
> 
> Changes in v2:
> Sorted the compatible in driver.
> Converted dt binding to yaml.
> Added compatible in yaml.
> 
> Sandeep Maheswaram (8):
>   dt-bindings: phy: qcom,qusb2: Convert QUSB2 phy bindings to yaml
>   dt-bindings: phy: qcom,qusb2: Add compatibles for QUSB2 V2 phy and
>     SC7180
>   phy: qcom-qusb2: Add generic QUSB2 V2 PHY support
>   dt-bindings: phy: qcom-qusb2: Add support for overriding Phy tuning
>     parameters
>   phy: qcom-qusb2: Add support for overriding tuning parameters in QUSB2
>     V2 PHY
>   arm64: dts: qcom: sc7180: Add generic QUSB2 V2 Phy compatible
>   arm64: dts: qcom: sdm845: Add generic QUSB2 V2 Phy compatible
>   arm64: dts: qcom: sc7180: Update QUSB2 V2 Phy params for SC7180 IDP
>     device
> 
>  .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    | 182 +++++++++++++++++++++
>  .../devicetree/bindings/phy/qcom-qusb2-phy.txt     |  68 --------
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts            |   6 +-
>  arch/arm64/boot/dts/qcom/sc7180.dtsi               |   2 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               |   4 +-
>  drivers/phy/qualcomm/phy-qcom-qusb2.c              | 143 +++++++++++-----
>  6 files changed, 291 insertions(+), 114 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
