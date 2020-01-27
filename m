Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED5FA14A606
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 15:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgA0O1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 09:27:42 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46868 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgA0O1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:27:42 -0500
Received: by mail-ot1-f65.google.com with SMTP id g64so8479767otb.13;
        Mon, 27 Jan 2020 06:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gHFIzYym2wHSkx/XcJVr1ZN2AzQ0NCmxhvpg7rHnJGQ=;
        b=K7DCDec1owlASVgANnE+voG/3hVxCNmHmzJk8S5/94wmg56nyRg8Bm5f0odKjddqOO
         D9RiSoUuC35ZcDnSrLiUktmYOaC3PgR+n6p1QelSMDQZuler2/Bs4Bl9hX54VMUgyDSp
         dAV6u/KGsc0Qh3dJXs0O3boxKcfAJUe6Q0Ss4xSCqOeZWEpOQgVjhLSD326+pmzlduF4
         iB8NPFWopZzRrXdeJmesM/9r7TrjzjhaTWrp09e4/dOgT9LI0o5v1s1lTFoukEFrOtRP
         lt/dMci5NHFNhNX/6PQ/mZ+P0/RiDzi2bltiWYz2lG1JHOXhQ7Uxm1Vzihe33xibRgKm
         ZuKg==
X-Gm-Message-State: APjAAAV8qouaoolNUUFem0tgFMXk5jXfJ9gBpPruRvZ4CSJtc51EexaE
        8pQghbGJe2SjWys9zIJDbQ==
X-Google-Smtp-Source: APXvYqxKc2Pdr9a7GoBVTnJkWtxidJvsjSqLH5jpa7O0Ku/zMbuMBUlYrEeXMlO2ZTj/AcA8HSqAxg==
X-Received: by 2002:a9d:5784:: with SMTP id q4mr13174370oth.278.1580135261225;
        Mon, 27 Jan 2020 06:27:41 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p24sm1108982otq.64.2020.01.27.06.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 06:27:40 -0800 (PST)
Received: (nullmailer pid 31874 invoked by uid 1000);
        Mon, 27 Jan 2020 14:27:38 -0000
Date:   Mon, 27 Jan 2020 08:27:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hadar Gat <hadar.gat@arm.com>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>
Subject: Re: [PATCH 1/3] dt-bindings: add device tree binding for Arm
 CryptoCell trng engine
Message-ID: <20200127142738.GA31451@bogus>
References: <1580117304-12682-1-git-send-email-hadar.gat@arm.com>
 <1580117304-12682-2-git-send-email-hadar.gat@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580117304-12682-2-git-send-email-hadar.gat@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020 11:28:22 +0200, Hadar Gat wrote:
> The Arm CryptoCell is a hardware security engine. This patch adds DT
> bindings for its TRNG (True Random Number Generator) engine.
> 
> Signed-off-by: Hadar Gat <hadar.gat@arm.com>
> ---
>  .../devicetree/bindings/rng/arm-cctrng.yaml        | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/arm-cctrng.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

warning: no schema found in file: Documentation/devicetree/bindings/rng/arm-cctrng.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rng/arm-cctrng.yaml: ignoring, error parsing file
Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Documentation/devicetree/bindings/rng/arm-cctrng.yaml:  while parsing a block mapping
  in "<unicode string>", line 42, column 3
did not find expected key
  in "<unicode string>", line 47, column 3
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/rng/arm-cctrng.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/rng/arm-cctrng.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1229638
Please check and re-submit.
