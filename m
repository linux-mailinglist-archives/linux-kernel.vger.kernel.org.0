Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30871785B3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 23:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgCCWgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 17:36:16 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35314 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCWgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:36:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id v10so84910otp.2;
        Tue, 03 Mar 2020 14:36:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jswyzVaGX0gLXelQ0bE73MWedKjiFHl8054jCn5Ou6o=;
        b=OCJWzqIO2UjTqD+7sezgPGbKAaloKce1lHTIAhr/jnqtCp4sWSxS3EveMaA7WFySPp
         CGZFwpLjR9Ae7v/VDo248QFuFpnAuA+LyR2gwwgBivK20SqcYqeAeDwTfL7P2alg+Dyk
         Cne05YeMdPSR15l9iufIhD/ytgWp0jZ/C9kiGGOOra37NK7N77/LxMvEUDXXAQvFJoQf
         FW4nP4Nm9B0ENtclLQbKd97MGHM1D6mQlTv+L9kvDbBKdptWh7jVVzN4uYh0LDpHJk61
         5Mv52j7mvoQy/+AVYqayzDYbC5iAgeLivzCfaPeV7agOrq1R4ivKXvvKWpc01IYh6LxK
         GqHg==
X-Gm-Message-State: ANhLgQ3wLdEHE4cn2gQbOqygiv4RAeCTC4lqVx8SbOort8iKPWjkBCv4
        aOIkDWrOJBFYJZC5ejDl8Q==
X-Google-Smtp-Source: ADFU+vvw+qDN1aLQe0w8OZRSpXaMjd0hvD0koKaHo/6g+ONvJLL7zXTQv/zYDr0EfWdXK7af7goXNQ==
X-Received: by 2002:a9d:3b09:: with SMTP id z9mr86170otb.195.1583274973853;
        Tue, 03 Mar 2020 14:36:13 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z3sm7043723oia.46.2020.03.03.14.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:36:13 -0800 (PST)
Received: (nullmailer pid 15769 invoked by uid 1000);
        Tue, 03 Mar 2020 22:36:12 -0000
Date:   Tue, 3 Mar 2020 16:36:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: arm: Convert UniPhier System Cache to
 json-schema
Message-ID: <20200303223612.GA15666@bogus>
References: <20200227123648.12785-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227123648.12785-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 21:36:48 +0900, Masahiro Yamada wrote:
> Convert the UniPhier System Cache binding to DT schema format.
> This is a full-custom outer cache (L2 and L3) used on UniPhier
> ARM 32-bit SoCs.
> 
> While I was here, I added the interrupts property. This is not
> used in Linux, but the hardware has interrupt lines at least.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../bindings/arm/socionext/cache-uniphier.txt |  60 -----------
>  .../socionext,uniphier-system-cache.yaml      | 102 ++++++++++++++++++
>  2 files changed, 102 insertions(+), 60 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/socionext/cache-uniphier.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-system-cache.yaml
> 

Applied, thanks.

Rob
