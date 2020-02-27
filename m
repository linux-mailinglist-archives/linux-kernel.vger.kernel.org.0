Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50663172A62
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 22:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbgB0VpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 16:45:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35436 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgB0VpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:45:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id r16so688422otd.2;
        Thu, 27 Feb 2020 13:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PrfKdt2Kd+9fAhpGESasTmBPrNBa2PAXaPKA8tfFiPA=;
        b=XI0RU5GPDJ0diaqxLn7hhiiH2p+5oGQR63YlDvfH20x9Ae4CVTg1PGI1mv1YIXnZ7I
         de0LGMu3o/0SkrywGLhFpw9klHWmZYItngjqEsQppMq5dWnr0BpVCq5iqWDbCLZJoXRa
         u2fxgEgs7CYVVPvXJkw46WYaO+5SoodMzGyPipvQcJwsROdj76H7y2Rxs/xDQMVo3Y5Q
         hV4gE7tcKv4Ov8plS1kTHKqLOvwEWgaGwl7HwvCWXL274tdxjYNUJfQyXZgBi4FwKLhl
         4Trkgq4Rl2bgUP+50lx4Ip2wFuAEhbemHzpgNl1eXXeSqlQNpDwkROA71/E9IKIblYyM
         GYEg==
X-Gm-Message-State: APjAAAVFovuR1YE9L1/XHmJr598JhLx5LmFnRd/6XihvYeUX6i2R16rA
        s9TSep2kClqNuLjfesmhDQ==
X-Google-Smtp-Source: APXvYqzDQOqstBQFtdFEAIEMTp1D4ag+GGoIFdtl3iXXISlKVIFUQ2rhO1wbfndZkvnyEkqYFeQIHw==
X-Received: by 2002:a05:6830:22ee:: with SMTP id t14mr782756otc.236.1582839921438;
        Thu, 27 Feb 2020 13:45:21 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g8sm2372764otq.19.2020.02.27.13.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 13:45:21 -0800 (PST)
Received: (nullmailer pid 6707 invoked by uid 1000);
        Thu, 27 Feb 2020 21:45:20 -0000
Date:   Thu, 27 Feb 2020 15:45:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Robert Richter <rric@kernel.org>, soc@kernel.org,
        Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 04/13] arm: dts: calxeda: Group port-phys and
 sgpio-gpio items
Message-ID: <20200227214520.GD26010@bogus>
References: <20200227182210.89512-1-andre.przywara@arm.com>
 <20200227182210.89512-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227182210.89512-5-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 06:22:01PM +0000, Andre Przywara wrote:
> For proper bindings checks we need to properly group the port-phys and
> sgpio-gpio items, so that they match the expected number of items.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/boot/dts/ecx-common.dtsi | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

