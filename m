Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6C0F45B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 12:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfKHL35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 06:29:57 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35777 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbfKHL34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:29:56 -0500
Received: by mail-qt1-f195.google.com with SMTP id n4so1467883qte.2;
        Fri, 08 Nov 2019 03:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19tliVy/iIF1NdAW0nZ7cVhCkJOFQ8X7U9RXNc+1Lro=;
        b=iGMI9aiSpFkL2Xcx4lkbR0yhLSgF8bW9F0DM80XakAiuf87a3LhSrmEqWIMzZyTbqA
         fkvDVTPzY9blj61tPjO+wW0caVDkIA2zMoLqO3dO7V8u9M9KGCAKoglxHxAar5UVcmEo
         hxXdCIR+AvMno0NkoNHKMLQCXxI9cNeaSFE7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19tliVy/iIF1NdAW0nZ7cVhCkJOFQ8X7U9RXNc+1Lro=;
        b=MX5tGBmtFUm2C6rHkgYe/Z9q0fZVT9CCydbpnqYQpDVIsoU6XF9T9WxYdOY6MxkEzG
         +CH68dFjJtW19uAcfoHR3Lvb9kANnGpEVs++SQiR1r5EZRNYE1OLYSxoGgk5jgSqBlEZ
         1j66myXobXMbUFJIZ3jMed/odF9LqitE8b8LC8XMis9kOfAq8kp/l7JcFZQDUdDrPhiB
         vhThlvtGlwQSlkH287mfd12tleYKuKQC8ahgSYqPoiPkQskfGt5I69cRzjpMoBpavklN
         T/+13z4KHvmeWQuVyAjk7suH1hir5H31x0Gp7l/pWNDcwVuknCvbDKN1oz4mhSiBU/k3
         3b5Q==
X-Gm-Message-State: APjAAAUhUkETtb6PrGxZxflM9u13MnP+M0kRLRIAPju1Q9fJQt5qJ510
        j1UEg2pjR2ojyCWF3h/A3GNf7gkhm1cnFcsPa2o=
X-Google-Smtp-Source: APXvYqwKJZ6bO/qaUDabsFFu/MQ2R2cYOCy4YbyBPX5qBunktYtwdlI59RKnWWOSZiCLoSbjjip5Dos01Fg2X3vQ3QI=
X-Received: by 2002:aed:3baf:: with SMTP id r44mr9788084qte.255.1573212592983;
 Fri, 08 Nov 2019 03:29:52 -0800 (PST)
MIME-Version: 1.0
References: <20191010020725.3990-1-andrew@aj.id.au> <20191010020725.3990-2-andrew@aj.id.au>
 <CACPK8XcGgGsoLNpCccKPb-5bojQS4c5BePewwocc-z29On7Rjg@mail.gmail.com> <20191107230029.75ED72178F@mail.kernel.org>
In-Reply-To: <20191107230029.75ED72178F@mail.kernel.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 8 Nov 2019 11:29:41 +0000
Message-ID: <CACPK8Xe7dmeVjQYObzOw9LdwxH3+1XTcU+RJOZo5C69j8d-yOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019 at 23:00, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Joel Stanley (2019-10-31 21:50:42)
> > Hi clock maintainers,
> >
> > On Thu, 10 Oct 2019 at 02:06, Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > The AST2600 has an explicit gate for the RMII RCLK for each of the four
> > > MACs.
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >
> > I needed this patch and the aspeed-clock.h one for the aspeed dts
> > tree, so I've put them in a branch called "aspeed-clk-for-v5.5" and
> > merged that into the aspeed tree. Could you merge that into the clock
> > tree when you get to merging these ones?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git/log/?h=aspeed-clk-for-v5.5
> >
>
> Can you send a pull request please?

Sure. Here you go. Let me know if you need it in a separate email.

The following changes since commit d8d9ad83a497f78edd4016df0919a49628dcafbc:

  dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
(2019-11-01 15:01:18 +1030)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-5.5-clk

for you to fetch changes up to d8d9ad83a497f78edd4016df0919a49628dcafbc:

  dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
(2019-11-01 15:01:18 +1030)

----------------------------------------------------------------
ASPEED clock device tree bindings for 5.5

----------------------------------------------------------------
>
