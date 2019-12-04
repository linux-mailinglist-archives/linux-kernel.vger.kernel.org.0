Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCCE113551
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 20:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfLDTBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 14:01:20 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42628 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfLDTBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:01:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id j22so234824oij.9;
        Wed, 04 Dec 2019 11:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r+Knz4MyENgBauzAurW2Z6R5O7gCJrRGn09yM5JkLrg=;
        b=NNzJwt1T2pVB9YggVtdSGtw/u4O8W9tV8F7Ee+M39r5uQo3nSg6kDK471y8IZGEPYJ
         zkbWIoBjpViNgz6c2k5oL8s9zKr1LRoAF7APNWdqUw3q5aFauVrRx7/wJWAoFtzqyZaU
         RmNAbkPfA75evIUGwy8ZkGgUG/gp8f8kUvpQYHtp00iJqIn365DxG9bOKAh4is8jDURQ
         h3fB8ZJaETA9bNFXLg4wd5FMqVzS6Wu9RKjzZEqkXRsKAkB9imARUZdg8BSWKgjtyQyJ
         rBOk3S1U90H2R3CIEKdf4eOga+PajdWEAVVt5rqOEN+Cy+uzRti1/zZm2fcU7vlsWcOA
         ekTw==
X-Gm-Message-State: APjAAAXKz+u/x5NCpkdZsqTVStmoZ4JU/sBOGmEeoxyixltAIgwcPYBy
        4ldAtwyyKevkt25iXYkibQ==
X-Google-Smtp-Source: APXvYqyaHVSgRRfXaE/jHqQeLeMpOPe0UJG4spkvdr76QInpH+RixZhPrk28zWuEjpN8gLV0skGkqQ==
X-Received: by 2002:aca:3755:: with SMTP id e82mr4116064oia.19.1575486078517;
        Wed, 04 Dec 2019 11:01:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b3sm2583051oie.25.2019.12.04.11.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:01:17 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:01:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v2 3/4] dt-bindings: vendor-prefixes: Add "calaosystems"
 for CALAO Systems SAS
Message-ID: <20191204190117.GA29217@bogus>
References: <20191120181857.97174-1-stephan@gerhold.net>
 <20191120181857.97174-3-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120181857.97174-3-stephan@gerhold.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 19:18:56 +0100, Stephan Gerhold wrote:
> The Snowball SBC supported by arch/arm/boot/dts/ste-snowball.dts
> was made by CALAO Systems and uses the "calaosystems,snowball-a9500"
> compatible. Prepare for documenting the compatible by adding
> "calaosystems" to the list of vendor prefixes.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Changes in v2: none
> v1: https://lore.kernel.org/linux-devicetree/20191120121720.72845-2-stephan@gerhold.net/
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
