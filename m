Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC1D111B1A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 22:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfLCVkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 16:40:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35437 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfLCVkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 16:40:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id o9so4403150ote.2;
        Tue, 03 Dec 2019 13:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hERvSaz66SkiNBwQoTtBUm4Hajuej4GF7gNQy5oDEtA=;
        b=T/tMJ2jfbUO5ujvof30RNAHrWXW39jvSyu7hbKoc90N814TVIJn/DAb5PW7v/ZMcvE
         0jypsLZqDHPv7YeO/4mQUDKqS/MwizX9ETBNdXRRNb4/DFa90q4UWgvJ2B5ldFLOmKPJ
         68aeIVkrN6jeTuZsuY1bsR+CBnAeJ/8YzF7xV67aOwwMTOa0iHLy5X9uaVUJgZBIqcds
         Mvnkuc2cVCGxQH3jh0pXEgR48ttgrolLRnwf4i6kXRAn9Qt5J3MGQTxXZqsxhDYkLndY
         pBaCJ+2aWx48F+O+Eihras07pC1ESt7GRTPR/8gZV1na0JUE7As9K4oGibxxEghjHCic
         wmKw==
X-Gm-Message-State: APjAAAUr6xBqhX7Hvjo+VHYV0DfI9iVSUmbRHODiYva2et3VNwsNHBsq
        jFQxdb/XwXayn6SmieY12w==
X-Google-Smtp-Source: APXvYqxf17ZEEJHtpbzNPWQPDQrchks+zHBzzA9aGw9kjrzAjVDaPbPgWRLQpOyzkE7L0M5bx5LpoQ==
X-Received: by 2002:a9d:588c:: with SMTP id x12mr24016otg.2.1575409220365;
        Tue, 03 Dec 2019 13:40:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w123sm1552436oiw.47.2019.12.03.13.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 13:40:19 -0800 (PST)
Date:   Tue, 3 Dec 2019 15:40:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: ab8500: Document AB8505 bindings
Message-ID: <20191203214019.GA24180@bogus>
References: <20191117221053.278415-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191117221053.278415-1-stephan@gerhold.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Nov 2019 23:10:52 +0100, Stephan Gerhold wrote:
> AB8505 can now be configured from the device tree.
> The configuration is almost identical to AB8500, so just add a note
> for the nodes/compatibles that differ between the two revisions.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  Documentation/devicetree/bindings/mfd/ab8500.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
