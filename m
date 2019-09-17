Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A37B56EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 22:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfIQU1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 16:27:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38756 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfIQU1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:27:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id e11so3130292otl.5;
        Tue, 17 Sep 2019 13:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s83Wv5uCp+7Qj+4GmDjA5Ca5EmGbCciwbwiS4sYI9qI=;
        b=gFZS8NE1Es47IPtbTmIi6oe0cVE1jjwhGTWnqsaEYFzPf/H6L+1rUmFaiwVd8NJDgf
         xntJDmcMw2WkilbCzhV0nQEz385lFhzoylYNLh4lEqUfUT7HmzQXRBFY2fwTt3mkW5d/
         xhxiPfA9uPqBYDXJt2ghYFoLRaZV5yASWCQeXXOd3pe4JaJFlgMVn9ut56X0RniSUh7H
         vrr70ndw4Tnk1aLvjhkJzaHtVjnnpTim8BM8GFTe2wKJeFk3ytpO6Jx0HkswFK9wQZsk
         ceXtEXd2o4QdSjDq/IUnFtE1xDtoRU4dw/L/nJ/emIyQ4kOClB0k4mYo3oXlVrfYOmYk
         qSmQ==
X-Gm-Message-State: APjAAAX96p2RmuIgTripemnt6IyEzxjpIEZvYnL9Y2EI9gqP8AxCGKXc
        yujRIH8JtI1Xu5Jg/E/es3VFo7AUHQ==
X-Google-Smtp-Source: APXvYqyBsKu4pZeTpW1VfblTNNE7l4+9V7A8vmvIBWG8fqYJX20migoouN+/XxWz8CBFdryNxUXvmA==
X-Received: by 2002:a05:6830:1047:: with SMTP id b7mr625204otp.68.1568752029207;
        Tue, 17 Sep 2019 13:27:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k3sm1026619otn.38.2019.09.17.13.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 13:27:08 -0700 (PDT)
Date:   Tue, 17 Sep 2019 15:27:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 02/11] dt-bindings: phy-mtk-tphy: make the ref clock
 optional
Message-ID: <20190917202708.GA11898@bogus>
References: <1567149298-29366-1-git-send-email-chunfeng.yun@mediatek.com>
 <1567149298-29366-2-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567149298-29366-2-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 15:14:49 +0800, Chunfeng Yun wrote:
> Make the ref clock optional, then we no need refer to a fixed-clock
> in DTS anymore when the clock of USB3 PHY comes from oscillator
> directly
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: no changes
> ---
>  .../devicetree/bindings/phy/phy-mtk-tphy.txt        | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
