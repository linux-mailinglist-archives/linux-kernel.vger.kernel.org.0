Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A746E11354B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 20:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfLDTAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 14:00:51 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40808 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfLDTAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:00:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id i15so226989oto.7;
        Wed, 04 Dec 2019 11:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NH9P71jaSYwbdiuvHT3KsqpBTP1sBzRBr3S4xZfrqbs=;
        b=taR/08V6NmRQ51ByzAW4WRWmJUsZQDGXTjXGqioLUso3bsBAozyeE7NUx53dsmZV/5
         JvLinkdloNOO0MnqcQde8QDqgl6oSkvw4xcd5rp4pdELmqBzT5k1SGIBsPHZmVs2M+i2
         YKs0/ahOq2hGLZk2V04jDd6y1yNkB0ahg6SofBOXpC0vyAy8EbMRziPusP7obdLDhmEz
         6JEIup0dL7uc6jAGyrVlGfpK+gcxF9+5gW2nwupe1uu7o+dVogDddlNvmmMcp+YsN6cC
         b8ymgl22thP3z7bDTeXhFxQEWR96Sck7vLIAzOj5PT61i8d+0ND6ssKuU9J4SPXzXHcX
         fJcg==
X-Gm-Message-State: APjAAAX0QgqlzH8Y/Quxfw6hfS1iTSdY3bz3+PVzxLPW3tvPamjIjxyB
        dlIB5trzzcu4EjXaoMkQoHmaE/o=
X-Google-Smtp-Source: APXvYqzblcedlB6VcbjUSVI+aOesYy+s6U2KKJdMQ/zRFaTgEEQAiavskZ46/ytzN8GzzTKG4671vQ==
X-Received: by 2002:a05:6830:154c:: with SMTP id l12mr3676333otp.275.1575486049903;
        Wed, 04 Dec 2019 11:00:49 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l81sm1705081oih.5.2019.12.04.11.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:00:49 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:00:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add yet another for
 ST-Ericsson
Message-ID: <20191204190048.GA28062@bogus>
References: <20191120181857.97174-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120181857.97174-1-stephan@gerhold.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 19:18:54 +0100, Stephan Gerhold wrote:
> Unfortunately the vendor prefix for ST-Ericsson is used very
> inconsistently. "ste," and "stericsson," are already documented,
> but some things in the kernel use "st-ericsson," which is not
> documented yet.
> 
> st-ericsson,u8500 is documented in bindings/arm/ux500/boards.txt,
> and is used to match the machine code and the generic DT cpufreq
> driver.
> 
> Add it to the list of vendor prefixes.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Changes in v2: none, added new patch to deprecate other vendor prefixes
> v1: https://lore.kernel.org/linux-devicetree/20191120121720.72845-1-stephan@gerhold.net/
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
