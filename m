Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF859F0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 18:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfH0Qwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 12:52:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43184 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfH0Qwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:52:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id e12so19316456otp.10;
        Tue, 27 Aug 2019 09:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tJQaEfQzxJRI95haC9x8BQf6ZaZH5SadaGLixg3pTkQ=;
        b=ltbrHqYba7IzgagVKBCD8naFBE2hcVeC0AmB3d2nVj0rw0pXDTCtdu2CTS/ql1gJIY
         DdJxJ8yTKZ3NkObexBgnIClylH89VrFOEj9If8U882EI4XVO2b4GK/wtYqxV3y1hEXN7
         c5Vqlmfqjp9K/dg4mQTJvPMeAU4hWyW8gkEUmlHi17x7SUB17mbhICsK5GN5sxp1KuHo
         HAPNqFIbrL+BrIic+eybDuESGiGnPAzBhZqNsfS7WjZ+qa+HgKtVZlOtgPvqmTA4Y0Jz
         rQ9BJR+ygH3+kbOj2e+pvo1TTaPRuEZsV4Ooqe3pdF2bfDJg9N+eV7f5MlRFhIcQsV0t
         nvEg==
X-Gm-Message-State: APjAAAXh6tNOmhlSHaAfmbxeC1fYDAt2gY2cmXuiWbORPeqTY+61xzkv
        VDaqb2Gyk4Fvfh/Kx+JonA==
X-Google-Smtp-Source: APXvYqyGilh1hnFSb4yL7j69xPv3YKAFNDENe5C8fgprVeR9noOD6uBNAfoQufznTGF82er1HpBS6Q==
X-Received: by 2002:a9d:65ca:: with SMTP id z10mr19808758oth.167.1566924754327;
        Tue, 27 Aug 2019 09:52:34 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s22sm4240569oij.37.2019.08.27.09.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:52:33 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:52:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        mtk01761 <wendell.lin@mediatek.com>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 08/11] dt-bindings: mediatek: bindings for MT6779 clk
Message-ID: <20190827165232.GA28828@bogus>
References: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com>
 <1566206502-4347-9-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566206502-4347-9-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 17:21:39 +0800, Mars Cheng wrote:
> From: mtk01761 <wendell.lin@mediatek.com>
> 
> This patch adds the binding documentation for
> apmixedsys, audiosys, camsys, imgsys, ipesys,
> infracfg, mfgcfg, mmsys, topckgen, vdecsys,
> and vencsys for Mediatek MT6779.
> 
> Signed-off-by: mtk01761 <wendell.lin@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    1 +
>  .../bindings/arm/mediatek/mediatek,audsys.txt      |    1 +
>  .../bindings/arm/mediatek/mediatek,camsys.txt      |    1 +
>  .../bindings/arm/mediatek/mediatek,imgsys.txt      |    1 +
>  .../bindings/arm/mediatek/mediatek,infracfg.txt    |    1 +
>  .../bindings/arm/mediatek/mediatek,ipesys.txt      |   22 ++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,mfgcfg.txt      |    1 +
>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |    1 +
>  .../bindings/arm/mediatek/mediatek,topckgen.txt    |    1 +
>  .../bindings/arm/mediatek/mediatek,vdecsys.txt     |    1 +
>  .../bindings/arm/mediatek/mediatek,vencsys.txt     |    1 +
>  11 files changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ipesys.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
