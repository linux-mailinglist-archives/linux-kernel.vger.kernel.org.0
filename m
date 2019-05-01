Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570A010EC6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 23:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfEAVwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 17:52:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36676 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfEAVwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:52:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id b18so306270otq.3;
        Wed, 01 May 2019 14:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4aS2uE1D91mkrl/gYeWQtzT+PKkraqjyORTXhMdPTWc=;
        b=s+tHfM2KyfzqUYgN/yMZ7FZmtfhtU9cy3aapzBUQWLdzqu/Aw3kJnHtfsi4ZOEgzpL
         M1w0gxaq3mscud1losPOmosC8OUOKffFa+SMN1nIxRbYro/Cl9xd8d2dCdl6gdJn6cC7
         +qtqjfgOBkCC+3OPOL25qDhNzfGMEDmP4tW6CmR8gE33jhUKrdkCF2BtGa6YZTHnQtPY
         f+YkcKJ6ztEb2kZ8E0uxS8K7ic7gCcbONWLD71Q9XIrStJ1LduHA1j6eWpdQpxQgCubP
         tfUT5xDbVwh2PbglYY2dYcF27J4R/52l6LzSFjC1eP3a3zHyw2ZHFccmkKULanbvci4v
         Rosg==
X-Gm-Message-State: APjAAAWhFBRZQjxMzVAleAT5a5srotGfPWnhOjbQg0Gq4/1cqeZOjYbQ
        TLXeCgrxbdZ7U6Bvvolbhw==
X-Google-Smtp-Source: APXvYqxmtbWrY/WLRlpa30jAQrLAn/rBzs1+rA0hxlCtOKQ5kF+JMyAgDmkIhtG26z9qXLGD7xaGMg==
X-Received: by 2002:a9d:62c7:: with SMTP id z7mr173222otk.103.1556747556350;
        Wed, 01 May 2019 14:52:36 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c3sm10788016otr.57.2019.05.01.14.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 14:52:35 -0700 (PDT)
Date:   Wed, 1 May 2019 16:52:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: sound: sun4i-spdif: Add Allwinner H6
 compatible
Message-ID: <20190501215234.GA31269@bogus>
References: <20190419191730.9437-1-peron.clem@gmail.com>
 <20190419191730.9437-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190419191730.9437-2-peron.clem@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019 21:17:26 +0200, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= wrote:
> Allwinner H6 has a SPDIF controller with an increase of the fifo
> size and a sligher difference in memory mapping compare which
> make it not compatible with the previous generation H3/A64.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
