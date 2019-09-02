Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC9D0A59DF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 16:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbfIBOyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 10:54:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35440 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731106AbfIBOyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:54:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id n10so4250822wmj.0;
        Mon, 02 Sep 2019 07:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F6pY8kpCuq7zlHq4xPF57ULoqr+YYfsWTM9u8bPhit4=;
        b=fEqqcVEJokEicoO5Otdkd/pzPR0gDt2nvJxH5wyIU0G3IgdPiDdvc2RgVFSAecxoJU
         aI5f+CTrh+uZTwCsa0JEkCNmBJl++wljI4IkcWlMy2UiiTPyDMLm0WCshbl09rHCv+Gz
         LkWI8B7mQKrkh6piTlynyDwIvZSHKKfc/uzDovLNSxerEy1TKWTJx1RLzXCIZsAB63h9
         4MJ51tfpBYvdJFi5mdSYhmtrPYhdRhrg/z1d3mUmV04yNYxZAJzhhgQ0hQhHczz9GEmv
         t+6rJyoo/tQlkdXX7Bs7ajamR1qEZQArQ5JnfsKQGEio9fBwxOS4cHk56ws/wxa/QmJr
         mTEQ==
X-Gm-Message-State: APjAAAWbeQa7UBsmYmX7LKeciKU9b2dHf/UpwFWZlJc6JKEF+dX645Fb
        miR9BE0OpTEkytwqh/ZEgg==
X-Google-Smtp-Source: APXvYqyxBMZBsZ+aukgd6fwk4huBxHWlwunpvdDu+ChONM81kBs8+TPP0OQ3X3Fa4ohcaeuJotjHDQ==
X-Received: by 2002:a1c:48d5:: with SMTP id v204mr29808232wma.109.1567436046870;
        Mon, 02 Sep 2019 07:54:06 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id h12sm11612250wrp.51.2019.09.02.07.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 07:54:06 -0700 (PDT)
Date:   Mon, 2 Sep 2019 15:54:05 +0100
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Pitre <nico@linaro.org>,
        Sebastian Capella <sebcape@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 3/5] dt-bindings: arm: idle-states: Correct "constraint
 guarantees"
Message-ID: <20190902145405.GA16010@bogus>
References: <20190830150302.20551-1-geert+renesas@glider.be>
 <20190830150302.20551-4-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830150302.20551-4-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 17:03:00 +0200, Geert Uytterhoeven wrote:
> Correct "constraints guarantees" to "constraint guarantees".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/arm/idle-states.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
