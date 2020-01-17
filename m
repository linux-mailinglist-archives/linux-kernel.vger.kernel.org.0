Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51E85140E98
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 17:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgAQQFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 11:05:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45813 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgAQQFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:05:13 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so22924956otp.12;
        Fri, 17 Jan 2020 08:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=09pIPN9VJnVoMEohnpzoMe9Wz3LLI11Byu6hcubzbxA=;
        b=d5g16M1UuIpwgKHug1N93pZ7b1hkNbDydtqoLq08kh6roLqWPapMXqeuV2sIS0w0oF
         8RLj8qlxx8hojKuB6d9+4Ea+8F5U0+Bfkf10BHtw7VdKDZwqw+QS3+wdw4Hueh5gvYE2
         Aw6/raAl+qW28Nu7XjR7mg4jEHLR4H0gY9lumxcBHp2aW1bOMaP2WhrzxUx9OhnWvhG/
         39gNsohdd2+OoyCv5KDS6FqjwZbNTuwKJvk76hVlwjQEU8SnU5TmigfXzcs42fJQEtje
         At8D3Qh0XfKpELJefKiGI5rlvyImmaIKndiB9GM0tMwdFL/FmwRdj5GGbkvOH+93aPza
         ZxAg==
X-Gm-Message-State: APjAAAWPfdBbvFmnzaIadZkQ8jEJX5C3MMS2Wq/3ww+1jZ7RhbyENdHI
        //nEFgMWK+rsHqfGUdJaMA==
X-Google-Smtp-Source: APXvYqzQt3oAnIJ07HK2ThTZ7fZk/cAWmEqZh1TV2aFPYhVvNicW/VMaIbgMHihgXroZfWA+uWkxRg==
X-Received: by 2002:a9d:811:: with SMTP id 17mr6752321oty.369.1579277112497;
        Fri, 17 Jan 2020 08:05:12 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n17sm8969227otq.46.2020.01.17.08.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 08:05:11 -0800 (PST)
Received: (nullmailer pid 17750 invoked by uid 1000);
        Fri, 17 Jan 2020 16:05:10 -0000
Date:   Fri, 17 Jan 2020 10:05:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v5 3/7] dt-bindings: PCI: meson: Update PCIE bindings
 documentation
Message-ID: <20200117160510.GA17695@bogus>
References: <20200116111850.23690-1-repk@triplefau.lt>
 <20200116111850.23690-4-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116111850.23690-4-repk@triplefau.lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 12:18:46 +0100, Remi Pommarel wrote:
> Now that a new PHYs has been introduced for AXG SoC family, update
> dt bindings documentation.
> 
> Please note that this breaks backward compatibility but as not a single
> devicetree uses that yet that seems ok.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  .../bindings/pci/amlogic,meson-pcie.txt       | 22 ++++++++-----------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
