Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB91C43A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 00:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfJAWSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 18:18:14 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43223 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbfJAWSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:18:13 -0400
Received: by mail-io1-f68.google.com with SMTP id v2so52119399iob.10;
        Tue, 01 Oct 2019 15:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RsWAdabUatVMhYn12Iozr/H7dptelk31XasqIoKTsS4=;
        b=rMQSd3DTQPp1Y9wUZiUFxx534khjVSyw96chU42koQHVUJ4bAb5CWAzoQ8BTHw4Aji
         WOBX/E3TQMG1NXYX+kfqoETNeOI0WNrNiwq1CcFaFcDaG2URGIlaIo7pndbuf/3/aglA
         P7ViobQZh1x2eKJarsisb1+8aBsOEYI3JIagqqrPwaw+VSGUgz9ZxrURgL9XB+iXqkvh
         d51w2qqQftk724ohBcRw94xz1vinLplo+FAVLl46E6zjY2a16KZzEHnfJMHMCWvnQ1a7
         +8KLLpZi/UGbNMuUWUm6CUA7Gg+BdmYiEc2PuP06hPYWiRSh3qxDrGrUhh2wzO27pO8J
         kovQ==
X-Gm-Message-State: APjAAAX/QDdOc6dsYqhVTgZSdTE+D4AzI1Z7j1mE19Oa1Til0C7YUwTH
        3gcyXEVZ4SM40vCh4jkJkA==
X-Google-Smtp-Source: APXvYqzq/7o3WbQlwTRcdgsyMjjmwsAfkmaZ1+Sxbxtnm4itC1b+rcwyiZsnib45TTg1BZKHl2H2Jw==
X-Received: by 2002:a5d:9dd7:: with SMTP id 23mr477156ioo.182.1569968292792;
        Tue, 01 Oct 2019 15:18:12 -0700 (PDT)
Received: from localhost ([2607:fb90:1780:6fbf:9c38:e932:436b:4079])
        by smtp.gmail.com with ESMTPSA id z1sm4183486ioe.8.2019.10.01.15.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:18:12 -0700 (PDT)
Date:   Tue, 1 Oct 2019 17:18:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Andrew Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-imx@nxp.com, Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: Add PHYTEC i.MX6 UL/ULL
 devicetree bindings
Message-ID: <20191001221809.GA23905@bogus>
References: <1568980346-385840-1-git-send-email-s.riedmueller@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568980346-385840-1-git-send-email-s.riedmueller@phytec.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 13:52:25 +0200, Stefan Riedmueller wrote:
> Add devicetree bindings for i.MX6 UL/ULL based phyCORE-i.MX6 UL/ULL and
> phyBOARD-Segin.
> 
> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
> ---
> Changes in v2:
>  - Use seperate description for each board instead of squashing them into
>    the standard board.
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
