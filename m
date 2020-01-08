Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E22F134E16
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 21:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgAHUyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 15:54:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43638 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgAHUyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:54:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so4941716oth.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 12:54:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=irwHBzNJL11iS3DIpsshB1iOiTtfFrxmr67ljB2o42w=;
        b=it3EZYrbPGYX8b6k+a/i3A98KnUy4inI54Ka8kHejo8BxiDrrAx5Aosnm/L1YuTlAl
         hH5EAmaZtB2+x+F8Coj06CVQEBDifOWULeA979xxW6o2tUZ0iEQIcna0BgaoXn561ZT4
         jmN3fjRNHxBaWXNLGCKvT9pvikd4XaZJHq9WDLem2gMwMNI6AtaOZ/PWKsxaxK15gg+G
         bPbyrD+y0xFzP5HHa+Kq9Szi+yAr7owZuEZSZ5wKATFsAGEs8KjwrNx3SmLLs+Grx45S
         55kNA81i+At6QWcNyJgJaC/2TA8vE8d//o8A0hEmAw4ZPj5x1QctSYNEb//MhlIsbLDm
         gVcw==
X-Gm-Message-State: APjAAAXbwDrWz3GD4i+k0fTBamAeTBdbXoaabAs9HLg4ES/+7McO+kqx
        nonab40OFbnyNXxBhIY/Wu7nuEo=
X-Google-Smtp-Source: APXvYqxdPj6wUtz9n7UrbMLgaQ1Ioo3p+WAt4jI58TmlCin3goy9FPkEb1JtzRDDUo4e2hrBQfemWA==
X-Received: by 2002:a9d:6d81:: with SMTP id x1mr5972307otp.9.1578516861549;
        Wed, 08 Jan 2020 12:54:21 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h20sm1511646otr.35.2020.01.08.12.54.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 12:54:20 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2208fa
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 14:54:19 -0600
Date:   Wed, 8 Jan 2020 14:54:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Khouloud Touil <ktouil@baylibre.com>
Cc:     bgolaszewski@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, srinivas.kandagatla@linaro.org,
        baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        linus.walleij@linaro.org, Khouloud Touil <ktouil@baylibre.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: at24: make wp-gpios a reference to
 the property defined by nvmem
Message-ID: <20200108205419.GA16184@bogus>
References: <20200107092922.18408-1-ktouil@baylibre.com>
 <20200107092922.18408-4-ktouil@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107092922.18408-4-ktouil@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jan 2020 10:29:20 +0100, Khouloud Touil wrote:
> NVMEM framework is an interface for the at24 EEPROMs as well as for
> other drivers, instead of passing the wp-gpios over the different
> drivers each time, it would be better to pass it over the NVMEM
> subsystem once and for all.
> 
> Making wp-gpios a reference to the property defined by nvmem.
> 
> Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
