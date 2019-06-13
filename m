Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88E0444F77
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 00:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfFMWoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 18:44:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40146 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFMWoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:44:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so334154qtn.7;
        Thu, 13 Jun 2019 15:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cNyL6kBlOrargUB7RJW820//UPa0FDwEQWXIUTmj0gg=;
        b=NQa0TspIYUFQ9TH68dOIPY+bARB0TuAbqVH3tzM7UA9ffuOXkf1gwGBbB8rWoJzbqL
         ZKuIZoIybhu5SvKEWiVFuMDxC4xNgPZ9pkFHkqEA33O1+CrkJuMjpwj+iEWEHqVb5AXw
         NdqBQKJW66wYjsBkDFFn/1+ap2sR0VxeP8pQz2XED4Fb1e+qNUgxWoboM8xDsHvHyi2t
         EsgWumyLe3+5MUK/tbp8EWiRV0NL+zVnuZ/5YD9n1i8njXN3fabA0HMuObnzSPTUALaw
         WEcAnxS6LN2Apf04lqRdxwIvvMiClY+dbzkS7fR1y3E0GxenY2k5jJBvIUJqkpFJsKAY
         sl/Q==
X-Gm-Message-State: APjAAAV328CwkQ+BdavNESILDaJBaAVbW7vS8GFHiFjAS9hA4+TLnQw3
        hmk1fHhC8scZ7xtxB3yzwg==
X-Google-Smtp-Source: APXvYqzm9Y5ukOTyUC+FuNToA0iK6zRVGXEIz84ypEr3asNTJysYmiitgyCQBr+KJjeR54UVH9zG8A==
X-Received: by 2002:a0c:942c:: with SMTP id h41mr5580336qvh.146.1560465878329;
        Thu, 13 Jun 2019 15:44:38 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id q3sm652003qta.74.2019.06.13.15.44.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 15:44:37 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:44:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: arm: Convert Actions Semi bindings to
 jsonschema
Message-ID: <20190613224435.GA32572@bogus>
References: <20190517153223.7650-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190517153223.7650-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 10:32:23AM -0500, Rob Herring wrote:
> Convert Actions Semi SoC bindings to DT schema format using json-schema.
> 
> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3:
> - update MAINTAINERS
> 
>  .../devicetree/bindings/arm/actions.txt       | 56 -------------------
>  .../devicetree/bindings/arm/actions.yaml      | 38 +++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 39 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml

Ping. Please apply or modify this how you'd prefer. I'm not going to 
keep respinning this.

Rob
