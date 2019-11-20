Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9051042C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 19:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfKTSBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 13:01:09 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33620 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfKTSBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:01:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id u13so422922ote.0;
        Wed, 20 Nov 2019 10:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UtnezaPuJR3DtOQdYq4UX6HRJep5yiFrHSjeRzh0lw8=;
        b=sx93LySF7PsnLg5lJPQ16VdQPGk2fJpz7sjNg+Ruu9Bt9h+6nRb0BXO7C6B9CYYXPq
         cqko1uJKgNqGpYXZt+Zs7x4wT9xO5c1BcSH9qn1ConfnVWb/FMm4+hlLfvQMADgi2ZJc
         RaybJSA2qHp/e/7kWxHySjUr6Pk0zSVa5+YGxSvOi/N8XkKsx3OueDmd6UyAdLjycrVR
         Op5jSb68TEgapN9g3BrzweqdI6T9xeQopnX5woeWAOzwfvmuI241F1qTxk/3hls5NlZO
         sGmBT6/g71SqpaTXbLj69TsSH+k5sEg8tvDcv9qzLsxLZQQ3NfiqbSVeuRHNsylaj4Q5
         7cPQ==
X-Gm-Message-State: APjAAAUc4xtXN+c2c5hBn7Qxk2Nt0pGQdBFUpE2utlYf69aeblATraMN
        cXu7ZdTJYVM8UvvbnlMPAg==
X-Google-Smtp-Source: APXvYqynzcOYtJD1o3rqHfApKvPoyf3FBMEtPkZFYjA48wZ6n/YuiuIZDoHhntnj4J8//Fy+4USHdA==
X-Received: by 2002:a9d:70d0:: with SMTP id w16mr3098883otj.239.1574272867110;
        Wed, 20 Nov 2019 10:01:07 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w25sm8731323otj.45.2019.11.20.10.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:01:06 -0800 (PST)
Date:   Wed, 20 Nov 2019 12:01:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
        lionel.debieve@st.com, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2] dt-bindings: crypto: Convert stm32 HASH bindings to
 json-schema
Message-ID: <20191120180105.GA11465@bogus>
References: <20191115102427.31224-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115102427.31224-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 11:24:27 +0100, Benjamin Gaignard wrote:
> Convert the STM32 HASH binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 2:
> - add type ref, min, max and default values for dma-maxburst property
> 
>  .../devicetree/bindings/crypto/st,stm32-hash.txt   | 30 ----------
>  .../devicetree/bindings/crypto/st,stm32-hash.yaml  | 69 ++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-hash.txt
>  create mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml
> 

Applied, thanks.

Rob
