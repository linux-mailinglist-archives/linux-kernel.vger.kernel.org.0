Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D0090A83
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 23:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfHPVy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 17:54:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37819 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfHPVy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:54:27 -0400
Received: by mail-ot1-f65.google.com with SMTP id f17so10978851otq.4;
        Fri, 16 Aug 2019 14:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LQK1YNpKrRqTNadw9q2TukjM9xcTR6AiHeEW/jgprFQ=;
        b=l832exB7AxG6bd7zi2ut8yc8u1kSF0QYSzrcF0WaMVjZkzC/hkcWSe4DhzXBQq9lM3
         zaQh9K2ox+XTKJb0a1wBDRDlklSNAC7GIwGo0IvKrsab6LU1H/IPuhDcy+mA+QoQHYQT
         vCClhiQahA9Opum81z3u98yWHR5dgAd2JCIM1DyIepyiUQe8F4DwH7LLpr1nGMi2bA25
         B4erhZRgAHWFoMu+suAUcXeD1PnKxPRLNLLCrpegfPdFoyht5I07UJ7IRh77itaf41gx
         QY6PUokkzhBGAzyzNLLhQ2yd5dvqrdibQS0EyV8qanlO50VQOCy34NSm1oACXqwaOGHL
         TATw==
X-Gm-Message-State: APjAAAXb+x3dCXfdpApP1VsxReoeHecSdmR1MKOBKjydfU8ovLP4zios
        coOFvop4fAZdhqT8ZEtymzThdgU=
X-Google-Smtp-Source: APXvYqz/lsdwTOojsqCHvuDsuSYGnA8sPnKHSgaijtT3h+jhhEyfaoCy8dUxSRYlkwQaVvsOpif39w==
X-Received: by 2002:a9d:2c05:: with SMTP id f5mr8629647otb.90.1565992466720;
        Fri, 16 Aug 2019 14:54:26 -0700 (PDT)
Received: from localhost ([2607:fb90:1cdf:eef6:c125:340:5598:396e])
        by smtp.gmail.com with ESMTPSA id s22sm649110oij.37.2019.08.16.14.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 14:54:26 -0700 (PDT)
Date:   Fri, 16 Aug 2019 16:54:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: msi: Correct
 msi-controller@c's reg
Message-ID: <20190816215425.GA2726@bogus>
References: <1564306219-17439-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564306219-17439-1-git-send-email-bmeng.cn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2019 02:30:18 -0700, Bin Meng wrote:
> The base address of msi-controller@c should be set to c.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
> 
>  Documentation/devicetree/bindings/interrupt-controller/msi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
