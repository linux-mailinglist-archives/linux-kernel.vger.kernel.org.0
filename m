Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0E5A59D8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 16:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbfIBOxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 10:53:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52670 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731106AbfIBOxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:53:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id t17so14917085wmi.2;
        Mon, 02 Sep 2019 07:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8niq7I3KtLoFV6G68RD7JPljmwcbf13QiZrThnnRebU=;
        b=eDgu9izqAoJxNXZXwi3TUT+CKlRJh8CRA6g8xp+mCw3lvct0baBluuI/6hFOz7zxY0
         JLWK658Sp0R5ZK4SbUftf/yPDLgx+V9oUEr5NyP31HUzyvriauBmTf5MAxMEUJsk3qyk
         PaNxWCY55Ggh6VgP5S4EXE7JSBLCRKK1jfXOc5AId2UvU2ETFUS81OKw3WcNnjn5CtUm
         ewfBx5WIkxb4AdH0rOf5g/wbIx2WzJJd04+uK+MvDQSJXhBdBjaIJDReXA267lcGKfWI
         x8e6uD+BjmawM36Y+1gdU0UYqU8H+JOeH7A57vEP3HfSI8UHujAAN/8gxi6CvpRERGMd
         GyYw==
X-Gm-Message-State: APjAAAUHVR22VOnTJtP7pwztvTdD/1D2uoUO65SSOBI430yvsMa5WSmp
        71f/QBJDzm395uUdYhi1CA==
X-Google-Smtp-Source: APXvYqwurLEedIJ2NH99wElsVdw1jpwhLt7W963TFIA1umkQBfqJ5qQZszUE9IJZl+eqdWB1fG2nlA==
X-Received: by 2002:a1c:1acc:: with SMTP id a195mr2788504wma.106.1567436018385;
        Mon, 02 Sep 2019 07:53:38 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id g24sm17867214wrb.35.2019.09.02.07.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 07:53:37 -0700 (PDT)
Date:   Mon, 2 Sep 2019 15:53:37 +0100
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Pitre <nico@linaro.org>,
        Sebastian Capella <sebcape@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 2/5] dt-bindings: arm: idle-states: Correct references to
 wake-up delay
Message-ID: <20190902145337.GA15101@bogus>
References: <20190830150302.20551-1-geert+renesas@glider.be>
 <20190830150302.20551-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830150302.20551-3-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 17:02:59 +0200, Geert Uytterhoeven wrote:
> The paragraph explains the use of wakup-delay, as defined above.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/arm/idle-states.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
