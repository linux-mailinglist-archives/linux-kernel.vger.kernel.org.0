Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECCD170B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 23:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgBZWVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 17:21:47 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41875 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgBZWVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:21:47 -0500
Received: by mail-ot1-f68.google.com with SMTP id v19so1005622ote.8;
        Wed, 26 Feb 2020 14:21:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pm+KRlKrRAlpkte58c3hWACvW9/7DnqTwr2mwwxPfyg=;
        b=OEBBta5jol5bdse0pTiOJDIzF0m6qyAbGPeU6xVKexzQu9iZw4DDDrAnZNZ6GKOKLY
         lhM7yc297xtRvPT7Ig5/CUYOEbqiWynT1zYjUIXmGA3i+eSBGoq9LMR4S9PP9qFUKywn
         V0VvkahNdVA2CBz5RtHntEYm2SCZPbaVRjPmVsCCg3qllBeX+/1uRBmqImquLF8n3uIQ
         5mqHAyqGnZgrITkfGwXyPL104KBnZ4y5mOtdxAe37r7u7ieTBgYKVGo0PVjUMlQA2U+U
         9oAz9xWIjIl0kUAwqwanrT8i6ukaOoIiDviKJWv+FjHZLZJigcACZh5aSNsjG31tZsW+
         rLaQ==
X-Gm-Message-State: APjAAAXfHIeUmwB3aEznA6nIXQkWd16UNOrLoNTVqpjDK0MIQ4492zFu
        BymapX7L4UXBseUbtmex7A==
X-Google-Smtp-Source: APXvYqzqESskOaokNa5xJpO2bz/TvwXWpRKOLr9EGPeCRN81SZK39751YsyMrm8RnXZvtUdkdrwhVQ==
X-Received: by 2002:a9d:7599:: with SMTP id s25mr844343otk.285.1582755705377;
        Wed, 26 Feb 2020 14:21:45 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m18sm1243415otf.6.2020.02.26.14.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:21:44 -0800 (PST)
Received: (nullmailer pid 6745 invoked by uid 1000);
        Wed, 26 Feb 2020 22:21:43 -0000
Date:   Wed, 26 Feb 2020 16:21:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: mtd: Convert Denali NAND controller to
 json-schema
Message-ID: <20200226222143.GA6682@bogus>
References: <20200222141927.3868-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222141927.3868-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2020 23:19:26 +0900, Masahiro Yamada wrote:
> Convert the Denali NAND controller binding to DT schema format.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../devicetree/bindings/mtd/denali,nand.yaml  | 149 ++++++++++++++++++
>  .../devicetree/bindings/mtd/denali-nand.txt   |  61 -------
>  2 files changed, 149 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/denali,nand.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mtd/denali-nand.txt
> 

Applied, thanks.

Rob
