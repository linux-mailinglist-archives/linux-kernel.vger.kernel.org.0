Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC02711EC6F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 22:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLMVDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 16:03:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33785 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfLMVDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:03:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id d17so684566otc.0;
        Fri, 13 Dec 2019 13:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4BrEW8Ks5xHcUOUwLCbUHauxk/7fJuIgywuOmblrmfQ=;
        b=c7VJulopwxzVx9mkRXtrwKFJKgezwwiSv4pwn/aD3HxOMgzYFJ+KqxlepzS1C4kDxQ
         hteja/TAJkAD4kyX0qwVhVZJpR9h2ZRSoGYIqOgDHHAnlXnFJYBeCtUfrhRVAE6RrpPn
         WtdmRdvAKJy3+pRquXXbgfVYEI0ICEiN/OJ8fSusyoBCFrDm58am753Bc7RWg6az2i9P
         bc3NDdoaHs1mwHR1gTdBOm9UQvrc5l8CYHTPavUxpD6mmkTXRlIW2Ac4oM38eVI+GrY4
         3cBRcHZuzSjaQMJuadBRCGZKTBQePDGTku2LEQ8O7m26tTACUrHzWWoINdrd7B3IdULk
         pGiQ==
X-Gm-Message-State: APjAAAU6MZYmclzcvmYOZzvaJR50Q9kCL2T2amCdmpskGzPcU3Q4vW54
        zhhaIhbOfGlcbRWFmazlEQ==
X-Google-Smtp-Source: APXvYqxCJ/GV+amZcWd+ta3L2miJb9aqIUOsjneQSXCDc6gefqADSpyHDAUY4fZ17t7ANFuanO4dIA==
X-Received: by 2002:a05:6830:12cc:: with SMTP id a12mr15350802otq.73.1576270997110;
        Fri, 13 Dec 2019 13:03:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r6sm3726294otd.66.2019.12.13.13.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 13:03:16 -0800 (PST)
Date:   Fri, 13 Dec 2019 15:03:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     kbingham@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Simon Goda <simon.goda@doulos.com>
Subject: Re: [PATCH 2/3] dt-bindings: auxdisplay: Add JHD1313 bindings
Message-ID: <20191213210316.GA18932@bogus>
References: <20191128105508.3916-1-kbingham@kernel.org>
 <20191128105508.3916-3-kbingham@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128105508.3916-3-kbingham@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 10:55:07AM +0000, kbingham@kernel.org wrote:
> From: Kieran Bingham <kbingham@kernel.org>
> 
> The JHD1313 is used in the Grove RGB LCD controller [0] and provides
> an I2C interface to control the LCD.
> 
> The implementation is based upon the datasheet for the JHD1214 [1], as
> this is the only datasheet referenced by the documentation for the Grove
> part.
> 
> [0] http://wiki.seeedstudio.com/Grove-LCD_RGB_Backlight/
> [1] https://seeeddoc.github.io/Grove-LCD_RGB_Backlight/res/JHD1214Y_YG_1.0.pdf
> 
> Signed-off-by: Simon Goda <simon.goda@doulos.com>
> Signed-off-by: Kieran Bingham <kbingham@kernel.org>
> ---
>  .../bindings/auxdisplay/jhd,jhd1313.yaml      | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/jhd,jhd1313.yaml
> 
> diff --git a/Documentation/devicetree/bindings/auxdisplay/jhd,jhd1313.yaml b/Documentation/devicetree/bindings/auxdisplay/jhd,jhd1313.yaml
> new file mode 100644
> index 000000000000..b799a91846d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/auxdisplay/jhd,jhd1313.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please.

(GPL-2.0-only OR BSD-2-Clause)

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
