Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1989F029
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfH0QaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 12:30:08 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46729 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfH0QaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:30:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so19211186otk.13;
        Tue, 27 Aug 2019 09:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MZo+lyJS1qB+LB2JBgDPX4nY4iKSSmb/XJUlvm5QG+Q=;
        b=dWv3xGUUbmyVIPTD5+hEjyfSk+3JGwvLoSv0L4pH3jtmu6OCZS75IeW32klL6QDrIt
         9GpObn8uIiJ9bnDpvPpHvYU1m2TZvhT7nJ5uHeB94MffsGcL2NK/tvdPC45ai0E74QVO
         ZACn9p5offnT49Qp3Jp2rwFkZ4ngDJIH7yhrNqIe4evNI2Vez5PsaZupy2SIu7k1foIM
         kKkjvXOlqkhNDdFdXggUpN5eyLKShCbN5JZ52Tl1RDFfW1cN92lgmpJJ4LxKTRT9Cng9
         RVYyXCwRAnCPMXxK5MLs6WfhKAzwwwG/esnIX10dwJSXNdRlJcDyDFhQlvqD+lqZo2mv
         H5uw==
X-Gm-Message-State: APjAAAUN4AHvJZYi7WuOA1XDOLHzM5kADxZh4WXhzqbZIKVvOmNh0GhB
        YaXdSlXxEE7L7KY8U/Vu/w==
X-Google-Smtp-Source: APXvYqzyFGqlBO40GT+QMDN6a35htomQuDpDn1K6+V8gSqoGWVfe1dbAM1KRXwtq7YlPKL3CPKHYEg==
X-Received: by 2002:a9d:4c0f:: with SMTP id l15mr19784465otf.138.1566923406579;
        Tue, 27 Aug 2019 09:30:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u5sm6177265ote.27.2019.08.27.09.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:30:05 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:30:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        baolin.wang@linaro.org, freeman.liu@unisoc.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: Add Spreadtrum eFuse controller
 documentation
Message-ID: <20190827163005.GA26471@bogus>
References: <80b6cf41d2dc2660a710e611e06faae753e2e09a.1565955745.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80b6cf41d2dc2660a710e611e06faae753e2e09a.1565955745.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 19:44:16 +0800, Baolin Wang wrote:
> From: Freeman Liu <freeman.liu@unisoc.com>
> 
> This patch adds the binding documentation for Spreadtrum eFuse controller.
> 
> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  .../devicetree/bindings/nvmem/sprd-efuse.txt       |   39 ++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
