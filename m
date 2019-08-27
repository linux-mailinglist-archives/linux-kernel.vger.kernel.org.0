Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAC39F0B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 18:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfH0Quw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 12:50:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38410 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfH0Quw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:50:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id r20so19318638ota.5;
        Tue, 27 Aug 2019 09:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fqBFilW3Taxmqkkc+lbabtCZRi69qq/O3UlJxrJchrY=;
        b=OVZWjl/3X16+uT/lPdJz9HuC2H1nIclyq2h5JAip4if4UZuzZ73rZutywL9MV++7+A
         ePtHYmnH+HRkl5z/mLljQ0JF31YNnEO0ahnqEPPh0Hrb4mYhuLOk0ubGOPTQfWYAVMF2
         xaMwaYjsxE14pR1146SM0NSMOEXNhXIWAjsKjtF84fztJaPipGiwENDTqrmrzWG20As3
         qM/O/JUgXMDPZJU4NHNiE8N9x22uWU3/EunAj2psEJ1RLWvwlJBEzc9RRwErhxrs0hBk
         x4N2DAiml+k/6cA4XMnRZO9fT3nRqAoNnQGjmtCdWQrKkKW4koSYTTXESwlO9gjDD8pU
         wf+w==
X-Gm-Message-State: APjAAAXM6ng90WYzCNLRCoHTMdpD5eUqsRvL9k7yvBDY8/LjloKAcJsV
        WsbuXxoGYN+ZgaHK88BlzA==
X-Google-Smtp-Source: APXvYqyw4UG0idfNDJmbNZqg1Onu34fcHoHyW1oudTW4c4m5Yz92ptA6VjcNj2jaiiv7lA3hJ7MwFg==
X-Received: by 2002:a9d:58c9:: with SMTP id s9mr17368581oth.16.1566924651011;
        Tue, 27 Aug 2019 09:50:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g3sm6043222oti.41.2019.08.27.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:50:50 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:50:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        mtk01761 <wendell.lin@mediatek.com>, linux-clk@vger.kernel.org,
        Mars Cheng <mars.cheng@mediatek.com>
Subject: Re: [PATCH v2 03/11] dt-bindings: irq: mtk,sysirq: add support for
 mt6779
Message-ID: <20190827165050.GA25969@bogus>
References: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com>
 <1566206502-4347-4-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566206502-4347-4-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 17:21:34 +0800, Mars Cheng wrote:
> Add binding documentation of mediatek,sysirq for mt6779 SoC.
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  .../interrupt-controller/mediatek,sysirq.txt       |    1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
