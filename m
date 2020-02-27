Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3FAF172A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 22:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgB0VnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 16:43:13 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33992 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgB0VnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:43:13 -0500
Received: by mail-ot1-f65.google.com with SMTP id j16so691737otl.1;
        Thu, 27 Feb 2020 13:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XEnD8TdKVqIu64W+GQpQmvs4MDvwdtUaMqdLh54wz1E=;
        b=hHKO7fcVEB7o0QtN/XA476e7KMtIvKLRWIridyA+bx6VDCFwZ1lFxGvF1nD4Vlq78a
         7mLwQBuuox7uD76O0fiWDVWtxMMprnaPSFYfMdxxBSCQT2QPBWUNALpwAbxk8QfV/nB5
         hpB9hfTITxdbKHTQ+8hLhB23feIaEOspN3bTDMr/NHyu+Y4FO2YfV+YOEkPDyqbJkXRS
         ez9urwtR1ItvwqahYN0K3vCP6HprCzcj9M2RBKd10nr3MOaM66eoE7aX5HdUUEINGgtt
         JJYadObCQKOT63r5JJsRZ328lc2m4gJEfU/KqMRmQCJXaObeNUOLdVY042r/TAJVpWAM
         dIVA==
X-Gm-Message-State: APjAAAWxts5W1yuNF7NV7uK1ULjW2d+Pz4Npw5M9EjJ3rSwPBK4p71ot
        GrsDp84sojsRosAzuVu4xtrmzBI=
X-Google-Smtp-Source: APXvYqxLWh19a+bfGPEv9RCTwVytLpC5q2dw/nc7vSat1aAdkrr7hOvb+jV6MhiVTJ1aHFLBPRIZYw==
X-Received: by 2002:a05:6830:184:: with SMTP id q4mr799194ota.232.1582839792251;
        Thu, 27 Feb 2020 13:43:12 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n2sm2376537oia.58.2020.02.27.13.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 13:43:11 -0800 (PST)
Received: (nullmailer pid 3683 invoked by uid 1000);
        Thu, 27 Feb 2020 21:43:10 -0000
Date:   Thu, 27 Feb 2020 15:43:10 -0600
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
Subject: Re: [PATCH v2 02/13] arm: dts: calxeda: Provide UART clock
Message-ID: <20200227214310.GB26010@bogus>
References: <20200227182210.89512-1-andre.przywara@arm.com>
 <20200227182210.89512-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227182210.89512-3-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 06:21:59PM +0000, Andre Przywara wrote:
> The PL011 UART binding requires two clocks to be named in a node.
> Add the second clock, which is the bus gate, that just gets enabled.
> Since this is a fixed clock anyway, it doesn't make any difference.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/boot/dts/ecx-common.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

