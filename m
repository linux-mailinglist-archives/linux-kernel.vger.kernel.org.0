Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF70A580D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 15:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbfIBNjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 09:39:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50881 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731147AbfIBNjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:39:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id c10so2735120wmc.0;
        Mon, 02 Sep 2019 06:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=c4HshC9nAsXvh0CM4Xw/Kywl+VsuIg86CWeyWDCZNw8=;
        b=nUOYP3/BkP7nlK+bdvIOp5k8nq+GgcmSmqKIznO71owRg4+erE7zTHOpVSlGC/EO+g
         piMxTWg6gk5kHMvHQzCp9nI1wcIP8Hg+Lf589xahePrt/2K7NrlyDJsk3w4FKEK+nb/n
         h8u2kOkVzIpKwEXWSMWxzU4yX6tF2PaDVyTXkxfxEpiBqKLeOicO8rCdlF9YAK2IJXG3
         wKYSI1OEDK1Fw+R7uM/fbZdrcPnFMxEPenTOAA/3v7VtoSIxEX4kHyBnkAGR2KqcWMU6
         CpJ3vRH3zfGPBLb5ND7UEhFt3uNR9z7PhrMaL8Jv2N0LXAmVrzUFLO0UHwh8CZSkQ78F
         n6Rg==
X-Gm-Message-State: APjAAAVsDUavT7Fh96NnQAeosCougAPYd4EN+BbQ2RbWu5Hv/PyToeyf
        qnvxPQt1KiPsDay2P82BAQ==
X-Google-Smtp-Source: APXvYqwO6HHhku+0rZz6bR1PsEOF/M9tdBQBZMCOO26c8+wfPqrArykir4NPZWmSRZbUxaOgadevqw==
X-Received: by 2002:a1c:c5cb:: with SMTP id v194mr14382889wmf.108.1567431543614;
        Mon, 02 Sep 2019 06:39:03 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id s12sm3868057wra.82.2019.09.02.06.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:39:03 -0700 (PDT)
Message-ID: <5d6d1b77.1c69fb81.59c07.0f29@mx.google.com>
Date:   Mon, 02 Sep 2019 14:39:02 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/7] dt-bindings: usb: mtu3: support USB wakeup for MT8183
References: <1567150854-30033-1-git-send-email-chunfeng.yun@mediatek.com> <1567150854-30033-2-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1567150854-30033-2-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 15:40:48 +0800, Chunfeng Yun wrote:
> Support USB wakeup by ip-sleep mode for MT8183
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2~v3: no changes
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtu3.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

