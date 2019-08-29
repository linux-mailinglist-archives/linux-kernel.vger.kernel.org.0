Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E640A2797
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 22:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfH2UDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 16:03:40 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45263 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfH2UDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:03:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id v12so3529890oic.12;
        Thu, 29 Aug 2019 13:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fe48EA/lrnYeLoShqq/wJVBSHCBQzaaiMh4iOsHhtSk=;
        b=F9zwCoMXzONUYCTnzrVzZevGNkgp6PYS6RZucFrPhzfghxVCcalk3reGK9nL2M4XO+
         k/PVSFUptqIShJaR2fCK5aKKNvN4Fquknai7ihI3KUWnbjygV56Go2tegjPdXWro4SM7
         surv9Mx2do3ph/Fv6x8TJf8yyNcnMpHCXGBQGXmt60qU73dZpmeo76bMqAsQHrMaBDTo
         BnSeUQkfcGYK23Ndl3uLONzrVuieqkVm1dI4hkLSpPpP6YvBzcXcGCUv3VycFkllZGOG
         7wsHSQfqLujgYhz+DHyKHKL3+gAJpF3JcT9VHoFN8OOBCXO24aMsRzeyYG8XphvnvZ3I
         W4aQ==
X-Gm-Message-State: APjAAAUqcUK8HDzDAO/CNXMaFaAn4E+rePRWriplU9m2sIwbqgPffqX+
        Iwq9CAvhV6eg6d6gp78VvWocWPc=
X-Google-Smtp-Source: APXvYqzebdNW3pcTlU42Qg2N1t7Occifs485wZxka97FtzwqrJOJYJk4p51QOaVG6EfPhPJAeJOmbg==
X-Received: by 2002:aca:c749:: with SMTP id x70mr7452126oif.64.1567109018502;
        Thu, 29 Aug 2019 13:03:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o77sm428231ota.8.2019.08.29.13.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 13:03:37 -0700 (PDT)
Date:   Thu, 29 Aug 2019 15:03:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 03/11] dt-bindings: phy-mtk-tphy: remove unused
 u3phya_ref clock
Message-ID: <20190829200337.GA2169@bogus>
References: <e99c0d7a55869a4425250c601b80a3331c9d0976.1566542696.git.chunfeng.yun@mediatek.com>
 <35d020857cd0e2fdc77023dad36221288d7a5fe1.1566542697.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35d020857cd0e2fdc77023dad36221288d7a5fe1.1566542697.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 15:00:10 +0800, Chunfeng Yun wrote:
> The u3phya_ref clock is already moved into sub-node, and
> renamed as ref clock, no used anymore now, so remove it
> to avoid confusion
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 4 ----
>  1 file changed, 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
