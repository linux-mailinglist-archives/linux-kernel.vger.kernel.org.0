Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C121909F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 23:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfHPVEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 17:04:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41403 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPVEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:04:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so5767846oia.8;
        Fri, 16 Aug 2019 14:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=44wxmAp8F9Ny195d/7nJWW3e/BBIdYzcaKrt+F+uXIM=;
        b=AeygP7et6nxIUUuCnafKG13m2xewE1CE7V7dWV3iAp3tUTgf+ncVHwTtkozYdn5FK0
         eI4/kmpVCahJFm+JsKey/+EnW8mwhUT3wqSdzzVNf9dFkL8nLTrMMgql/BVAidwuBmyB
         gUPi0/B5MTSZdIaAmt2YVibRoJ3HC91YhreeiOoMgAlCmqPHt4TqrdJoAPMSY+Y8eQEv
         rhDWEFpxrjI6kDZOzfJHVpZ/7q1srVF6i6N9ZQ8T6cbKhRfHVbJvuINNtxzxs0STnGb5
         zA9/aOPlHCIqDOqew4aCqxs4ofRprT/NTCelefrrG/IaBUR2yx667teEiQB666XCh+Vt
         WwaA==
X-Gm-Message-State: APjAAAW7lj5pDrvjx27fKMxcMYTa6o8SokGjuMLaYC2Tq9Ao3CWFsA47
        C2c6043CmRVx8AxgbGfxoA==
X-Google-Smtp-Source: APXvYqyXEoglfVtUS7pUYcu1mXmbwfHhxFvihIP68Ikz8fK+6djvGYzwl+pGZ92/fFjSPdwdaIG46Q==
X-Received: by 2002:aca:cd84:: with SMTP id d126mr5962173oig.42.1565989473235;
        Fri, 16 Aug 2019 14:04:33 -0700 (PDT)
Received: from localhost (ip-173-126-47-137.ftwttx.spcsdns.net. [173.126.47.137])
        by smtp.gmail.com with ESMTPSA id a4sm2407098otp.72.2019.08.16.14.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 14:04:32 -0700 (PDT)
Date:   Fri, 16 Aug 2019 16:04:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mischa Jonker <Mischa.Jonker@synopsys.com>
Cc:     Alexey.Brodkin@synopsys.com, Vineet.Gupta1@synopsys.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        robh+dt@kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mischa Jonker <Mischa.Jonker@synopsys.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: IDU-intc: Clean up documentation
Message-ID: <20190816210431.GA28647@bogus>
References: <CY4PR1201MB0120EDD4173511912A9FC99EA1C60@CYPR1201MB0120.namprd12.prod.outlook.com>
 <20190724120436.8537-1-mischa.jonker@synopsys.com>
 <20190724120436.8537-2-mischa.jonker@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724120436.8537-2-mischa.jonker@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019 14:04:35 +0200, Mischa Jonker wrote:
> * Some lines exceeded 80 characters.
> * Clarified statement about AUX register interface
> 
> Signed-off-by: Mischa Jonker <mischa.jonker@synopsys.com>
> ---
>  .../bindings/interrupt-controller/snps,archs-idu-intc.txt        | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
