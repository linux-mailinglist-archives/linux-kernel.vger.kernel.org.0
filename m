Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1353BA581C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 15:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbfIBNjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 09:39:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55515 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbfIBNjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:39:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id g207so10661172wmg.5;
        Mon, 02 Sep 2019 06:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=i8e++xz5qwKu0AXEKpTq0jloPuTWkhcukfEQYljIeuQ=;
        b=Jn9u38XFyFzKzqGawyU8pBN6QReSHG1vgbiGlYIUZS4I/DC28p9gACrtBSsY3csVh+
         CvwY3yYMNbBCiFQyzQ1PtSlI0LFTEQ2UKFpkX4jf9WoJd1lGLzqKOmSxOITuLsAqvqiG
         KzBbrAmey8dJC3Y9jnxhfeY8JQMsxR+CXW6k89xSnes3C8xCIDBnXhIqYKrn5h5ChMiH
         dfDCC57rCwiKy25ZtIUzdzsAhgsCiMNmgXdM4jbhONYY0eOQ6hBVMHoyUJRhRGvY26iy
         bKQR4zuVVIGteq9NzkgnXU1/5xJ42V15Vbl/Vx/roYKG5O4liU+jOurmGE/JRfxXfvVF
         3LOA==
X-Gm-Message-State: APjAAAWPhgYfLJnPLtrVQ/8midxPmCeo4Wex9HR/wNdtkrhaC082Vuyu
        LRXJEAzvfpp+uVLuwz+SWQ==
X-Google-Smtp-Source: APXvYqyy/yBgbJt3aiug7T/vVbjfsxmvYSbbhNfYrxpQphu6DF8mImW2gQmz1fvkwgPMM6JR6vii2Q==
X-Received: by 2002:a7b:cf09:: with SMTP id l9mr35159260wmg.20.1567431552216;
        Mon, 02 Sep 2019 06:39:12 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id w5sm12113377wmm.43.2019.09.02.06.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:39:11 -0700 (PDT)
Message-ID: <5d6d1b7f.1c69fb81.3c9bb.222d@mx.google.com>
Date:   Mon, 02 Sep 2019 14:39:11 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 02/16] dt-bindings: arm: Convert Marvell MMP board/soc bindings to json-schema
References: <20190830220743.439670-1-lkundrak@v3.sk> <20190830220743.439670-3-lkundrak@v3.sk>
In-Reply-To: <20190830220743.439670-3-lkundrak@v3.sk>
Cc:     "To : Olof Johansson" <olof@lixom.net>
Cc:     "Cc : Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Aug 2019 00:07:29 +0200, Lubomir Rintel wrote:
> Convert Marvell MMP SoC bindings to DT schema format using json-schema.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v2:
> - Add mrvl,pxa910
> - s/MMP2 Brownstone Board/MMP2 based boards/
> 
> Changes since v1:
> - Added this patch
> 
>  .../devicetree/bindings/arm/mrvl/mrvl.txt     | 14 --------
>  .../devicetree/bindings/arm/mrvl/mrvl.yaml    | 32 +++++++++++++++++++
>  2 files changed, 32 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

