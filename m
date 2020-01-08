Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F9A1347FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 17:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgAHQaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 11:30:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35359 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgAHQaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:30:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id i15so4180460oto.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eh1a1EgozWErHHqGLEoauZ/x7T61NxvHf+uJt4V80kQ=;
        b=FwyWURrqIQ0C0HxAT5peIN+VFqRhdOpFnD+BnKPivVYUgZUlygwN3d43ldYCCAt4eI
         fUX4xaVsekIOQsMGfHIVVWC2o6H+R3aGPRuCDvCjc56RXOOJ5hQc6+WMeTZMAM2Lx4fU
         u+ir+YS5E9cpgFs0ZlGPIVMmr2FXvsS+sejKYwY1C2PNvdQs17pYlIHQqW1ZYK5iewjb
         cCDDewZV3rD30YmiYL3aMf+ks7mH7Y2LqcO2gOz4TqpPgWFBDEjvUh/y6208PT3ho53+
         DxfLnVyGXviK8VuH4XXmFWutM8ApIaFXEDV0LI2ppHtG9xaa4uccZi7ufCHz39x7JcZO
         mCDA==
X-Gm-Message-State: APjAAAVngpCv/iFtjrvhncMxkQIpyC69rB8k00478iGa19qQj4UytAm5
        P8FoNTL+powLpvERwtU+NVf/UEs=
X-Google-Smtp-Source: APXvYqxKsjx9+cwiBTktFXebBt0H8xPQPd+Y2hQEzTrD8HHEX023K4NyG5ueTwbyI7Aom8YgEyGMjw==
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr4923504otk.363.1578501021618;
        Wed, 08 Jan 2020 08:30:21 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k26sm1214456oiw.34.2020.01.08.08.30.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:30:21 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:25:49 -0600
Date:   Wed, 8 Jan 2020 10:25:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, sivaa@codeaurora.org, manafm@codeaurora.org,
        Rajeshwari <rkambl@codeaurora.org>
Subject: Re: [PATCH 2/2] dt-bindings: thermal: tsens: Add configuration for
 sc7180 in yaml
Message-ID: <20200108162549.GA24298@bogus>
References: <1577106871-19863-1-git-send-email-rkambl@codeaurora.org>
 <1577106871-19863-3-git-send-email-rkambl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577106871-19863-3-git-send-email-rkambl@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019 18:44:31 +0530, Rajeshwari wrote:
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
