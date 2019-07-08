Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B2662A1E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 22:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404858AbfGHUHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 16:07:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39132 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbfGHUHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:07:15 -0400
Received: by mail-io1-f66.google.com with SMTP id f4so22629868ioh.6;
        Mon, 08 Jul 2019 13:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c+qep4J4/FQrVQ6zfPzVVKTkJDFssAjiBNBrhsSbL6Y=;
        b=F+7RhtSlMOoUgB+UNuaT7z61sS1IWo8bNfo4G4jhB0hI1DKCyQH+CtNASHDzzNo3in
         zPUa2nPlz1QaA72B2yHtnB7kFTfJiJO3VXakMVFChmY3WfoaBsV8ZgJjzBPFxQ3sewnI
         Rzl8ZO5OCtxYmvlu3zIYLYbUP1FjPDx9/i4IvjpYlSQrkjydOephpMlI8QICQJ/wFdDq
         AU+A7o6bgKoTMX/PFlBT91858yVNiMGp4t45DEQi99+MJfzwdDezYgP7cI9Vp4hZH6X+
         9gA/HtY0liQDjNYaNwYJN341p0azdkAQOTDRlDzhoYqOZLfxceLWYM5t3dbH8QAp2Kks
         nS/w==
X-Gm-Message-State: APjAAAUDWRHza7efSpQlYvagh/DpzIErc0OXD7bztkwQa5WFHpNcdmlb
        WiVvm7zp+Im3s+h8b/i2oUeEVRU=
X-Google-Smtp-Source: APXvYqy/IYK01DUWimXajauIpaZwAc1wEdqK/1UXBIpiU9kCjouFLoZIN3zogWWuiL3j8Hr8XZaaJg==
X-Received: by 2002:a5e:d615:: with SMTP id w21mr17073179iom.0.1562616434514;
        Mon, 08 Jul 2019 13:07:14 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h19sm13257595iol.65.2019.07.08.13.07.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 13:07:13 -0700 (PDT)
Date:   Mon, 8 Jul 2019 14:07:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] of/platform: Drop superfluous cast in
 of_device_make_bus_id()
Message-ID: <20190708200712.GA29483@bogus>
References: <20190624124620.21891-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624124620.21891-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019 14:46:20 +0200, Geert Uytterhoeven wrote:
> There is no need to cast "u64" to "unsigned long long" before printing
> it, as both types have been made identical on all architectures many
> years ago.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/of/platform.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Applied, thanks.

Rob
