Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51B5744F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 00:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfFMWqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 18:46:07 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43606 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFMWqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:46:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id z24so316536qtj.10;
        Thu, 13 Jun 2019 15:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3l6xLhayDfeORMYs2edoaxOHoJvk6NAGYehLhSxs4HU=;
        b=pxT0/pybdsQcVdEmbO47UbM0F2haaQ0qQFjEIvPrDyoeqVHpNxAFd5UEkS2Ar0Si6s
         B6EN7ha6dZFEH1H5+VmnBHAO1sNVKCK+meimP9ZIzxo6mRqf1mwMYfUI8PR9DJuSDIbW
         +LjdgsN1eGumrrMd04jjopetRHtoDmVgObEO0fd1fpj4jZpFXJvVGEn7qiaGpvkF+p5p
         h5zMD9U7AW7qpDuwAi5R8P2H46ocwDTFcKu+e3WQKQ/wW1sL4SNOngpwzmzWHWUN+Qt3
         9fS37M/bNE+fpXaut7dnBERQF8H1u+Y2xhzAj+Z7RABZMcqawdxi91lgGWzIDWuCn7N6
         bBdg==
X-Gm-Message-State: APjAAAULA8uqqU7mPYRXtfp7rdEr17WKpdJO+QtNtbRcq4fCnavEskn/
        +D897XEahfWuXqU5KKkaIBsVPsI=
X-Google-Smtp-Source: APXvYqxIVme105YUKNQ+X/UQpRs4NI2gkAUD4lhVjKzJjV16jUZWJ2UgUHpiMg3am2BsoE9brW8bLw==
X-Received: by 2002:ac8:689a:: with SMTP id m26mr35237511qtq.192.1560465965659;
        Thu, 13 Jun 2019 15:46:05 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id c5sm739845qkb.41.2019.06.13.15.46.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 15:46:05 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:46:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: arm: Convert Alpine board/soc bindings
 to json-schema
Message-ID: <20190613224604.GA5119@bogus>
References: <20190517153510.13647-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517153510.13647-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 10:35:10AM -0500, Rob Herring wrote:
> Convert Alpine SoC bindings to DT schema format using json-schema.
> 
> Cc: Tsahee Zidenberg <tsahee@annapurnalabs.com>
> Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/al,alpine.txt     | 16 --------------
>  .../devicetree/bindings/arm/al,alpine.yaml    | 21 +++++++++++++++++++
>  2 files changed, 21 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/al,alpine.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/al,alpine.yaml

Ping. Please apply or modify this how you'd prefer. I'm not going to    
keep respinning this.

Rob

