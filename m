Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD1617026D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 16:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgBZP3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 10:29:45 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35317 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgBZP3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:29:44 -0500
Received: by mail-ot1-f67.google.com with SMTP id r16so3332987otd.2;
        Wed, 26 Feb 2020 07:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L2eDFUj6+ZgHsv30b3IWHnryr2PQNv2tUG/pwmYNTCY=;
        b=iCxEUGKPv/FRMfXkLS/uC4TtaW+iOcRft6LE7f4TZcabNMWx3hgO8zAKz8dDuVSLKt
         oUVC83dHQxmyaYteYKbPieNqcgGLxef5qvp4tBcQFjID3yyWWB0ntQVZ2nta8poOZ7AI
         OSese1k8zyj9lCNMJyklypMTRCnmLMPal/Sd/EKMH3Ng5G9Z+weNJcHwg1JB1GBLuLlv
         jKHJVj6nLhyN4IfRAbjfOuFldndcyO8fGMZIiRb8buJDrMKDpZjudWneLg0/qi2Y1/PT
         EtbiT1r6/uxSRqJ67wa+Haf7Q46PiJ2HSLUBALzfxCTzYCkhqr4DO+NrYs/lRt9IW9Vy
         D52g==
X-Gm-Message-State: APjAAAVWcXsayovJsL3c472QdyBS5Q3E1JHgCR+vDVx5NstK/fQGTfLa
        +T6sOFWDnq/nvQ4tKoRG0dEp/Bs=
X-Google-Smtp-Source: APXvYqwkgLOQ11KkhrIdopjRwjvsy1oDDhHlY1VCalaAfJDndkzbKF6J3ryE55DovBte5OZJt1wggA==
X-Received: by 2002:a9d:6ad6:: with SMTP id m22mr3775162otq.7.1582730984108;
        Wed, 26 Feb 2020 07:29:44 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r2sm874632otk.22.2020.02.26.07.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:29:43 -0800 (PST)
Received: (nullmailer pid 5886 invoked by uid 1000);
        Wed, 26 Feb 2020 15:29:42 -0000
Date:   Wed, 26 Feb 2020 09:29:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clk: g12a-clkc: add SPICC SCLK Source
 clock IDs
Message-ID: <20200226152942.GA5832@bogus>
References: <20200219084928.28707-1-narmstrong@baylibre.com>
 <20200219084928.28707-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219084928.28707-2-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 09:49:27 +0100, Neil Armstrong wrote:
> Add clock ids used by the SPICC Controllers of the G12A and compatible SoCs
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  include/dt-bindings/clock/g12a-clkc.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
