Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13693FCD80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 19:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKNS1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 13:27:43 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39717 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfKNS1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:27:43 -0500
Received: by mail-oi1-f195.google.com with SMTP id v138so6177513oif.6;
        Thu, 14 Nov 2019 10:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8He97cXELbuSFR63zDapnWyBHvhWcxQcIpiz/Ztauww=;
        b=MRBYZjv0q7osCTThc3lRIBXvlFVYEuJ7lxlsKA9HSH75WKb6LURoySd8zN/8g+n4sT
         ZKB+lS+s8TvdD62FSjl7CyZJjhJL6RLvhcozTtpYtNj4x48Jih2Znwi4dZ6+gJmHjIpC
         IIMH72W5X6MwK8AukjZUoLOPXkrgKfisE45Dq85nZme/8GvPkiWRXKPxChV7OKv1C+Ve
         DxizF9+heY9gPkQiKw1x46YuCCcbZJxK3uN0x5PMeHLmRRrx2jWHIZHCS4s2nDuRYFJy
         JCO0BsVBp6cxnNWJ4oTR96TbgONpkAndQPGDtAqFeHNcEZrK8+HaVYJI9c+zmjMz2mkF
         6V3A==
X-Gm-Message-State: APjAAAWzWGpABe/nFCixJkuFtXrpWbtCvx2lMIGyor2SI7SGy1VWUvrk
        TeFASJg5Muey43es2TmKSZCP688=
X-Google-Smtp-Source: APXvYqzxQagjwTYvMPUFG0Oo9zNFaeioYxFRTV5TSy89ohIWgShYag+Hww7iOkylWMfxMjF0FwasPQ==
X-Received: by 2002:aca:cd02:: with SMTP id d2mr4814481oig.80.1573756062663;
        Thu, 14 Nov 2019 10:27:42 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 65sm2036620oie.50.2019.11.14.10.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 10:27:42 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:27:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
        lionel.debieve@st.com, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] dt-bindings: crypto: Convert stm32 CRC bindings to
 json-schema
Message-ID: <20191114182741.GA28603@bogus>
References: <20191108125244.23001-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108125244.23001-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019 13:52:42 +0100, Benjamin Gaignard wrote:
> Convert the STM32 CRC binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/crypto/st,stm32-crc.txt    | 16 ---------
>  .../devicetree/bindings/crypto/st,stm32-crc.yaml   | 38 ++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-crc.txt
>  create mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-crc.yaml
> 

Applied, thanks.

Rob
