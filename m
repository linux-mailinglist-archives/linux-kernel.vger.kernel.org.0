Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5A4145A75
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 17:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgAVQ7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 11:59:55 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41378 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVQ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:59:55 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so29777oie.8;
        Wed, 22 Jan 2020 08:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MDfiBL9hRIkQihktjqWJHDulsuoBJ4pn4Oh6gdd9G/o=;
        b=BIxbQFRpL9/7x6Cj6gIxJYC4go+KlEF3aIAHdEpfWQuAyR6o3SMpV5rOPhZGdyztoi
         gWfYPyu1rhQ16FQUBrRJEbmqS/0WUy3r+A9aZooGlR1DAnLDx+sMNmrsW8wBaF/V5O5J
         ij9gt3CXoBOCvMIaXv3DjqLwxTb7bhL6G+ZhdaYoYCHXuWO5RkK58KlUwsPav2BOnvMX
         hpTP8a2IzMDI0oLy1l1ftRI4niUhxBMG24opfh0au/ei6wjbkkEaKffqC7jmFMQwgW3O
         vRjZcD0rTnMNulz9iURTKUNwLTpus+0J6+R8ujC+fxbABjabhNxuZB2VfbzhZTa1a1iT
         aSpA==
X-Gm-Message-State: APjAAAWv/FVqN1L50J6gfHuEkayD5kAr9+kAFPwK0hG/1jLrDBJEdV8J
        nRoVT/CrmsRMSzuphFL7zAJHZAo=
X-Google-Smtp-Source: APXvYqy/buEH2irQzHZ7iB8zOrFJTgu/RpXFmiyIgGAQ/cqqf+k0u1vTUvftpZN1fotzOGFfgb9/EA==
X-Received: by 2002:aca:5490:: with SMTP id i138mr7622913oib.69.1579712394590;
        Wed, 22 Jan 2020 08:59:54 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j186sm13213861oih.55.2020.01.22.08.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:59:54 -0800 (PST)
Received: (nullmailer pid 8001 invoked by uid 1000);
        Wed, 22 Jan 2020 16:59:53 -0000
Date:   Wed, 22 Jan 2020 10:59:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 1/3] dt: bindings: brcmnand: Add support for flash-edu
Message-ID: <20200122165953.GA7321@bogus>
References: <20200121200011.32296-1-kdasu.kdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121200011.32296-1-kdasu.kdev@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 15:00:06 -0500, Kamal Dasu wrote:
> Adding support for EBI DMA unit (EDU).
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  .../devicetree/bindings/mtd/brcm,brcmnand.txt          | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
