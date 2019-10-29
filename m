Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F332AE9250
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 22:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfJ2VqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 17:46:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36915 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfJ2VqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:46:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id y194so198145oie.4;
        Tue, 29 Oct 2019 14:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yJCcYJZxu+ClTD5mONx1BPgjKtKL8ywc/i/0sGI3cjs=;
        b=jMaATXtT4AlBJO6UwDQBAezFkZfONXxgzzBYfks+mwlX2NuVIgtETGovUPHVpfNCiG
         HceETN0GOruKMxUEKz7pBaC9yXdW9bEiqi2+QBGxQr0E/aGo4PzYjaGZoAsHwBqkfvvQ
         kbrQUHImwci1kZm+jlkCzUzSAKgxqWYkrf3JkJhl1LwYe/lCUbZ8G6bo7/Wnak3QTbx6
         +bsRt+QMkpybAQPgmpi1fKsKyRpeMCtp94TQu/p/EZh5BpAsLYS2ULa2P16EvaAdw1ZN
         zVt8JpX3L6SthF/gfQWt/Uhy9Cb8AA9zFHcAZzQ62JnPB1Fk2HgWi0gL6zVtUg7zXi0w
         44Og==
X-Gm-Message-State: APjAAAVA1Vrq4/RQ6npf9rjzoTr+8qhl+il+pENn6wDcoykUumGA87VF
        pL6FrZtLGeNSd1zbya5vJjurfLuqsA==
X-Google-Smtp-Source: APXvYqwPXaijas36sViYh9m6BOsvN8Quaw3gVnxynwsDpGLqfDJ59AdtsfwABefP7yfQUtH/S0XxvA==
X-Received: by 2002:aca:fc92:: with SMTP id a140mr5726869oii.153.1572385571564;
        Tue, 29 Oct 2019 14:46:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 88sm75531otb.63.2019.10.29.14.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:46:10 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:46:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: Add bindings for Unisoc's SC9863A
Message-ID: <20191029214610.GA20831@bogus>
References: <20191025102915.23677-1-chunyan.zhang@unisoc.com>
 <20191025102915.23677-3-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025102915.23677-3-chunyan.zhang@unisoc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 06:29:14PM +0800, Chunyan Zhang wrote:
> 
> Added bindings for Unisoc's SC9863A board and SC9863A SoC.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  Documentation/devicetree/bindings/arm/sprd.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Can you please convert this to DT schema first. See 
Documentation/devicetree/writing-schema.rst.

> 
> diff --git a/Documentation/devicetree/bindings/arm/sprd.txt b/Documentation/devicetree/bindings/arm/sprd.txt
> index 3df034b13e28..c244c911f8df 100644
> --- a/Documentation/devicetree/bindings/arm/sprd.txt
> +++ b/Documentation/devicetree/bindings/arm/sprd.txt
> @@ -12,3 +12,11 @@ Required root node properties:
>  SP9860G 3GFHD Board
>  Required root node properties:
>  	- compatible = "sprd,sp9860g-1h10", "sprd,sc9860";
> +
> +SC9863A SoC
> +Required root node properties:
> +	- compatible = "sprd,sc9863a"
> +
> +SP9863A-1H10 Board
> +Required root node properties:
> +	- compatible = "sprd,sp9863a-1h10", "sprd,sc9863a";
> -- 
> 2.20.1
> 
> 
