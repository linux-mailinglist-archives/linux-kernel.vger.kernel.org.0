Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 973F711EE79
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 00:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLMX0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 18:26:37 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41941 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMX0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:26:36 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so2069616oie.8;
        Fri, 13 Dec 2019 15:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9tBcNOCxqPdqixtTHmzQKgwSJzOr34ZtfeLXIY6339k=;
        b=khVneIrKmjIAtmnIrM+drJeKx9TkuhUDIKXE67ML5R5AtyD9WEOMH65pfxpdznRvcT
         APK1x3EbjQJmVA3l9Feu7Rnvx1l+UdvYKnoPN2wbWsIAO0SQHcxVbbM7R7Gt2D+jI2n2
         51BD4jrykrWutXbpSnCxFBC9rwvZ+Uhko3Ey4P7L0aRQvrsvg3MlgxCD1dmZuvNigEeB
         ujmrcF37JuBf53ylRpAIMqC1aECmhMAbIoQ2qeoQWtAVpowKCd0O36zevmoUNMjJnw9Y
         wj7mpQ669qHXIwnVMmDa7TqP+ChIrC++HEi+iQc2ZUiNbeyUb2hFOPtNVc0Y5z+fKcfA
         MPVg==
X-Gm-Message-State: APjAAAVuknYfRwxHpvUZE5wZ6shmLmjbrWAxXYeTtu46+CvknbkHDSnH
        afFxHh8xs1QQEuHhtq4UZA==
X-Google-Smtp-Source: APXvYqwNYGgD2lL8HkWOAPYgLrNju3VL3N1vf+LrHhWb+bLnt1opXtXZP9zsrWmQ8iKm2ZyeU5xyfQ==
X-Received: by 2002:a05:6808:102:: with SMTP id b2mr8248272oie.127.1576279595637;
        Fri, 13 Dec 2019 15:26:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l128sm3844610oif.55.2019.12.13.15.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:26:35 -0800 (PST)
Date:   Fri, 13 Dec 2019 17:26:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     gabriel.fernandez@st.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gabriel Fernandez <gabriel.fernandez@st.com>
Subject: Re: [PATCH] dt-bindings: rcc: Convert stm32mp1 rcc bindings to
 json-schema
Message-ID: <20191213232634.GA21711@bogus>
References: <20191202150343.27854-1-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202150343.27854-1-gabriel.fernandez@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2019 16:03:43 +0100, <gabriel.fernandez@st.com> wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> Convert the STM32MP1 RCC binding to DT schema format using json-schema.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  .../bindings/clock/st,stm32mp1-rcc.txt        | 60 --------------
>  .../bindings/clock/st,stm32mp1-rcc.yaml       | 79 +++++++++++++++++++
>  2 files changed, 79 insertions(+), 60 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> 

Applied, thanks.

Rob
