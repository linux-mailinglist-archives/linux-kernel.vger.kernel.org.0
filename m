Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7440F240D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 02:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbfKGBKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 20:10:51 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40946 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKGBKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 20:10:51 -0500
Received: by mail-oi1-f194.google.com with SMTP id 22so477304oip.7;
        Wed, 06 Nov 2019 17:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h3DM1+XLE8gggufePDpkJkrNK38nTztCPScUKfD75qo=;
        b=mLnuFDHrK8eOrk4oBPQDE8wdz0Hc2zne0XfO8iYv0pum2beJ9k14Q1K7wQkSTgucpr
         mHqOJcaMNrPA8ohd0zPMUVdXm9y6+cdevfaRmt6NHvYByI+kL69+DU/EA2me4/o5AC3D
         25bss5mkNG6NAm5QA01Q+aJHwyK1xLXjH8lgarlW/dKvOQTZWDaJSlP8Q6KiQ4sX/cUw
         D0We+jZ3lyygGJUJDK+sfn42c2VyRjIBaTlLTguJd222rbsnZKy4AH6aML6vuoVMlrSp
         wRifSzHLWWhGxvUpdY2MyGLx/FBLwg0O70qMzWtyYXAjknlVt5we616hSyqU+xJdnU11
         3YNA==
X-Gm-Message-State: APjAAAWGHMehKQ5wV2aRZoagHU8mls/oKbz6fVJMh9RiSeL2AXNiuPkZ
        gIZvg9U6kU6ATQdjbLGOew==
X-Google-Smtp-Source: APXvYqwm8iRGZ85Vo8mOJRNZ2JHzKFeDGUUzq4vJ6mf4SrinSza+86cRCVi3GgEuKL5IAcdTM3hOaQ==
X-Received: by 2002:aca:d888:: with SMTP id p130mr777850oig.165.1573089050283;
        Wed, 06 Nov 2019 17:10:50 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 38sm248825oth.19.2019.11.06.17.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 17:10:49 -0800 (PST)
Date:   Wed, 6 Nov 2019 19:10:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, benjaminfair@google.com,
        avifishman70@gmail.com, joel@jms.id.au, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: reset: add NPCM reset controller
 documentation
Message-ID: <20191107011049.GA18656@bogus>
References: <20191106145331.25740-1-tmaimon77@gmail.com>
 <20191106145331.25740-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106145331.25740-2-tmaimon77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Nov 2019 16:53:29 +0200, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM reset controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/reset/nuvoton,npcm-reset.txt     | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
