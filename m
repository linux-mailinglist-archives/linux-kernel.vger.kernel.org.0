Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80FCCE9010
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 20:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbfJ2Thp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 15:37:45 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45477 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfJ2Thp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 15:37:45 -0400
Received: by mail-ot1-f67.google.com with SMTP id 41so10806252oti.12;
        Tue, 29 Oct 2019 12:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OaBB0CUagHiRXxagwoyDSZGw2BJpV74SXdj8bbEIrrA=;
        b=ffhUx5keMfdg35RJGw3NyhekUQVAFSNjh7R481O4xxfBDUn0Gjwem3aeV3TSboMx7R
         hm1d+7jMQh52B4eUVE5ynEk05vQVE/XKpSidl3D/xMivFjlgjP7GVCTS8vTu/v6Z32Uj
         nvelELMllhXvhm/Rc+H5TYOxzV9v6kwGIj7+sPXxirqI7e0sm8Yw2DazFqryQJ4AOmX3
         hHRd3c45X+FF/rEkGetgMX+ofU1EdpUqUkyhX8mD+PgcPe752VroQXfHBkXBffbmbtR/
         kxrw7fwYL7PmcumFtt7iNJh+DRxcCKhp+Wtuv96bEPYbWdfANdOk6DbmQbqVNwL1tcrh
         WxOQ==
X-Gm-Message-State: APjAAAX4GZG06CwOFOzYvdppBJzXP4CbQAOpitDRFqQBtCo/SeVGWiwx
        ieurT78K7SwdJyvlUAqCoA==
X-Google-Smtp-Source: APXvYqwZ2xIiHy2/3tXNmgZ6nBmM979oLi3UT7TFiyN04uFGKSjWipp3wWwBMve5J2DU09YvST5EwQ==
X-Received: by 2002:a9d:5f89:: with SMTP id g9mr19011647oti.227.1572377863984;
        Tue, 29 Oct 2019 12:37:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k204sm4253897oif.33.2019.10.29.12.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 12:37:43 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:37:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        darshak.patel@einfochips.com, prajose.john@einfochips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm: Add devicetree binding for Thor96
 Board
Message-ID: <20191029193742.GA14965@bogus>
References: <20191024144235.3182-1-manivannan.sadhasivam@linaro.org>
 <20191024144235.3182-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024144235.3182-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019 20:12:33 +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for Thor96 Board from Einfochips. This board is
> one of the 96Boards Consumer Edition platform powered by NXP i.MX8MQ SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
