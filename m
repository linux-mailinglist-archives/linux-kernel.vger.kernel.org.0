Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35DC26B9B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfGQKEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 06:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfGQKEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:04:51 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 246D321848;
        Wed, 17 Jul 2019 10:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563357890;
        bh=cxrHAxpbFgJEYGfTBwEGfvIpkQdM8v6E7N7v7YKfsyo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ce0Djo5SGxrZvFuUFJCysw5byh7FkXoy/2aP1lYiuGvzZlM3HfFHuO+EnGWglmaTM
         TyRksP1eePtU/ApVj16anmAtz6ktbuSQIUP/6H6yGnSCLYPq4Plw+1ZtRu41mCmGmT
         TmBD/RuS/K79iuEnAsGLsyc+xslh5oFzU6sQsLpQ=
Received: by mail-lj1-f181.google.com with SMTP id d24so23017211ljg.8;
        Wed, 17 Jul 2019 03:04:50 -0700 (PDT)
X-Gm-Message-State: APjAAAXv/OND3zOTYUVIcssgrqwp8O/h/Xe0QPCatSMtME8f+MrA7nzg
        txcsvAiJdkbxfe7/uwzvU5Is03Yr1y8iwccr2OE=
X-Google-Smtp-Source: APXvYqyUF6RwWmtpq2St1SUUGe05KtJonxRDAPvTHfsETJ19YFTa2yjFxeqxPAGfIR3HLu1rlVn3N4W4P43GH7prZcw=
X-Received: by 2002:a2e:124b:: with SMTP id t72mr20711008lje.143.1563357888437;
 Wed, 17 Jul 2019 03:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190715124454eucas1p1cd37552b222539b02629cb52e646ae29@eucas1p1.samsung.com>
 <20190715124417.4787-1-l.luba@partner.samsung.com> <20190715124417.4787-26-l.luba@partner.samsung.com>
In-Reply-To: <20190715124417.4787-26-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 17 Jul 2019 12:04:36 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcfqp2mUXW70=puti7mf0S5LoXF4hFQt5-9tvCgLzjknQ@mail.gmail.com>
Message-ID: <CAJKOXPcfqp2mUXW70=puti7mf0S5LoXF4hFQt5-9tvCgLzjknQ@mail.gmail.com>
Subject: Re: [PATCH v1 25/50] ARM: dts: exynos: add 300MHz to bus_disp1_fimd
 in Exynos5420
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com, Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019 at 14:44, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> According to the documentation max frequency for ACLK300_DISP1 is 300MHz.
> Add an OPP which makes it possible to use the full performance when needed.

Squash it with #23.

BR,
Krzysztof
