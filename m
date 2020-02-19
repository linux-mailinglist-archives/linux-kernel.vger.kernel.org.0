Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FFF1651BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 22:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgBSVg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 16:36:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36164 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSVg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:36:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so25388236oic.3;
        Wed, 19 Feb 2020 13:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DuxIjKakUovTLWJrrUy0F4nZWjjNRF7r2EzINrOf4VY=;
        b=WFnj8wcK2eJUrrcffgSbAbUaJmMo0hIvmQBKS6hYhbtdPspLvhRy4oypUjEzYDYdIK
         rV3SKnBnTC7q6rSAAyXuWrGMjZTUuQSJtZxl9CUvGhMV4jH2KmfePB43pNRzLxpO5bEq
         FqDaXGdYYjJiXlRh/tpRlYC+/tvj6ThIlWNAP8amBFEAtsh0Gyga4zDKSn7QYf4A7hQ1
         9qGzanL5Yxn6zdHknzITGlGx5Ok0c1wpbmm+A8lRfy6VnHPPV1swY46VzYCGklw+XWpq
         UowhmPdRpJnJ/YEQTscTsf8Tm8J38aKx2PhWw99Hm0WZAp9qzzkRM2bpKl4aoEyictmt
         qO7g==
X-Gm-Message-State: APjAAAXrjjihOQhe789sq2V4o7nurKj8SNAVRQz3BSPVTxYsgDawFbqm
        i5VLCYg9bQjiHE6L6fWsvg==
X-Google-Smtp-Source: APXvYqzr/vS7d9QJGh+dXQuTXIewzPQA3FFO3+dnNCb8cuSi1tgLl4sdiFnz8tCgRMksqfyJUey8Rg==
X-Received: by 2002:aca:100e:: with SMTP id 14mr6121071oiq.88.1582148216399;
        Wed, 19 Feb 2020 13:36:56 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p65sm380817oif.47.2020.02.19.13.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 13:36:55 -0800 (PST)
Received: (nullmailer pid 13132 invoked by uid 1000);
        Wed, 19 Feb 2020 21:36:55 -0000
Date:   Wed, 19 Feb 2020 15:36:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Add fsl,ls1028a-dspi compatible
Message-ID: <20200219213655.GA13076@bogus>
References: <20200218171418.18297-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218171418.18297-1-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 18:14:17 +0100, Michael Walle wrote:
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v1:
>  - none, this is a new patch
> 
>  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
