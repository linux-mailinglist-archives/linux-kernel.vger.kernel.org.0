Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 879B4982B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 20:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfHUSYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 14:24:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42665 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfHUSYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:24:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id j7so2962577ota.9;
        Wed, 21 Aug 2019 11:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xj642LOUuahy+rYAJ7XSvVLcFTloxyknrp7w0AGW3JQ=;
        b=LdoA16fh5oNqbW5smx5/Id2AzmtiAZWsNCNoujMtpTZ1B43ozOuBjlq1OO8i05qXUU
         5FoH9bVE3GKevqM+P2ohZlqZJ3hk2cVhpML3lTjoYSNtZmejdFjO941VxXg0Fl1ot8B5
         Jrnj/TmosYCZBYj1k3iPhoLQUI2iyZa7tP1iJlZGvL3+xrOk4yHvE+QW2P3rS7/m0PMU
         HOI70FYYBWJGdwO8Da18pQPpAGVLn2WlG9/wrpEezgq0ooWFO2dBCYrm0Gwwk0Hn+28V
         QliO0lCxFMoVC3btWmuk7wBZwRFyOdXVDG3Wdn9LL2zo9GPbclxAQSRzLYDykE0lh4Od
         dcxg==
X-Gm-Message-State: APjAAAVO4S/VEeR9gFea1YRq+7dD5gjaYymjDUY+Ho2k84MqWJLV97yu
        zB5laTd/C7HHumVgNP0oCw==
X-Google-Smtp-Source: APXvYqzn+v4yVCzNPWIXhmRz3AdMu+fycoMKN7LNNf8XGpK3Hy8shxP66dzdzXor5TPJ4npISlu7dQ==
X-Received: by 2002:a9d:5c11:: with SMTP id o17mr10969493otk.107.1566411886789;
        Wed, 21 Aug 2019 11:24:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i17sm6178004oik.32.2019.08.21.11.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:24:45 -0700 (PDT)
Date:   Wed, 21 Aug 2019 13:24:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2] dt-bindings: arm-boards: Update pointer to ARM CPU
 bindings
Message-ID: <20190821182445.GA9101@bogus>
References: <20190731114201.7884-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731114201.7884-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 13:42:01 +0200, Geert Uytterhoeven wrote:
> The ARM CPU DT bindings were converted from plain text to YAML, but not
> all referrers were updated.
> 
> Fixes: 672951cbd1b70a9e ("dt-bindings: arm: Convert cpu binding to json-schema")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> v2:
>   - Add Acked-by.
> ---
>  Documentation/devicetree/bindings/arm/arm-boards | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
