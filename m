Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E06C35F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 15:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbfJANj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 09:39:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41610 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfJANj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:39:28 -0400
Received: by mail-oi1-f196.google.com with SMTP id w65so1603901oiw.8;
        Tue, 01 Oct 2019 06:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KLHRZTdgmJ31FLV+CneDtjsb45WoIfxvw7NRmXa0ukk=;
        b=SqUuLPjxxrcNlmAOYFBF5wzXV6uXN3/98D7CeJ8WZ6F2uIoDhtaTGSSZcEPjbx4CbH
         8mgMhStUAQDvWOKms+SQNwb7fSId6c+c4ZQchxT6R1m18ju3A9KL7VnZrC/l8af3Vni+
         qHCXonyQ16KilEe3XzutuFpLBnXwH3UyUnqV6WW08EIx5r+oHknMGbhoGQhWSEsT5m82
         F2WqeC239cgI1ZwdenV1/pOmzTcRwvWBaJIw6FpxqjsyW2xM6rQWobRBHOrWmneLDjLl
         3TZi6ZdhbB2RQKA02VL5hTPhGFwNSkodveAk7Dejgidh40ch/Yhq4TeM3NAkFP0puav5
         XbaQ==
X-Gm-Message-State: APjAAAUiiRcwXTNPruHa3cXPsf0obPbUGC432+vV3ctPu/e6Sb3a472G
        VFe6geENx3aFUit2tQ3HwA==
X-Google-Smtp-Source: APXvYqzTSJLcgzzb/0m5cCOwspezBpAaf7U3FUZPelAKilntUhGtVSw7W2yg9hXJszyYW5Ya4alysA==
X-Received: by 2002:aca:df88:: with SMTP id w130mr3890865oig.0.1569937167125;
        Tue, 01 Oct 2019 06:39:27 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w201sm5101599oie.44.2019.10.01.06.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:39:26 -0700 (PDT)
Date:   Tue, 1 Oct 2019 08:39:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: timer: Convert Exynos MCT bindings
 to json-schema
Message-ID: <20191001133925.GA13146@bogus>
References: <20190930154418.4884-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930154418.4884-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2019 17:44:17 +0200, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos Soc Multi Core Timer bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v4:
> 1. Do not mention interrupts-extended in the bindings (old bindings
>    mentioned only interrupts).
> 
> Changes since v3:
> 1. Use interrupts-extended instead of interrupts-map in example.
> 
> Changes since v1:
> 1. Indent example with four spaces (more readable),
> 2. Rename nodes in example to timer,
> 3. Remove mct-map subnode.
> ---
>  .../bindings/timer/samsung,exynos4210-mct.txt |  88 --------------
>  .../timer/samsung,exynos4210-mct.yaml         | 107 ++++++++++++++++++
>  2 files changed, 107 insertions(+), 88 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
> 

Applied, thanks.

Rob
