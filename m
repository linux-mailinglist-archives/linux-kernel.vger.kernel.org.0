Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE9318C433
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 01:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgCTAVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 20:21:17 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35314 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCTAVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 20:21:17 -0400
Received: by mail-il1-f194.google.com with SMTP id o16so1453671ilm.2;
        Thu, 19 Mar 2020 17:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FuTx6V6iQX3TQQufQK6K65FrEVN9gM5pUAmus1MSvNc=;
        b=au5AkhWgLVb4Qy5vK0lF9R0l0W1SD9tM7wQyW144TfQC9yxNr0zUloSI4EO02NJI95
         OesJBKxv2sKGUZ6C7Cz/voNdt499nY2x3O4hfUra7DkVcH3zr+L1k6EL4YUnrK2tPixL
         CcoK0ywoEf12M3u7OrhZhIG/R8gj8iHsunvYSvsoNVr8ojECEuf4dbDNtZ4eudcdajzH
         qFNDGPibIQoc4BGVtNhYdMnR9nSR/cs84s4p49l2cqjjtnM3PiOpQ7wf0rLp2E0zv+J9
         kW46GHgifB+9VxKt74H4Spr5OFpBjHF1FAf+U3+en8el/IKr6INpyg+O4YveVrI1AquP
         Cz/Q==
X-Gm-Message-State: ANhLgQ31lNZeQ15ki8ZOk3/bjHd+L3AYZDKvs5yez95sNxzHoLGV1pjm
        3PPMEedv/WOCRxPTeRhIyA==
X-Google-Smtp-Source: ADFU+vtWkY9RoNxxzvof2BMoe1HJaDzh6VsWtHCXeQqV0u6VhrRgZXrJYD2kh9SusnEkFODar2PWAQ==
X-Received: by 2002:a05:6e02:e0e:: with SMTP id a14mr5896966ilk.104.1584663676074;
        Thu, 19 Mar 2020 17:21:16 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t24sm1275351ioj.13.2020.03.19.17.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 17:21:14 -0700 (PDT)
Received: (nullmailer pid 11035 invoked by uid 1000);
        Fri, 20 Mar 2020 00:21:12 -0000
Date:   Thu, 19 Mar 2020 18:21:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] bindings: sound: Add documentation for TI j721e EVM
 (CPB and IVI)
Message-ID: <20200320002112.GA10030@bogus>
References: <20200319092815.3776-1-peter.ujfalusi@ti.com>
 <20200319092815.3776-3-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319092815.3776-3-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020 11:28:14 +0200, Peter Ujfalusi wrote:
> The audio support on the Common Processor Board board is using
> pcm3168a codec connected to McASP10 serializers in parallel setup.
> 
> The Infotainment board plugs into the Common Processor Board, the support
> of the extension board is extending the CPB audio support by adding
> the two codecs on the expansion board.
> 
> The audio support on the Infotainment Expansion Board consists of McASP0
> connected to two pcm3168a codecs with dedicated set of serializers to each.
> The SCKI for pcm3168a is sourced from j721e AUDIO_REFCLK0 pin.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../bindings/sound/ti,j721e-cpb-audio.yaml    |  93 +++++++++++
>  .../sound/ti,j721e-cpb-ivi-audio.yaml         | 145 ++++++++++++++++++
>  2 files changed, 238 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/sound/ti,j721e-cpb-ivi-audio.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/ti,j721e-cpb-audio.yaml: duplicate '$id' value 'http://devicetree.org/schemas/sound/ti,j721e-cpb-audio.yaml#'
Error: Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.example.dts:21.23-24 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/sound/ti,j721e-cpb-ivi-audio.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1258054

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
