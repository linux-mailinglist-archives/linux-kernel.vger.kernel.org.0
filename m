Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F36123B20
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 00:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLQXtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 18:49:02 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42931 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfLQXtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 18:49:02 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so52499otd.9;
        Tue, 17 Dec 2019 15:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jlg2ki2yobPLE5+Iz6CrZ9HDHot4jm6bFyP7eLrU3qQ=;
        b=FqvyGhL7of1GOVREgL/8ejZuNuqIPJTFRMX4xCIXw0we4NM053Q0qZ/np3717xs+EL
         pY7iBu+ixQtSX5z0w2J1BetHrLbHLkU+0umS7KUm4+5OobkgS4SwMy0LVzdagLOYawao
         AFJTZqWXraRvn+1+irNhBVGS7UejBbAuZdnzXkPRgmSeWgTO6+pjz72frMz5OAYtFDRU
         Ajlv1RpcfNGJTTQwL8hIqwohgTiHOYBf0BplwEQL7oKOM9thAZUnKF1MF8+TNicYg1bY
         LaOi7KkrQPS398/1QA8QXgX9wjI9FQOghBCkFsW+s/jQiBwy/2DywbTF+ICZBiBsZ2Qw
         0I9Q==
X-Gm-Message-State: APjAAAX/Hat2pBn9/dxEWIKqMfd0Tm1mR3kC+AwJq9LSb8qg9cL/I5B3
        uCGVqmDzeefm7fjxoNcjRQ==
X-Google-Smtp-Source: APXvYqw+ktR6zmWC15DCzXWZThyq8OS0sep09XrYuNDJkj8QrlsDYGIEMrNnc9m27AMPyfWoF5gKSw==
X-Received: by 2002:a05:6830:22e2:: with SMTP id t2mr81055otc.129.1576626541083;
        Tue, 17 Dec 2019 15:49:01 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g8sm116989otq.19.2019.12.17.15.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 15:49:00 -0800 (PST)
Date:   Tue, 17 Dec 2019 17:49:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v2] dt-bindings: stm32: convert mlahb to json-schema
Message-ID: <20191217234900.GA429@bogus>
References: <20191217082415.14844-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217082415.14844-1-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 09:24:15 +0100, Arnaud Pouliquen wrote:
> Convert the ML-AHB bus bindings to DT schema format using json-schema
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
> V2: Add "ranges" property as mandatory
> ---
>  .../devicetree/bindings/arm/stm32/mlahb.txt   | 37 ----------
>  .../bindings/arm/stm32/st,mlahb.yaml          | 70 +++++++++++++++++++
>  2 files changed, 70 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/stm32/mlahb.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
> 

Applied, thanks.

Rob
