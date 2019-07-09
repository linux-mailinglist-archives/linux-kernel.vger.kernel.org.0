Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F046637BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 16:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfGIOUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 10:20:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:47019 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGIOUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:20:42 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so43434768iol.13;
        Tue, 09 Jul 2019 07:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uwLVA3tOL3nh/Q8f5KgkTWHNu7X1kGgEZRYGWxDF7jY=;
        b=C+2oFhSWwYzWBbSdn0B++qAWDZafWwBmgKAeNodEdWMzsp0X0He1Pmdh+StutJTeak
         KptrrBhxqgvD2jvNoNLj+oi3YoxtukK36hwdmWsE1/LEA+cPEHQfFXkGVn0yCdiY9PKl
         UlP1GxS8940aWmXndBrv1HYoDCHkvIDxKkxS8TkLgUU1YStSyQ/JAlRy1eSGfNqSQZ2q
         9qG1Ikgm4mBgsdRwNcMMJ/d+geVemNhZoFiB1Y5RUHmd+VrGVDWCWSQe5qcJiOjjyE+f
         3HAIhc+ccd6iEpwV2WI7Q8pmPiDG6z+13pSg7caNksRHex961TlysbhSo/4TqyJTVlQt
         g81Q==
X-Gm-Message-State: APjAAAUtL2vgsbWETZ7EoalvGRH5tTRIZdqkb1AtgOjD7VsaVYJDpSLr
        q0W3fAJaGAIOmGg/5kG6ww==
X-Google-Smtp-Source: APXvYqyd6NOWgi5h/HRhfAnx29VFzRk5mq/hbjdb807MsQYKsvLUtQPDHwnd+s0+N3IP/O2FuB0npQ==
X-Received: by 2002:a02:5185:: with SMTP id s127mr28314036jaa.44.1562682041727;
        Tue, 09 Jul 2019 07:20:41 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p10sm26942432iob.54.2019.07.09.07.20.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 07:20:41 -0700 (PDT)
Date:   Tue, 9 Jul 2019 08:20:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jumin Li <jumin.li@mediatek.com>
Subject: Re: [PATCH 1/5] dt-bindings: usb: mtu3: fix typo of DMA clock name
Message-ID: <20190709142040.GA10200@bogus>
References: <5e06482a0be15476c7b5825f155accf98275afa8.1560246390.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e06482a0be15476c7b5825f155accf98275afa8.1560246390.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 13:55:17 +0800, Chunfeng Yun wrote:
> Fix typo of dma_ck
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtu3.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
