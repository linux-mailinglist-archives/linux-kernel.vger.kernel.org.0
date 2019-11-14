Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F10DFD0F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 23:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKNWbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 17:31:42 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39451 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNWbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 17:31:41 -0500
Received: by mail-oi1-f195.google.com with SMTP id v138so6844338oif.6;
        Thu, 14 Nov 2019 14:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3aEDSd//CUr7obM8pnwgRvPfaqbSjrz8RXYZcOBaO5o=;
        b=OxckcMJdG1GQkCy3qGHoCHlusLXfEu2sVxtm6AHt4cFb6Ed9tF4RNEiXkXncnmX5Vf
         /FgUoMhXCm1tNwDzWGDwJyeiX4KJ+6C70cAaTYWR2SkM18CrsxWSohkehCk0KtKM5eUN
         PQQWLV/cVrIqtcBjMwxHI9FmgbuglWGDBmKCV04YZhX8Pe9L0P8Ifxf0ytYmw7UVXlym
         r/iJRvpZxuKKM0ke8AlM9uGa9wbnV4rYwcLuxVVi5xiuaWtvL25BxDlHmUeeSaNJhouz
         mK4cAi67mA/VxGeFbpyTIKHn9GSDEKVz0k0cDTbfTb0FCjVOoZZ922hFlzJtBc5+d12p
         DfGA==
X-Gm-Message-State: APjAAAVMbwyRgNJXxY7qyQkfGjU5KLxXEmSfYCxn++CqJBeL+1BO0QbV
        siOgsxHky01HFf8obEXO1YWdaYw=
X-Google-Smtp-Source: APXvYqzmC0S3EemtVMsdOmnrb9ciGoy0JBKuBOZVKmRqGidvzvwwtfy146j39IXLhjQXTTFWSqO/Dw==
X-Received: by 2002:aca:4a84:: with SMTP id x126mr5293793oia.47.1573770700636;
        Thu, 14 Nov 2019 14:31:40 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f93sm2246396otb.64.2019.11.14.14.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 14:31:39 -0800 (PST)
Date:   Thu, 14 Nov 2019 16:31:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] of: property: Fix documentation for out values
Message-ID: <20191114223139.GA4161@bogus>
References: <20191113064338.GA13274@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113064338.GA13274@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 08:43:38 +0200, Matti Vaittinen wrote:
> Property fetching functions which return number of successfully fetched
> properties should not state that out-values are only modified if 0 is
> returned. Fix this. Also, "pointer to return value" is slightly suboptimal
> phrase as "return value" commonly refers to value function returns (not via
> arguments). Rather use "pointer to found values".
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> Changes from v1. Removed statement about modifying arg ptr only upon
> successful execution (as requested by Frank). Also changed "pointer to
> return value" with "pointer to found values"
> 
>  drivers/of/property.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Applied, thanks.

Rob
