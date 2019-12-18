Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5D71256AA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 23:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfLRW1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 17:27:20 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42055 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRW1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:27:20 -0500
Received: by mail-oi1-f195.google.com with SMTP id 18so1340403oin.9;
        Wed, 18 Dec 2019 14:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DPx76fdrtNFryPt1bqjLnMiDt/+RbhXxSWMZR+o48kk=;
        b=TzMKeX4fuhLrR124RTRxvBjqgzDeP5tFAZBWQb3fvPjmXqzRKDg+G3BpRcbESS14gQ
         jk4kNoleZ9MSWZfhPK3FdgWGKbgUzzE9NiUmeOv5h+pQ4TlsWN8QVG2ZhkBH4BwOykrX
         Du6QBNzDo7M58XDrcLqm4AmqYYTbV0WMnR/PSWLstUyQYhG/dySL0s4AxxYvH0OMtcY0
         ptEB984aUYlwS6uIP7ETVXdOSwjC7yT4+/CP0VdvXIrtSgIwHwZW2wzKW3FPJJXVEo3s
         kRkZ2ytPNOlZX8NdGheABpKOuTcPYt/rB1DUQ9oFa8QIk8GmHNoPWRAOOg030f4HEees
         eCxg==
X-Gm-Message-State: APjAAAVsFHVsYNbRAw9fvzvlDdZKx1ki9u//4bwc8kvkcw8rljozA1oC
        AeG/w3jbVLmkVLZMR9kTdA==
X-Google-Smtp-Source: APXvYqwJ2EwcOT9FHyK5oTO5jZO1RaodG2vRem5BdHLYTRgbkWrURqnTXm4e0vS7WkNGgWnFiiOd2w==
X-Received: by 2002:aca:b7c5:: with SMTP id h188mr1610228oif.100.1576708039683;
        Wed, 18 Dec 2019 14:27:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b3sm1271775oie.25.2019.12.18.14.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 14:27:19 -0800 (PST)
Date:   Wed, 18 Dec 2019 16:27:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: Add dt bindings for flex noc
 Performance Monitor
Message-ID: <20191218222718.GA4028@bogus>
References: <19bb1ad0783e66aef45b140ccf409917ef94e63b.1575609926.git.shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19bb1ad0783e66aef45b140ccf409917ef94e63b.1575609926.git.shubhrajyoti.datta@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Dec 2019 11:09:56 +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Add dt bindings for flexnoc Performance Monitor.
> The flexnoc counters for read and write response and requests are
> supported.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> changes from RFC:
> moved to schema / yaml
> v2:
> Add additionalProperties
> Update the License
> 
>  .../devicetree/bindings/perf/xlnx-flexnoc-pm.yaml  | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
