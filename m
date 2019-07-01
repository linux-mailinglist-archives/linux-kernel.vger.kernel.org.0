Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77923110B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 02:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfEBAnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 20:43:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42245 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEBAnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 20:43:09 -0400
Received: by mail-oi1-f195.google.com with SMTP id k9so329533oig.9;
        Wed, 01 May 2019 17:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bukmIxK8IEy/YtJp/bpxf4EiePsmV2cQyyWujlkfkLc=;
        b=eU0fU0TO2W0Ux93MHA6Oy0dHX0f/bHp1SvwWfNgu+C3lEk+DkZfzN/Q25qKqXc1Iho
         nO5af/0Imt8kcSfFNB7G/tZhDvC3cNCHpUNDKhvcaY+WuY9tB/jO57Tztr8njsZ3pNVA
         UWd6FbyQHP+s9116ITsnTIBqHWwliNjXjKiX1aZNKMLWeVVVAGrGRm8H0+jcRQuEpEGk
         G9XU2pubj9g/enJYWp7AlT4xauLokpsXz+L6Zz8SD4y4AAAnD82w+iRCE030JlG8dZpW
         mAf7cMcZc20NMru3mZCCRgYS7V1k77bMhr3VIRu/K2dpiaJ+VcFqYag20J/yo3uW8TP6
         3k5g==
X-Gm-Message-State: APjAAAWlUMahOQEASfv6JLOQAVbBkBFce1R4X9hO7L8jSXO6WkC7vI8p
        P5X1DazX3PA0RA7nWvfjcI+8/mU=
X-Google-Smtp-Source: APXvYqy9E+QJpU1oozanErJqgUnj5732Fd0myVI673l7zTMtBzAUwPQZQGiDO/NpwbUc9wHnMQ6pgw==
X-Received: by 2002:aca:3306:: with SMTP id z6mr737153oiz.25.1556757789032;
        Wed, 01 May 2019 17:43:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o11sm320258oti.69.2019.05.01.17.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 17:43:08 -0700 (PDT)
Date:   Wed, 1 May 2019 19:43:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add devicetree binding for
 BM1880 reset controller
Message-ID: <20190502004307.GA2033@bogus>
References: <20190425125508.5965-1-manivannan.sadhasivam@linaro.org>
 <20190425125508.5965-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425125508.5965-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 18:25:06 +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for Bitmain BM1880 SoC reset controller. This SoC
> has two reset controllers each controlling reset lines of different
> peripherals.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/reset/bitmain,bm1880-reset.txt   |  18 +++
>  .../dt-bindings/reset/bitmain,bm1880-reset.h  | 106 ++++++++++++++++++
>  2 files changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt
>  create mode 100644 include/dt-bindings/reset/bitmain,bm1880-reset.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
