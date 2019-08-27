Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEDE59F110
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 19:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfH0RDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 13:03:23 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35855 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0RDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:03:23 -0400
Received: by mail-oi1-f193.google.com with SMTP id n1so15531476oic.3;
        Tue, 27 Aug 2019 10:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=egAsBZONFtZF3S68zAxV8vWm95Rzuv+SSezbehwAtCw=;
        b=DNIo5AA1232Lo4nU/yRAcPD+ay6etEH9XfCCx7hitSOqDSZbQk2PqDjrp2jqWSceHW
         OhPoU9rcXRIOpwmZEmrYXPJNJOo8GMVW5aaxsIelInugao4FVaIIor1PoQLEH9AVYTxi
         DL22iwQ6bt2+Y+23aniTZ7dPSDOIhea5He8K6VCTS8ThkLIs1MwyUDmy4jxM/8ScnRQ7
         hcid3xrgcKeM2MsNZJeIWL53dELCmpo9Pt5W9EF+sz91bYfgEWjgFkm5XWQVOa0lVTg4
         0uXBQvvWoNGOufd9+HAxdKnUGRgMfmHH6/Z3zgZLEV5mXQXVJYCjGZNXGYWV2cHwUKO6
         syyQ==
X-Gm-Message-State: APjAAAWo7iwow3m6kU16wDivroTejVhQbwKLh2uklgcr4ipfFJsvGVQk
        4CqXieBpGsBi3OuRo3kGVg==
X-Google-Smtp-Source: APXvYqyrU53AmLJ9RXIkWnzQsmP/nOlBksyu/9B33djgdkagficaUAD5K6LSF+6tYjKO/a4cSoIbMg==
X-Received: by 2002:aca:b303:: with SMTP id c3mr16045895oif.95.1566925402020;
        Tue, 27 Aug 2019 10:03:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s24sm4246237oic.22.2019.08.27.10.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 10:03:21 -0700 (PDT)
Date:   Tue, 27 Aug 2019 12:03:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] reset: dt-bindings: meson: update arb bindings for
 sm1
Message-ID: <20190827170320.GA13577@bogus>
References: <20190820094625.13455-1-jbrunet@baylibre.com>
 <20190820094625.13455-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820094625.13455-2-jbrunet@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 11:46:24 +0200, Jerome Brunet wrote:
> SM1 SoC family adds two new audio FIFOs with the related arb reset lines
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt  | 3 ++-
>  include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h        | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
