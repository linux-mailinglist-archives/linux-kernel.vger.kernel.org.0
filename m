Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35BE7112FD5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 17:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfLDQSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 11:18:15 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42214 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbfLDQSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:18:14 -0500
Received: by mail-oi1-f196.google.com with SMTP id j22so7350478oij.9;
        Wed, 04 Dec 2019 08:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aTWv2kRnd2I8BNSkWTbrYY8IgWPRpV337Nl/skN4/18=;
        b=Pov2/Uu0Wn+RGb0oRFVcvaXGdawCspT7n2TFV5PpPzZjn8HGRribsfMFV2bA4jZgOL
         tXUrjAClXE7PcjZHHe0Lcj998kRKPiq95B7zHGlAyVC7GnmVvOUmPCIJmRc9IePGCxat
         Tzfa2u2eCV+Gr1Qyi0CMaMl/l1HaXhmjuWmJyhBBysM9iFRr9zn15+MdKloyjMgFbigh
         Xi12JmfXaK5hrq55fNC5AvLveVo71RI0+HE7PjteCXC3CPMjDbMSz1ZYYz9iqA0funqA
         92u5kke1zFY5YUQSKDETKFv7uabWhYFB5w41zeAvNEBm/6kDEhJbUZN+M/lBJji5W4mC
         BOnw==
X-Gm-Message-State: APjAAAWEjQFcYqr70XF5fEcOuIa62z2GbQIxFKbGM16w7Ew7QKsfOEeM
        AaWS1HYeko9nBMJKXxZojg==
X-Google-Smtp-Source: APXvYqyt+h8GQhsCVeuL82IwwTbvEJ0hmhypUlSo8ZBJTW/VpJLHjXYM59W/NvvtbyQw4yw2F1MCCw==
X-Received: by 2002:aca:530e:: with SMTP id h14mr2986671oib.105.1575476293512;
        Wed, 04 Dec 2019 08:18:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h22sm1588639otl.73.2019.12.04.08.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 08:18:12 -0800 (PST)
Date:   Wed, 4 Dec 2019 10:18:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: crypto: add new compatible for A33 SS
Message-ID: <20191204161812.GA24881@bogus>
References: <20191120152833.20443-1-clabbe.montjoie@gmail.com>
 <20191120152833.20443-2-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120152833.20443-2-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 16:28:31 +0100, Corentin Labbe wrote:
> The A33 SS has a difference with all other SS, it give SHA1 digest
> directly in BE.
> This difference need to be handlded by the driver and so need a new
> compatible.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  .../devicetree/bindings/crypto/allwinner,sun4i-a10-crypto.yaml  | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
