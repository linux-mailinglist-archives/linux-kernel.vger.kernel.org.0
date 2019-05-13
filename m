Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A501BC91
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 20:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfEMSCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 14:02:48 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38734 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfEMSCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:02:48 -0400
Received: by mail-oi1-f194.google.com with SMTP id u199so10053239oie.5;
        Mon, 13 May 2019 11:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/XhxD4qfD0ns8reknvj9RpAcHKvugYCkDKZURXupK5s=;
        b=GqLvDquXh4nnzTx8N0cFStCnk6zxse0HiHNMUoBLc6XxYmul1bVsCg9lDFa1bH7c65
         VPiSvWIxt/nyJSgvJxqbcXGFUUxilpOSJaNnZwaPo2tjPI1bJPOh0iIEFIfELmmRYKBb
         AeIK2HulGZzvTqRsE+2m/ddGq2lxFJY3SQb4lFp8eWn+M7tantNxexErmOpVPeB2ncz0
         ifUq6uAdnn2x/22PcqP2TMFkIoKxf9G7We9WoyaCCQ6T3RZZhmSnsPsC/iPPRrek8G8P
         sjrfF2os184RjgDF3b/JBC01zc5OMj0d0j9ETnyRaLgyFl7T4+nrkZrLb6obQas3rWJZ
         s/Hw==
X-Gm-Message-State: APjAAAUxBgoFv80kIIMLOL5ZgHhdTf/SPN32MVMEYpoaBMQ7fnj1296x
        4uP1jXAbxuWuux5948BQnA==
X-Google-Smtp-Source: APXvYqx+ua4Ihwv0KGSXt2vA9ULzrBLsnrobys6zGYP5eS/LZsAKrESt0LAOr0df0+FCAMzvi5AZjQ==
X-Received: by 2002:aca:bd09:: with SMTP id n9mr301808oif.56.1557770567715;
        Mon, 13 May 2019 11:02:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y3sm5243396oto.58.2019.05.13.11.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 11:02:46 -0700 (PDT)
Date:   Mon, 13 May 2019 13:02:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: stm32: Document Avenger96
 devicetree binding
Message-ID: <20190513180246.GA8487@bogus>
References: <20190506100534.24145-1-manivannan.sadhasivam@linaro.org>
 <20190506100534.24145-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506100534.24145-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 03:35:32PM +0530, Manivannan Sadhasivam wrote:
> Document devicetree binding for Avenger96 board.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.txt b/Documentation/devicetree/bindings/arm/stm32/stm32.txt
> index 6808ed9ddfd5..eba363a4b514 100644
> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.txt
> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.txt
> @@ -8,3 +8,9 @@ using one of the following compatible strings:
>    st,stm32f746
>    st,stm32h743
>    st,stm32mp157
> +
> +Boards:
> +
> +Root node property compatible must contain one of below depending on board:
> +
> + - Avenger96: "arrow,stm32mp157a-avenger96"

With which SoC compatible?

> -- 
> 2.17.1
> 
