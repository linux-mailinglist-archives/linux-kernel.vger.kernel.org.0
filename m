Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9829B113609
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 20:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfLDTzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 14:55:00 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39670 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfLDTy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:54:59 -0500
Received: by mail-oi1-f194.google.com with SMTP id a67so413535oib.6;
        Wed, 04 Dec 2019 11:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OPmJQ+fyJlkP3BfGVuuBfX22U36bspS/c0JjyT/n6XY=;
        b=Pdagauj/mQ0HGJqSQGNN0WbTlXNN18Nx/VUbKDSwJEkzwLk795x6pq7Hfcw1jWe9pZ
         L52YH3RoJJ+9XCe5TgrUCULbj4Gl55+ynZUzzT0ZFbFkBZSWd/rNYXa/yoqJurNR0IAv
         E0FWhJQKQgyfir949JtfydFJkmYQ/wlwkUJ2j3hoJayNIqCsMtWhpD01y+3QV0PQDNr0
         JVYMGOANdxA/Rm89bqNwuQu/19cV/z6l9VyHuuI5FX1yHRupLswr3/w7LXd8p7hylhar
         vT9fK/U6maAifTvFpB1N2XTAvwJd0V55LsI8qDTpENlfxLSc4VZuBW/ZYksx5rBeqsXJ
         pV/w==
X-Gm-Message-State: APjAAAXMDvcTFHWmDsqEHkAtz5sh3o6GKghvKcH5g79jQxEYA2CpGWXD
        ZTR5Eux1blE+lUUrZ7TUfg==
X-Google-Smtp-Source: APXvYqxd3fK9jhwjpyiSCh7faZowBYmsINV1Az1SfSXSPdjh2kqdLN95svGwJT4zf5QfC8ZsOqEirw==
X-Received: by 2002:aca:190b:: with SMTP id l11mr4217896oii.65.1575489298861;
        Wed, 04 Dec 2019 11:54:58 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 64sm2543076oth.31.2019.12.04.11.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:54:58 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:54:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: arm: stm32: Convert stm32-syscon to
 json-schema
Message-ID: <20191204195457.GA18882@bogus>
References: <20191122103942.23572-1-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122103942.23572-1-alexandre.torgue@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 11:39:42 +0100, Alexandre Torgue wrote:
> Convert the STM32 syscon binding to DT schema format using json-schema.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> 

Applied, thanks.

Rob
