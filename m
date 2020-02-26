Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D21170B39
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 23:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgBZWIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 17:08:24 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36783 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBZWIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:08:23 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so1205740oic.3;
        Wed, 26 Feb 2020 14:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5sk04Aa0osSD8HvD4zEQiuhG+Svc22FeYyxbfTqw7T0=;
        b=Xtlr+JBS8WhwZSrDzxGiyA9amTUadjLza628BAe77Dj3tn4gVk10heI74dXuUE4uPX
         3/rLCwHu/QkJ45wavFqPl4HFD/7kCwTJsfXTjXmHb7ir/Kmb7fYm9zhss9UeeBVDGWlg
         +t7mse7AqXDkvE5hiiQ33U+HCeyWVID5wSyqBTVT6nDEl0PpRmp6a2UuIf63q2dy9nug
         OO71iXYfRhGHtcPhyxvDRWKYaNprpdWD9XTvmMqzksfUFULIrzsXZ8Y1L27glxQz2NsK
         dyqVF1QVuMU7GbPRJ3hKsWxTkle3X9Y+uOzOrhvCYXRWpl8gC/fdOEJDnCFRbxYP9bEz
         lnDw==
X-Gm-Message-State: APjAAAX+uCkZP6HVL7feXIk5abUdA/6M2tsUomlAbQcvGhQAwBaRmj3g
        DRQFgcRgy7UdqQvsoIFoSYWW2a40vg==
X-Google-Smtp-Source: APXvYqxd1SsKO6HCPpKNN3ewCCxV7z2W8Z76dRsKMhAF2AJ+0XISi4LTkCEmr5LiwzRxiH6hL8yI6A==
X-Received: by 2002:a05:6808:3b2:: with SMTP id n18mr933712oie.146.1582754902605;
        Wed, 26 Feb 2020 14:08:22 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m69sm1215131otc.78.2020.02.26.14.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:08:22 -0800 (PST)
Received: (nullmailer pid 19698 invoked by uid 1000);
        Wed, 26 Feb 2020 22:08:21 -0000
Date:   Wed, 26 Feb 2020 16:08:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: bus: Convert UniPhier System Bus to
 json-schema
Message-ID: <20200226220821.GA19595@bogus>
References: <20200222061109.2021-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222061109.2021-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2020 15:11:09 +0900, Masahiro Yamada wrote:
> Convert the UniPhier System Bus controller binding to DT schema format.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Fix the build error in the example
> 
>  .../bus/socionext,uniphier-system-bus.yaml    | 96 +++++++++++++++++++
>  .../bindings/bus/uniphier-system-bus.txt      | 66 -------------
>  2 files changed, 96 insertions(+), 66 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml
>  delete mode 100644 Documentation/devicetree/bindings/bus/uniphier-system-bus.txt
> 

Applied, thanks.

Rob
