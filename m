Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30D01304DF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 23:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgADWFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 17:05:17 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:45387 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgADWFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 17:05:16 -0500
Received: by mail-il1-f193.google.com with SMTP id p8so39396051iln.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 14:05:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P9KYy5rXT1YHxu2ntjIRtLSaQMqlhK4uAwxwZ9CTSeA=;
        b=s+BfV1IK3tF/DW2YydG515vqg6ngAwAaDuxAb8SXmp0FdW9tJXxPI/BysWrYP6TGIZ
         KKNdJpVoL4+mR0kxxH6VSVgEMhIqN8apoOvvpZ59vHT14H//B6RxBqb4tWuyOX/ratbo
         DWrkK48QH4sj4zMB/PFU1duFPmlpLFndgEYDDTZldz5wbBjIFcE0xoQi614hjfsATjPf
         4N8sJVjCUUa95DytYo85hvSC+ksW0+DnnhUZGZzkfGv1W1fsbjiqNZTap5Yg7hbVbXdh
         nD+zqYeulBFeMTZVkQkz1plHCZVKmXg+O85sXSNkRcZayfF19DLEojZmsTnpg5c6CRrT
         vJ/g==
X-Gm-Message-State: APjAAAVBpuH0rSal2zltUaJ6xmPLD++dd30WnTqzLR3KiD/jV2+Xmbhc
        ohdPc1dKV7wwCNVX1XEVP4VX7dY=
X-Google-Smtp-Source: APXvYqwFPYiseT/6of3tfawD7+Dg7urJe/qpB35J/ZErzl5t98Zh9DvrZzmfMG2Rqm3ei2be3ARBkw==
X-Received: by 2002:a92:5c8f:: with SMTP id d15mr86892157ilg.102.1578175516146;
        Sat, 04 Jan 2020 14:05:16 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id w5sm15256025iob.26.2020.01.04.14.05.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 14:05:16 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a3
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 15:04:42 -0700
Date:   Sat, 4 Jan 2020 15:04:42 -0700
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        andrew.murray@arm.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, vidyas@nvidia.com,
        sagar.tv@gmail.com
Subject: Re: [PATCH V2 2/5] dt-bindings: PCI: tegra: Add DT support for PCIe
 EP nodes in Tegra194
Message-ID: <20200104220442.GA11478@bogus>
References: <20200103124404.20662-1-vidyas@nvidia.com>
 <20200103124404.20662-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103124404.20662-3-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2020 18:14:01 +0530, Vidya Sagar wrote:
> Add support for PCIe controllers that can operate in endpoint mode
> in Tegra194.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Addressed Thierry's review comments
> * Merged EP specific information from tegra194-pcie-ep.txt to tegra194-pcie.txt itself
> * Started using the standard 'reset-gpios' for PERST GPIO
> * Added 'nvidia,refclk-select-gpios' to enable REFCLK signals
> 
>  .../bindings/pci/nvidia,tegra194-pcie.txt     | 125 ++++++++++++++----
>  1 file changed, 99 insertions(+), 26 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
