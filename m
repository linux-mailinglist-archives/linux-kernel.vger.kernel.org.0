Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A9015D337
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 08:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgBNHyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 02:54:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgBNHyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:54:36 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF17124670
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 07:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581666876;
        bh=uUqCY41ymz6hiHKzFlEzisjq83c9h686/Ry4dcKtL8o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nO8VWAnq6enkWoVO1KQOYen9dfbnv11SjtbXp+5e9AWrErsEw2EGJzm9oxQUQQj5b
         GTGWK9hnefBoQm7ycijq0ujxWXUHB2dkpOXCXZq69cSbfBPP9lVazagzVCiSWZnZRh
         JiDRfIdqXWtwoYtPWpK9YWF4OeGkaWHDqt9+6+t0=
Received: by mail-lj1-f175.google.com with SMTP id r19so9641209ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 23:54:35 -0800 (PST)
X-Gm-Message-State: APjAAAUTC/BbMSa5veLIeZi9vbYvRkp25WSGim1ncfQXswUk6lo7tORG
        D0+OsDqMhxOzu7ZCJQgLLWPLab9yDroqgPedz+I=
X-Google-Smtp-Source: APXvYqxYBogvyVwCKY0O00NON1CcUeROLB0hSLARDR8eSX50Ch0burvTbanjgmW65jT/Dd4xwcQQTYXH4O/btXWthPQ=
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr1196010lji.256.1581666873795;
 Thu, 13 Feb 2020 23:54:33 -0800 (PST)
MIME-Version: 1.0
References: <20200210061544.7600-1-yuehaibing@huawei.com> <9351a746-8823-ee26-70da-fd3127a02c91@linux.intel.com>
 <be093793-3514-840a-ff2f-4dc21d8ee7f1@huawei.com> <CAEnQRZDWFgXocRJxtc2e7McRCAtod6-GwPJaVMdb4ymBZgSD1w@mail.gmail.com>
 <CAJKOXPcxL2vpWGwO1OL9Vv0g6hzbW-AyGJNn=7Yq2iy10_cbhg@mail.gmail.com> <CAEnQRZBgpcLz29PG6pY_6xaULO6siGumqrsO0gRReMRwUOqW2w@mail.gmail.com>
In-Reply-To: <CAEnQRZBgpcLz29PG6pY_6xaULO6siGumqrsO0gRReMRwUOqW2w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 14 Feb 2020 08:54:21 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfv6-wALd6NcyQaWTXCv0SYpfM2W7hpZk8u9cZjcZC=VQ@mail.gmail.com>
Message-ID: <CAJKOXPfv6-wALd6NcyQaWTXCv0SYpfM2W7hpZk8u9cZjcZC=VQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH -next] ASoC: SOF: imx8: Fix randbuild error
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Yuehaibing <yuehaibing@huawei.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 at 22:12, Daniel Baluta <daniel.baluta@gmail.com> wrote:
> >
> > Visible symbols usually should not be selected. The same with symbols
> > with dependencies. The docs have this rule mentioned.
>
> You mean if module X depends on module Y, we shouldn't use select?
> But this exactly what this patch does :).

There are two different cases (hints against using select):
1. select A, if A is a user-visible (possible to select) option,
2. select only A if A depends on B (and B is kind of independent).

These cases are discouraged.

> The problem here is that when X depends on Y, and X=y and Y=m
> when we try to compile X if get an error because we cannot find a symbol from Y.
>
> I think if X depends on Y, and X is forced to "y" then also Y should
> be forced on "y".

If X is bool, then depends should be =y.
If X is tristate, then probably you need something like:
    depends (Y!=m || m)

There is also solution like:
config CEPH_FSCACHE
    depends on CEPH_FS=m && FSCACHE || CEPH_FS=y && FSCACHE=y
but it works if the upper-level option (CEPH_FS) is a tristate.

Best regards,
Krzysztof
