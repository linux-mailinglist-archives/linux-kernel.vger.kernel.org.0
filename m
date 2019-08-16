Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69F5A90A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 23:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfHPV4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 17:56:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37912 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfHPV4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:56:36 -0400
Received: by mail-oi1-f193.google.com with SMTP id p124so5867161oig.5;
        Fri, 16 Aug 2019 14:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MLNRFFmpTvrqSDHiMfXO3TRwp39rLs8A8Qp25LwfFUY=;
        b=XFXdufDui0ZS3nM2gvUQ7XRHYnXMGZ2biX1oKVcuM5zfhXLelkjbEt/crRgFTewqAy
         yerbC3vKSR6ZhupkprzWtBUTbf+AhQwMlQVCbrWAkYAeSBHqV8TKHTFcH3sT17leQp1l
         +xGvmNKx3pnUplgwQ0vMr7DA/s0V2BnY9/nFlQ8fzUS+8D3wZ3THcLXR7ZafdGbhi9nJ
         3EoMXBOJVw2c9lUSxv1XuNihzM/ce57DRlp7QmDS4X4va1i9HYkGYku0uNRQxyhyqLYU
         YPaITbE3NFC30mrM1zx+Urb5YnXl2jX/1NN/3XRGGQ3iMxbEMMo/h3S9RHEfhOetRwBN
         eKZA==
X-Gm-Message-State: APjAAAVTBugvtBXR1e02qElZhV3XqQ+z2rKOsxfh7PTyRTmN64i7pAH4
        mwyULL5+2CboFHDTSHX/cw==
X-Google-Smtp-Source: APXvYqzlznvCGz1N4E1Fpj7MifRqPLUCf6KBStqQYaMHY4iD8GX4e7vLPMkqy9YRZXPTtKDG6QXJYw==
X-Received: by 2002:aca:c008:: with SMTP id q8mr6452653oif.135.1565992595767;
        Fri, 16 Aug 2019 14:56:35 -0700 (PDT)
Received: from localhost ([2607:fb90:1cdf:eef6:c125:340:5598:396e])
        by smtp.gmail.com with ESMTPSA id p11sm2451178oto.4.2019.08.16.14.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 14:56:35 -0700 (PDT)
Date:   Fri, 16 Aug 2019 16:56:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: pci: pci-msi: Correct the unit-address
 of the pci node name
Message-ID: <20190816215634.GA10885@bogus>
References: <1564306219-17439-1-git-send-email-bmeng.cn@gmail.com>
 <1564306219-17439-2-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564306219-17439-2-git-send-email-bmeng.cn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2019 02:30:19 -0700, Bin Meng wrote:
> The unit-address must match the first address specified in the
> reg property of the node.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
> 
>  Documentation/devicetree/bindings/pci/pci-msi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
