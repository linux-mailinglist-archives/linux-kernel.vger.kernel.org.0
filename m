Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13253D460C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfJKRBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 13:01:22 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46841 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfJKRBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:01:22 -0400
Received: by mail-oi1-f193.google.com with SMTP id k25so8556323oiw.13;
        Fri, 11 Oct 2019 10:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mZ12ktNjFYLHaQldgcLq5YbkCfRxwml6HBzJyQjPFcc=;
        b=gdXGX7C1S6L0tPeUPf0gsfA6AlUYpW488w7zWYijjsAUvIY725+SHCj0/FIde0qri7
         Wxl46IO4ppq7+1nltLFEuuRnaoc4KxutjzbGmQgKc80LtwvYZ5f/WO5Rb5QOuUBfCCsj
         1hhWYt5cCfCNY3funOk5daKMO2MfnaB2OrxIVyNNqBcA4ZVwKROpw0NbV2EQdX7KlDY6
         agorEG9q3qyHAZbolMKeFUVgMvvjgCEdcjeZZjma+srrxl2S2ookSgVh0V1Z+PRRCzZw
         6hCeqmcUA66QOGnuORk1XcSU+kLPjneawQk1sAti+28E6pqWxugcJz05DASldSxcUMBB
         kxoA==
X-Gm-Message-State: APjAAAWDGzs466XY/317TsoiVSVxQ6H6POc2qaFLl/LJd0dejdA9n5dD
        EcL3bG1d9YxWLVe0VcXaKA==
X-Google-Smtp-Source: APXvYqw+dKHsoqTOnX9vla/BlNQ96S8wiRdesNaBW3u1/5nYILYHP7qaKXZdqjpYAEGQlNkuonbBlA==
X-Received: by 2002:aca:f1d7:: with SMTP id p206mr12295309oih.119.1570813281285;
        Fri, 11 Oct 2019 10:01:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e5sm2889559otr.81.2019.10.11.10.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 10:01:20 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:01:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, joel@jms.id.au, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add AST2600 RMII RCLK gate
 definitions
Message-ID: <20191011170120.GA15442@bogus>
References: <20191010020725.3990-1-andrew@aj.id.au>
 <20191010020725.3990-2-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010020725.3990-2-andrew@aj.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 12:37:24 +1030, Andrew Jeffery wrote:
> The AST2600 has an explicit gate for the RMII RCLK for each of the four
> MACs.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  include/dt-bindings/clock/ast2600-clock.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
