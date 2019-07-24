Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F1874007
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 22:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389849AbfGXUg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 16:36:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35884 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387422AbfGXUgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:36:55 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so92538127iom.3;
        Wed, 24 Jul 2019 13:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ezauUXaQEEHVy+2OcDcxOeDrntwiw+XADj/ab5JOeyk=;
        b=L3BfcWfCFoSyrrt9J3Jv5g1ROUg0JMjyjIaowWHkX0kqo/QLy7yQxT/yRuXubPkc8Q
         N4iCUjyfmiPp/7DUHJ/xh8MomUhlXbVcY8kAe3BJ8WqHISyz2hVoHTwJwJOmCGPZybg4
         eAmlrphVY06Qkw58R27q3DgpHCpJQ/39KjuGh4fOSrR63pB9qD3laW6CrfK8k3ctzp/x
         HH88XvjgVIjRvKXoTSzoS22m2Ci+w37yBOCSWUWIrqonZBpq0L0lHoLhPkSJrHAHt4in
         eizGcvhYFbwqp9eVrxtyHaWkpc8YLViPe9Xci6hK3VkB/viBgz/fn8VEwZMAAK2sc6t4
         WsDA==
X-Gm-Message-State: APjAAAVIOfq8DFxizUEqORjnF7h20BV9pGAF0LUiVd6SdLllWMYnvsjH
        zfyYCLh65gxBxjJAlufhjA==
X-Google-Smtp-Source: APXvYqxi6iYl7bDx+4SE5POY1hGXofqijIvqy6IHLDGPzYHohBVh4g3K/4amhnyALZl9eJN0E91egA==
X-Received: by 2002:a05:6638:201:: with SMTP id e1mr7480694jaq.45.1564000614010;
        Wed, 24 Jul 2019 13:36:54 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id b8sm38661034ioj.16.2019.07.24.13.36.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:36:53 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:36:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Hanna Hawa <hannah@marvell.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: iommu/arm,smmu: add compatible
 string for Marvell
Message-ID: <20190724203652.GA27065@bogus>
References: <20190711150242.25290-1-gregory.clement@bootlin.com>
 <20190711150242.25290-4-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711150242.25290-4-gregory.clement@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2019 17:02:41 +0200, Gregory CLEMENT wrote:
> From: Hanna Hawa <hannah@marvell.com>
> 
> Add specific compatible string for Marvell usage due errata of
> accessing 64bits registers of ARM SMMU, in AP806.
> 
> AP806 SoC uses the generic ARM-MMU500, and there's no specific
> implementation of Marvell, this compatible is used for errata only.
> 
> Signed-off-by: Hanna Hawa <hannah@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
