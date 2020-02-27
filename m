Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB93172B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 23:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgB0Wf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 17:35:26 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34194 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbgB0Wf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:35:26 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so956909oig.1;
        Thu, 27 Feb 2020 14:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/j9YRzazsSENp0jDKYRNHykqym2Q8baC8Im4jlERAOQ=;
        b=RF+NC8LOc4tge39bSTpTRgDgtZJQamRTRoDDaQGnJR4yEEqcEsC8VsdS7uvyBBhI5v
         o/mt/zZlsX6ke1XzlaUJ7f7HRrEjH9+bktXoDeGrJCUeJM26/tw8x9mSpGtRqitTcJrk
         QK+SRqI71sQuvM8aJ4d7s0oJU/U500ld0Yg3LabYlrsD8hivoOdfLIsIzJ7q9hXcU8m0
         c4zhMjwXYcCw68c7kAUUDPWzKFhhUAdg9jI9XxjiyHsSliwSqCG62f2nMHS8C8NnFtbN
         4eAdIB940RcG/2OfyvuaWXnB6hqxUh0oEZLLJXWW/bdXzB+RIQtrdAwiODorRVl95Mm2
         K7zg==
X-Gm-Message-State: APjAAAUjAouGYZg9Q1Bacva+P36XCHEr8e31P7L3WUPZl5QnWDbphH4t
        5YNHaCE4z/heHemDpyKUlg==
X-Google-Smtp-Source: APXvYqzrWjRIBWpgh1ZwLv47mTNE+W2+55plP1sN1eyoDY69Ke2N2Nu4ww6R/UsceXQcrvIdKk0bJg==
X-Received: by 2002:aca:cd46:: with SMTP id d67mr1012448oig.156.1582842925366;
        Thu, 27 Feb 2020 14:35:25 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w72sm2419276oie.49.2020.02.27.14.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 14:35:24 -0800 (PST)
Received: (nullmailer pid 10440 invoked by uid 1000);
        Thu, 27 Feb 2020 22:35:23 -0000
Date:   Thu, 27 Feb 2020 16:35:23 -0600
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
Subject: Re: [PATCH v2 13/13] MAINTAINERS: Update Calxeda Highbank
 maintainership
Message-ID: <20200227223523.GH26010@bogus>
References: <20200227182210.89512-1-andre.przywara@arm.com>
 <20200227182210.89512-14-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227182210.89512-14-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 06:22:10PM +0000, Andre Przywara wrote:
> Rob sees little point in maintaining the Calxeda architecture (early ARM
> 32-bit server) anymore.
> Since I have a machine sitting under my desk, change the maintainership
> to not lose support for that platform.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>

Send a PR to arm-soc folks for this and the dts changes. I'll pickup the 
bindings.

Rob
