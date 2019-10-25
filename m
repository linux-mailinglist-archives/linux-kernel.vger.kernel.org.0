Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E20A4E51EC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 19:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409647AbfJYRGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 13:06:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44346 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404975AbfJYRFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:05:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id n48so2508456ota.11;
        Fri, 25 Oct 2019 10:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1AgdABbWJsmP+A2yUEZpKyjJoywiJ/30OEkpvdzMQXE=;
        b=fkUYjq/RBT7KX8uWpE/S3Y7Qr7r8rK9o62Sx9hq/weytZ5O5Ph6ANvw8EmYJ9u6J41
         LESxXBWJGM5Wfvypfi5Z8aEEM0V5ENBYLkFU0HrGGXDwkijc5Uq76WeON985IbuMz6Iw
         EKDFvU8mLioZPBpFOIkFXM7Bcwx8zOyduwGhwATuK00jKnJdH9QBvlHFsrjBy1JOOKnN
         BhqY53NaleJeNsqtok2baGbAS1Rp+tUQdRMB6L2dRo9TSZJlKVqAGeSDM3XJdoBju9V/
         Foi3rzWFw7+dmA/npGSbipAs1IptqCX3Q5itgGwOTvNfzu4xF8GzkOeYLwaok66lGinS
         0UsA==
X-Gm-Message-State: APjAAAW3DDHNu4Z/fumYVQ51+iPFu/sWXyGde77jZ6fbhSBjDYxKBXFw
        /xpo84hN5z1s+VJUdiTTKXP6Mk4=
X-Google-Smtp-Source: APXvYqzAIN39CFwejymy8N75FlRSEB+gx7AUGQuhXy4lYkgVhNH9amWjIoeuN/NJ45wpnUM65WYw2g==
X-Received: by 2002:a9d:6f17:: with SMTP id n23mr3512605otq.54.1572023129944;
        Fri, 25 Oct 2019 10:05:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a21sm702920oia.27.2019.10.25.10.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:05:29 -0700 (PDT)
Date:   Fri, 25 Oct 2019 12:05:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 1/7] dt-bindings: sram: Convert SRAM bindings to
 json-schema
Message-ID: <20191025170527.GA12121@bogus>
References: <20191021161351.20789-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021161351.20789-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 18:13:45 +0200, Krzysztof Kozlowski wrote:
> Convert generic mmio-sram bindings to DT schema format using
> json-schema.  Require the address/size cells to be 1, not equal to root
> node.  This also fixes the check for clocks property to be in main root
> node instead of children.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v3:
> 1. Integrate Samsung SRAM bindings here,
> 2. Move 'clocks' one level up (error in previous bindings),
> 3. Add 'additionalProperties: false',
> 4. Fix names of children in examples,
> 5. Fix children nodes address pattern,
> 6. Address other review comments
> 
> Changes since v2:
> 1. Add Rob as maintainer,
> 2. Use "contains" for compatible,
> 3. Fix address and size cells to 1,
> 4. Add maxitems to reg under children,
> 5. Remove unneeded string type from label.
> 
> Changes since v1:
> 1. Indent example with four spaces (more readable).
> ---
>  .../devicetree/bindings/sram/sram.txt         |  80 ----------
>  .../devicetree/bindings/sram/sram.yaml        | 137 ++++++++++++++++++
>  2 files changed, 137 insertions(+), 80 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sram/sram.txt
>  create mode 100644 Documentation/devicetree/bindings/sram/sram.yaml
> 

Applied the series, thanks.

Rob
