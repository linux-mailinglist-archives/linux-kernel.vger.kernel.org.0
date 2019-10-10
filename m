Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7080AD3471
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 01:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfJJXkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 19:40:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46238 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJJXkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 19:40:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so7226525qkd.13;
        Thu, 10 Oct 2019 16:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qzY2GiRsLdKkNjOULOmOY2uh2S6GFNejWSTG+vyFaHU=;
        b=BAVg1aEQqMRenewRVbfHesEnWeY+3OjzO2is/qAbM5snBow68FC34L2LRa1QaZ3eR5
         9Hk1wAjLnBY22hsxQRBsMj4hM26tHiYTXepbuzNl9+eRSSK3tvAvBTPCqWCj6HZbftgd
         F3oFG0waiCp5yvWHjy7xElgo8yxABrzwKmroA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qzY2GiRsLdKkNjOULOmOY2uh2S6GFNejWSTG+vyFaHU=;
        b=Ycz9Os8T+gSVqlG7yMREbI24xFOmpKF3dvJ+TofFKGeCVPePuFkntr8BMqk/MZPpBZ
         Ly/AxY2CsISmOHYv0BFtqi+5tqG1oGT5PNAI3gMOYT07gzSO2vQ18DaNcTS19ZUtqmD0
         rWa4BFO6aTXWeAIuXMv0IRlyIhGzrFQ21mYakuMWmJUlEGJRHuaGgGhj1ycPxVWvR8XQ
         t4R6NiKKDJOMkRt+Apt4Oh9fzICjbbMoJvrJVEmivB3gfHM9eCpPJeqHssDrDx5sWk1S
         2xliOGapIaLkAPDyeHGC3fK72ykWrYtRi2y4kYJuMdnJ6yEUMTHmWKRDvc2d7vIfuYDo
         eMuQ==
X-Gm-Message-State: APjAAAWE1MYzwFzUG+CTf/NLmxG6uzSZvCMwisV4ju06heyGONJm+qDK
        MBIEKdXSxEwUq2ts5o6+Y3woOWftnd1yt5NY5WM=
X-Google-Smtp-Source: APXvYqx12wus94E93QLNJZDQFKcLjtUWJadRRN6O4zaoD5brzLAp2CQYDAJzj7qrNBW2/PzPYUcsc4tkO6fvhiMuSlM=
X-Received: by 2002:a37:8d1:: with SMTP id 200mr12927454qki.330.1570750802156;
 Thu, 10 Oct 2019 16:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191010020655.3776-1-andrew@aj.id.au> <20191010020655.3776-2-andrew@aj.id.au>
In-Reply-To: <20191010020655.3776-2-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 10 Oct 2019 23:39:49 +0000
Message-ID: <CACPK8Xc2mibu+Pqi7ejGT_M24oprgoOik3Z8=fP6NVgEQeZYZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add AST2500 RMII RCLK definitions
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 at 02:05, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The AST2500 has an explicit gate for the RMII RCLK for each of the two
> MACs.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>
