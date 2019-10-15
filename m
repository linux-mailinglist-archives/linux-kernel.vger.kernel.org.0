Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5DCD8007
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 21:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfJOTUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 15:20:50 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42127 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389685AbfJOTUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:20:39 -0400
Received: by mail-ot1-f67.google.com with SMTP id c10so17978966otd.9;
        Tue, 15 Oct 2019 12:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h5H37sJ61LUD/ljVtDlhAsfO5sV6TmGgopvlbfaEWZ8=;
        b=R/G4n3rtA3ZltIb8m/phOlhtrybEqyRRxaXAWJvPuyi+RPBDUrRF+oakI79/2a9JHL
         YidDUpPLuUy2UD3+Lc4pj5bNpmF/b0L+WY/BgexUr4UDoNEGYDGJ4tF4PP38llw8QwIo
         pBYQLL4cHp661DjsMaYh5cpqR9VY9AVd893WxlYBQxevDlEK4Qo4YbzmFmiO6hVp4PBK
         LEQ6ExeREwXuCcW46fYKness31xHPlT/pE/WjkWGsIAyDqqKSjtH+3d8j89+9dh3s90p
         IjgSpN9bDmibEK5YFv6AXqFMtxqMmAYM4p8AChV8dmT9+YjjuAz/XGSm8VZLRRfwwceo
         aV+A==
X-Gm-Message-State: APjAAAUBAM75/ofVxEMJsFAoko+jGiRw3s/CFxpxdv9pUStlClB3data
        hSEK2wVZHg0x22uys78qEQ==
X-Google-Smtp-Source: APXvYqwDWbiw9IcWLzy5NFqYMdjvTEqwdZgk4ryuCSiUp5VaQHf/4LJS4ik6SQYzDlQ79863axHHdA==
X-Received: by 2002:a9d:7d02:: with SMTP id v2mr3381533otn.301.1571167237726;
        Tue, 15 Oct 2019 12:20:37 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t12sm6526227otl.35.2019.10.15.12.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 12:20:36 -0700 (PDT)
Date:   Tue, 15 Oct 2019 14:20:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Argus Lin <argus.lin@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>, argus.lin@mediatek.com,
        Sean Wang <sean.wang@mediatek.com>, wsd_upstream@mediatek.com,
        henryc.chen@mediatek.com, flora.fu@mediatek.com,
        Chen Zhong <chen.zhong@mediatek.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: pwrap: mediatek: add pwrap support for
 MT6779
Message-ID: <20191015192036.GA26160@bogus>
References: <1570088901-23211-1-git-send-email-argus.lin@mediatek.com>
 <1570088901-23211-2-git-send-email-argus.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570088901-23211-2-git-send-email-argus.lin@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2019 15:48:19 +0800, Argus Lin wrote:
> Add binding document of pwrap for MT6779 SoCs.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
