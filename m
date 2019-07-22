Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F36570CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 00:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbfGVWny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 18:43:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41957 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfGVWnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:43:53 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so73478931ioj.8;
        Mon, 22 Jul 2019 15:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Svp74BvkdGsqSw/CVQeALZTPJjUPC2evM1cScX7kmfc=;
        b=L2+Xu/380uEDkPvB4/qm8edraKYRuNPAFQe/CFgg7CMsBZeqwymbMxIordm1pZmOzh
         GRuEhGz5GX4wQ7ycYuWKZn4P8NwlxSjYN7s4zzfoOUZN+3wF+cmqsgHNe4Z+I9et1RL/
         oYL+1tT95BZ1sQI9II/qrVmp/f1FKshezmhaNp52SZQj3mGy995rr73oCN/+2ehcOoVX
         ywt0+iEc7uV8a+TXh4eClxdtZh6dhXXe6WHtPwP89D1PG7T6knbU41TJJf2Is4pXH81Y
         F0D48nH2DUW8lBgTykGr5MK40q40A/vHV2MqnKPaZquCJ0iPb7f3xhXEDpMHeob7Do8z
         SbDA==
X-Gm-Message-State: APjAAAXsrJQMCqSQD6yKCClQ+xtDNKEdLjAR2M58nMLRgyq/VBE3xDr1
        BIw5jxfjQ3uiqM/U7AIdXA==
X-Google-Smtp-Source: APXvYqyEzhs4Q0KHFzrQB3A2UUaYKgS3Bjub7g5xu87KWZze3VmYU1AICYNgXLhU9c/erhypSpAdcA==
X-Received: by 2002:a6b:dc08:: with SMTP id s8mr21558994ioc.209.1563835432947;
        Mon, 22 Jul 2019 15:43:52 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id t133sm58987380iof.21.2019.07.22.15.43.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 15:43:52 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:43:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, joel@jms.id.au, eduval@amazon.com,
        Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v4 1/8] dt-bindings: soc: Add Aspeed XDMA engine binding
 documentation
Message-ID: <20190722224351.GA18423@bogus>
References: <1562010839-1113-1-git-send-email-eajames@linux.ibm.com>
 <1562010839-1113-2-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562010839-1113-2-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Jul 2019 14:53:52 -0500, Eddie James wrote:
> Document the bindings.
> 
> Reviewed-by: Andrew Jeffrey <andrew@aj.id.au>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../devicetree/bindings/soc/aspeed/xdma.txt        | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
