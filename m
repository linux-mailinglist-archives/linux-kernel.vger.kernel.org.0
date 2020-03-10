Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6892180A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 22:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgCJVRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 17:17:02 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32785 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgCJVRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:17:02 -0400
Received: by mail-oi1-f196.google.com with SMTP id r7so2308337oij.0;
        Tue, 10 Mar 2020 14:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7t2XjatVgxl1m5zmI0zf3cecNSKg3Cs9fIponxPwXSw=;
        b=KqtmxOMbEO+NZ5NaO1ZrWYHJVFmkdWz65LLAuWIfqd9OC97tvcLi7nRcdBuH+a6OQn
         qR8YmHPRSAqytfj7GkKX2qcE4CCOFPIc6EHOCS55k3IJ8xJM3lCEUYPr+Ey4gneksKh7
         GFMpFwClj7TL9K9dw9MfChpAA6Avx9Rv3B2ZmgaZl0KpcDRHzLrouJBTBJkbPkVlPJJ6
         tPR5wET2+nkz1QEzzwQVh0FC7jGveHY+f7zehT8c/1yBGaCKfcVQ6wMdp5iB92eE+fkg
         lm8Y+b42l6w4Y+zW5o4nwlbfbqDlll6KwBEB4s8Z9VywQCDTIyY+Jid3qM42CSrLr5A/
         KLxw==
X-Gm-Message-State: ANhLgQ12qdDU3KGGXbuA4Pn+EUVmPgIAivqy3WZaSQOjspildcN3/miO
        F5x8wzXDT19YeH2owsna1Q==
X-Google-Smtp-Source: ADFU+vvnBqeRTKTq5e+nF4YgIWdaO8ppO/L3bDWF/OAOgz41PPJ+xjsLP+OYrd9V6nJXHRyJ/eyJqQ==
X-Received: by 2002:aca:4fc7:: with SMTP id d190mr2684099oib.100.1583875021566;
        Tue, 10 Mar 2020 14:17:01 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h6sm7816905otq.63.2020.03.10.14.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:17:00 -0700 (PDT)
Received: (nullmailer pid 10621 invoked by uid 1000);
        Tue, 10 Mar 2020 21:17:00 -0000
Date:   Tue, 10 Mar 2020 16:17:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v6 3/7] dt-bindings: clk: sprd: add bindings for sc9863a
 clock controller
Message-ID: <20200310211659.GA10559@bogus>
References: <20200304072730.9193-1-zhang.lyra@gmail.com>
 <20200304072730.9193-4-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304072730.9193-4-zhang.lyra@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Mar 2020 15:27:26 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> add a new bindings to describe sc9863a clock compatible string.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/clock/sprd,sc9863a-clk.yaml      | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
