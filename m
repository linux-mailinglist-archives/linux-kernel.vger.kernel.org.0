Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B26D619A138
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 23:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgCaVtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 17:49:51 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36634 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbgCaVtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:49:51 -0400
Received: by mail-il1-f193.google.com with SMTP id p13so20986757ilp.3;
        Tue, 31 Mar 2020 14:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XGaSzuYBrzwb5Afzco535xjNeNm7VCR01D0e+KSHlBU=;
        b=gTneFJeCBSFloAJlZJlDtxRj3bW2AXRuMrV3hivTuEN9jFL7o6GuUnif9YkRGLcnCr
         MFg8p3WXk4SPgjTDrjS0fbF75kqSieyGZxiydG+qbAJjqrvCFdQXMSI/f5URBcin3WZh
         EzewSDfAU9ucpnjdvdELKuRocahNElwIFzWJSNSmrSQzXDwnWAjqySx29PSRk/rERJiD
         Wti2YWUpbZwma02otcv2FI1GeB4Ryll0zJNs6vDyirwfe4XVj/RQRi5ezxg+wCvCXdQl
         LsZAiLFvocwd8bsf86/icukiromC00VI6UKUNOH7qKstS0bfcs7J6M0P2agxgPCjeWEs
         5HSg==
X-Gm-Message-State: ANhLgQ0jmoIIjVVI/FZvGrELP4/31RZsP70ltRzXW+0XjB4lZrZ6w4ag
        Zm0GTpUg5w3wUnZp7eEhVMTNZoarkw==
X-Google-Smtp-Source: ADFU+vtLiLqlrFPVsFsHqZpYWIdxcsfYWlyNB3SkdVLs9VJv60/GvpmZRG/1ep91VBksmL/cQASE2g==
X-Received: by 2002:a92:d582:: with SMTP id a2mr16558293iln.37.1585691389269;
        Tue, 31 Mar 2020 14:49:49 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l25sm34133ild.61.2020.03.31.14.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:49:48 -0700 (PDT)
Received: (nullmailer pid 486 invoked by uid 1000);
        Tue, 31 Mar 2020 21:49:47 -0000
Date:   Tue, 31 Mar 2020 15:49:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, linux@roeck-us.net,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: Add bindings for ADM1266
Message-ID: <20200331214947.GA446@bogus>
References: <20200325130605.2420-1-alexandru.tachici@analog.com>
 <20200325130605.2420-3-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325130605.2420-3-alexandru.tachici@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 15:06:05 +0200, <alexandru.tachici@analog.com> wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add bindings for the Analog Devices ADM1266 sequencer.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../bindings/hwmon/adi,adm1266.yaml           | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1266.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
