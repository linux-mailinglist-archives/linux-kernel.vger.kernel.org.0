Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6A5C33DA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 14:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732862AbfJAMI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 08:08:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44997 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfJAMI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:08:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id 21so11262884otj.11;
        Tue, 01 Oct 2019 05:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bsKuMui1/xIoRg9sgW3QW1zBNcxnt/Bx1wXQKc1PEYw=;
        b=K+DuMYxe5AFY6jMyR9GF4N/ICs9VhMRnq90JOIv0ry1NQuDP5Ayj4xOjHkoVivOlyY
         Oxj0TJH6/durEsLzVzRDEqgvrlZb8YddkZXJXJnzWmHf2RUWUkqsA9o4PEp9yKvp6tsS
         tEMWPwVcVACb0CS4L6k/eqiCep7ru4vL/yizEyYvqdcYe+B1077pQJK8KdcQdl4UwaBF
         mC67LbPi4VeWKjI/5XW4pqaErKDkmQs0K4dILmLACEpigDyYYR55uaF26dUJV0wLkJyu
         qC52oP2fstIIn9RXK6kqxaXJ8dWisNCZ8p4zawx+DASRS6FHuHf9U9UzHDF4Su7wNty/
         RShQ==
X-Gm-Message-State: APjAAAUuIhQMEEVrv0F8q1940zeVBau+oBy30eD8ThrmPYsokqQVYYZl
        nOVfk1BIbx34+YUeJARbWw==
X-Google-Smtp-Source: APXvYqzmhKuiodn2k2rjYHtIY+sxnIt9AOC3JK/zLBpGlQPeOA32z0qruE+A+HepzhYskR0Jx1n7iw==
X-Received: by 2002:a9d:19a8:: with SMTP id k37mr17930702otk.172.1569931708065;
        Tue, 01 Oct 2019 05:08:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z3sm2524158otk.45.2019.10.01.05.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 05:08:27 -0700 (PDT)
Date:   Tue, 1 Oct 2019 07:08:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, jejb@linux.ibm.com,
        Martin K Petersen <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Janek Kotas <jank@cadence.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        nsekhar@ti.com
Subject: Re: [PATCH 1/2] dt-bindings: ufs: ti,j721e-ufs.yaml: Add binding for
 TI UFS wrapper
Message-ID: <20191001120826.GA4214@bogus>
References: <20190918133921.25844-1-vigneshr@ti.com>
 <20190918133921.25844-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918133921.25844-2-vigneshr@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 07:09:20PM +0530, Vignesh Raghavendra wrote:
> Add binding documentation of TI wrapper for Cadence UFS Controller.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  .../devicetree/bindings/ufs/ti,j721e-ufs.yaml | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> new file mode 100644
> index 000000000000..dabd7c795fbe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ufs/ti,j721e-ufs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI J721e UFS Host Controller Glue Driver
> +
> +maintainers:
> +  - Vignesh Raghavendra <vigneshr@ti.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: ti,j721e-ufs
> +
> +  reg:
> +    maxItems: 1
> +    description: address of TI UFS glue registers
> +
> +  clocks:
> +    maxItems: 1
> +    description: phandle to the M-PHY clock
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - power-domains
> +
> +examples:
> +  - |
> +    ufs_wrapper: ufs-wrapper@4e80000 {
> +       compatible = "ti,j721e-ufs";
> +       reg = <0x0 0x4e80000 0x0 0x100>;
> +       power-domains = <&k3_pds 277>;
> +       clocks = <&k3_clks 277 1>;
> +       assigned-clocks = <&k3_clks 277 1>;
> +       assigned-clock-parents = <&k3_clks 277 4>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;

Based on the driver you expect to have a child node here with the UFS 
controller? You need to show that and have a schema for it.

> +    };
> -- 
> 2.23.0
> 
