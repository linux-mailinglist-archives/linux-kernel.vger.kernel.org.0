Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5B2C198628
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 23:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgC3VPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 17:15:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43294 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbgC3VPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:15:10 -0400
Received: by mail-io1-f68.google.com with SMTP id x9so12994533iom.10;
        Mon, 30 Mar 2020 14:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DiQpzvoXsdu2ngt5gwdJMip4fqFPo7qKub8h97nqjG0=;
        b=VRCdeBUjYJaOtUV4GH/Oi+kg0r1sHN0FOhjrmqzq8dnCIOLhhfX7ujA148joB/b4g+
         o0t0uRrpgbD8neF9vuzf9vE/7spQbRo67sQQKAqadR+9134ACff9oXzkTQxhcNP1Ho1M
         icLNsxnmNq2aDpdsb8b0NedI0aQlqg05GYtE15Mo5KUwp+0/OcPNFCfMJvYPSFIq0/y/
         LPjZ2kXWLD6Rtc7qG9S2aod1Wp3Zjcy5xd2c8dDW+HQlulFf5/zwxGhDdYD0zuc4eOTk
         5Lw+KbWpHK1kBIGDluZfpRXKNDX5KZX6YrK/9RYO6ZLNZuXtsDcSJeFmGY88RfDDYyWY
         D23Q==
X-Gm-Message-State: ANhLgQ3HV9K2s/B2Vi4XQNfof74hE0vlcnonQzMZjxjZ63/LBKova2hm
        KN9dlqOlVIaGEbAHV1OPhA==
X-Google-Smtp-Source: ADFU+vvmElgbY3zcH67E5ZpTJhcpBhMdNuV5bHMxaQeVOZ5mZFOmyvAdfClT9+s9vA7kkG9dM9Mg6A==
X-Received: by 2002:a02:8784:: with SMTP id t4mr10913216jai.31.1585602909188;
        Mon, 30 Mar 2020 14:15:09 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w88sm5212239ila.24.2020.03.30.14.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 14:15:08 -0700 (PDT)
Received: (nullmailer pid 30071 invoked by uid 1000);
        Mon, 30 Mar 2020 21:15:07 -0000
Date:   Mon, 30 Mar 2020 15:15:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        David Airlie <airlied@linux.ie>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 10/12] docs: dt: display/ti: fix typos at the devicetree/
 directory name
Message-ID: <20200330211507.GA14220@bogus>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
 <875b824ac97bd76dfe77b6227ff9b6b2671a6abf.1584450500.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875b824ac97bd76dfe77b6227ff9b6b2671a6abf.1584450500.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 02:10:49PM +0100, Mauro Carvalho Chehab wrote:
> The name of the devicetree directory is wrong on those three
> TI bindings:
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml | 2 +-
>  Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml | 2 +-
>  Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied to drm-misc.

Rob
