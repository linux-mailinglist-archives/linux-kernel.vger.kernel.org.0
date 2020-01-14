Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 419B913B1CA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 19:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgANSPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 13:15:17 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44368 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbgANSPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:15:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id h9so13496841otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 10:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5LSZFhjvkBvH4Jm+XH1uoBzxnQKONQoyfsFilqe6/1E=;
        b=GV3hixZ6AQySL2JcqNUjEtOR/4gXhFViHlB9kQs2hXvsHrE9wZMgxLM+bBMauDfy61
         7Z51eYs+BjgX9kguHUn7FNAF+6gvKzdw7yDi46b1Bq1n6j0W/sOPDJ7I3BeKzCmaf0Ry
         /dDZRnW3dCd8fzTMOkR+WKJdF+ZNkmnZ/bvYWoDjy5fiqFPQGUJccvFpl0I7PYR2lIoI
         aOwK+rjsoChIrwecCO3diX7o3lNw53JIYPlndsBtMJFpysZhOBFoEOznbMV0m+5LgQJ/
         xM78aZvoef1Gb9XYkpddsL1+g22mMQBK65az11cIbcUqN0Rw8U6sTYEn0+2Z2AD/Lu/p
         lQNg==
X-Gm-Message-State: APjAAAVkFkmUVHQMb0eFoTFeFfxSv6r4jKdM5p2rKk4JLAjdPM32asYU
        x5tiILZTmBei4KrJB3od7r1QVYI=
X-Google-Smtp-Source: APXvYqzZHhE3H7BgvkbaX/ZI/p+kRJ2RVpY+QesGlytgbvD0n4zUCLWB9JeQ7N30t5z+X/SsHCHGKg==
X-Received: by 2002:a05:6830:1bd5:: with SMTP id v21mr19007940ota.154.1579025716229;
        Tue, 14 Jan 2020 10:15:16 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i20sm5625274otp.14.2020.01.14.10.15.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 10:15:15 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22090b
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 12:15:14 -0600
Date:   Tue, 14 Jan 2020 12:15:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        biabeniamin@outlook.com, knaack.h@gmx.de, lars@metafoo.de,
        robh@kernel.org, Jonathan.Cameron@huawei.com,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: ad7606: Fix wrong maxItems value
Message-ID: <20200114181514.GA4529@bogus>
References: <20200114132401.14117-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114132401.14117-1-beniamin.bia@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 15:24:01 +0200, Beniamin Bia wrote:
> This patch set the correct value for oversampling maxItems. In the
> original example, appears 3 items for oversampling while the maxItems
> is set to 1, this patch fixes those issues.
> 
> Fixes: 416f882c3b40 ("dt-bindings: iio: adc: Migrate AD7606 documentation to yaml")
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Applied, thanks.

Rob
