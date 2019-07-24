Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 238EA73FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 22:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389318AbfGXUep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 16:34:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41090 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389166AbfGXUen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:34:43 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so88278831ioj.8;
        Wed, 24 Jul 2019 13:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uHLqz6FDkSCI8LzqIEBRdrQs7zeUsE0ZRMiorxW3eeM=;
        b=OZkOOH6XGRw5toLoh7UNUatXnUD/sdqLhWbJcD7YEL+oswd1czwfTneOUVECSEXZNs
         yw439iSg9Yaq/lhfQVQ+mPsJRfSlk/eeUk6GGWD3sJGogP6ZUt5tmJVwp3cZY8InsJlv
         OOzuSA24uLr73oU4hbFY3WA/dcKeLSPHssPdDlnEdb5clMFHL6YpwqLX/4nFahxZqksk
         eVPffTDrINE+elUHa+l/bbxKpyHuWJTc4FtJVlt+Wl7VP8z3GKGIMIfIj34bgPMjAsYW
         z6roznpiHpsJ06thP+9qbVxLx8lCFlrn3NBKwikXVw+4UVlEsNuJkvb/ABgpXAyVOFXX
         2/9A==
X-Gm-Message-State: APjAAAVlEhTIgPId7bLrnCcbIcFq5NIA+i1NE8qcEeSFjIaX/SS1CsAT
        Amh2HKq3E0qbdOFR7v+8EQ==
X-Google-Smtp-Source: APXvYqyiTSzmcos+LtyMuQu0VL4DAqAkhvqzWm1usV7kqdE4UV43i+gHAw7kW1rK2LIWDuuVMITEbA==
X-Received: by 2002:a5d:9749:: with SMTP id c9mr13123190ioo.258.1564000482978;
        Wed, 24 Jul 2019 13:34:42 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id c14sm37067202ioa.22.2019.07.24.13.34.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:34:42 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:34:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] dt-bindings: imx-ocotp: Add i.MX8MN compatible
Message-ID: <20190724203441.GA22721@bogus>
References: <20190711023714.16000-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711023714.16000-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2019 10:37:13 +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add compatible for i.MX8MN and add i.MX8MM/i.MX8MN to the description.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
