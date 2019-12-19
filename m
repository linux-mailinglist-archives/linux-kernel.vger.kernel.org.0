Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6AE6126C75
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 20:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfLSTEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 14:04:09 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39169 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfLSTEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 14:04:07 -0500
Received: by mail-oi1-f195.google.com with SMTP id a67so3486013oib.6;
        Thu, 19 Dec 2019 11:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KeFUqf0A6DIMzL1K80NCP97x3jQLHFRUKVr7gfJSL5I=;
        b=iNvkngNKULlaMRsRBNkzNPMPD5YfxTNPNLn9VxFNz/ORQBXm4WrsdPjv481vWcfNB1
         WTqN2t7yim4/M9Uvz5ZnbVJEG7175FRiKIbmieL4o84yX7j258Fcl/ylO/tNep0wigpn
         RZuaUX8JO+6sOIinT7PsyPnf91RsDtjd4rPgyJkaIP7a/pbPhHcDmZLGWBXAhDancff4
         rSHWF+d1aQjlJFUijVM8OAdzpTcNVr7erYvimAYdCu6kJ1F9VgHd1HuGuqCF8DOUkBDN
         joiRiEd5B5gNsEQbFRWnyV3RMSxGcOr5z3alJ83y5chypA3IrktdwMnNamAn5swRE4wX
         +xhg==
X-Gm-Message-State: APjAAAV8Gpcv0X4NdA9XIFVcQZyNIaktJ+0wjoeDUQC7sZBPQvx+uJAj
        p2y0ziaMfor1ijDq56ftRw==
X-Google-Smtp-Source: APXvYqz2K1ezcoQHOkwjBOve0kZcGoV4LnZnkgZ6Ei/DgEJFAsxpqjXbpjQ6k4RTXSpjUqwF/0stbg==
X-Received: by 2002:aca:cc08:: with SMTP id c8mr1077390oig.42.1576782246999;
        Thu, 19 Dec 2019 11:04:06 -0800 (PST)
Received: from localhost ([2607:fb90:bdf:98e:3549:d84c:9720:edb4])
        by smtp.gmail.com with ESMTPSA id a17sm2423295otq.49.2019.12.19.11.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 11:04:06 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:04:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, tsahee@annapurnalabs.com,
        antoine.tenart@bootlin.com, hhhawa@amazon.com,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        tglx@linutronix.de, khilman@baylibre.com, chanho.min@lge.com,
        heiko@sntech.de, nm@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        barakw@amazon.com
Subject: Re: [PATCH v2 4/6] dt-bindings: arm: amazon: add missing alpine-v2
 DT binding
Message-ID: <20191219190405.GA15485@bogus>
References: <20191209161341.29607-1-hhhawa@amazon.com>
 <20191209161341.29607-5-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209161341.29607-5-hhhawa@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2019 16:13:39 +0000, Hanna Hawa wrote:
> Amazon Annapurna Labs Alpine family includes: Alpine-v1, Alpine-v2.
> 
> This patch adds the missing DT binding of Alpine-v2 in amazon,al.yaml.
> 
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  .../devicetree/bindings/arm/amazon,al.yaml        | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
