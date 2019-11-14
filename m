Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01525FCD63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 19:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfKNSXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 13:23:22 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39622 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfKNSXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:23:22 -0500
Received: by mail-ot1-f66.google.com with SMTP id w24so5230612otk.6;
        Thu, 14 Nov 2019 10:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=We1eIYfe7WX/UTvD7cIZM+ofCDWLAgk+Qxj1BAO42b0=;
        b=MS9OmltjYAePhdsy4glsehhX8e9L+qcA/zlKdT+uKSNsDjF+v9xztc2Sx2+FwEszq1
         jRi/a6q4NWnRiCYWMvcqYlg6l3tRE0iMA+s0/c4aSQ0B+TEPbu1XyZ12RdWx578BrX8b
         BcdF+nrQ0u0uuBnMNrQw0z61CQPRUyLK6JpwP7ccsMp9LWu6DFxgF+EgUhOlOjgBPj72
         1+hwZZOP6VcNOyJJBRNke0g2/hcA+YL4ET9Q+Xv3Lv1aWjCUDZp95997sLCUDoyaLv2r
         pJdgS6qfVP6KzMa+xWFKPwdXJck4yGYKQXlJTAG3zRyf8T61ECJumrxTocs3BmVxBKnB
         NA0w==
X-Gm-Message-State: APjAAAVXdLcj3cpAxTiMLVnLC1zyzHKInt7CEg+wp3/Vy1EoYU5uDYAL
        sBBiSAsepecbZPODb/ROxg==
X-Google-Smtp-Source: APXvYqwo6kXGEPryKuL+HGAKREL3C89a1kwOGngbbA0H80iPNwUDrvY5GU9i+B3nKYJHrbeIg95QjQ==
X-Received: by 2002:a05:6830:1143:: with SMTP id x3mr8612180otq.274.1573755801307;
        Thu, 14 Nov 2019 10:23:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 37sm2055877oti.40.2019.11.14.10.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 10:23:20 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:23:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, andrew.smirnov@gmail.com,
        manivannan.sadhasivam@linaro.org, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: add compatible string for
 Tolino Shine 3
Message-ID: <20191114182320.GA21532@bogus>
References: <20191108111834.18610-1-andreas@kemnade.info>
 <20191108111834.18610-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108111834.18610-2-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Nov 2019 12:18:33 +0100, Andreas Kemnade wrote:
> This adds a compatible string for the Tolino Shine 3 eBook reader.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
