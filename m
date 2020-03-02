Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E54B17655E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 21:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCBUwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 15:52:35 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42230 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgCBUwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:52:34 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so691941otd.9;
        Mon, 02 Mar 2020 12:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Mbj926lcMMww9ZNMv7XcrAqImfQQxGz/1hr+H7/z0k=;
        b=SALkbDmCO4oHDdV8909meb+aI/DR1q76h+u93aaSgCMqdniHsTvmRHSH3pbNvvIoPs
         82c69vs4g0NcHa36ujwG4GC/3KMktJDR0DnPk3LXq07Qits5udJ2eMkph+REXEecqb7R
         /FyxXGudoDoG5ChohA4XZ68VvJyv0GEumOHCMd1y26fpJc+kmu5Sq4jCTba6zHVZP2Cg
         4OfyFiM5BgwKdRIHUmvoMyIovmltboZvxqnRRcne3FNCJs8/oaSsdawPiQHEhw3d3y7z
         959Q9f4OjpwKkdh9FwTaloM6382WTaKD7WTdhjaPRTv1q2uBVlOhT01+PtKpU8DVDJf4
         xLZA==
X-Gm-Message-State: ANhLgQ1emJCmR8VtHnQfc9Svu+zrOLrKUx8Sq7J2kj1xJkJQ293JaRYj
        XgljySMGgnmDXW4ABlbuFQ==
X-Google-Smtp-Source: ADFU+vsU4BwI+ZhtAeYrEEnEWFuq7vUTpJHGBZvXyUJlXUt3DWxeVgdXESU0lhisXPI0WR6u21nvWw==
X-Received: by 2002:a05:6830:11c7:: with SMTP id v7mr769049otq.41.1583182354070;
        Mon, 02 Mar 2020 12:52:34 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p141sm934283oic.7.2020.03.02.12.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 12:52:33 -0800 (PST)
Received: (nullmailer pid 9793 invoked by uid 1000);
        Mon, 02 Mar 2020 20:52:32 -0000
Date:   Mon, 2 Mar 2020 14:52:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: Convert UniPhier clock to json-schema
Message-ID: <20200302205232.GA9730@bogus>
References: <20200225010328.5638-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225010328.5638-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 10:03:28 +0900, Masahiro Yamada wrote:
> Convert the UniPhier clock controller binding to DT schema format.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../clock/socionext,uniphier-clock.yaml       |  94 +++++++++++++
>  .../bindings/clock/uniphier-clock.txt         | 132 ------------------
>  2 files changed, 94 insertions(+), 132 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
>  delete mode 100644 Documentation/devicetree/bindings/clock/uniphier-clock.txt
> 

Applied, thanks.

Rob
