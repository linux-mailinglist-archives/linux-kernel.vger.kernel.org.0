Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB70177655
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 13:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgCCMrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 07:47:00 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43918 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgCCMq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:46:59 -0500
Received: by mail-lf1-f68.google.com with SMTP id s23so2588004lfs.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 04:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pApeAoBn1TbpfXW2dmTLTf9gfqzvW3DOKNrNysvAldw=;
        b=ODlGKB8wwjJZKEO70OxhYHWn4gC4iQlLm+XrIh4OFH3iejS3rg2nErBSNrw9Qxshi6
         1gpN2VVJfcWt4qZhdZ3uEKe/GA6D0oXK9o+AxH9SqIqE5deiXVFS5JPlnlRb7W9qWd2p
         Qhs1+wuxuMVd6J5sUSBI/OEtcEyllJ2FoVK/bdaloS3Bp43LbZnqDdSKi71OKy1M7BY0
         TXWpjIaBQSWqSR4xm6/6iLnii/rcaLbyAOHoaeJrN6tmX5Ave8tqn5NxPJdsiDWbc2ws
         wOZ1Iasit8qxP7R36xtOcCrAA6vMT510+vVvYlxdcg2lwyUmSGyR0YHjUyyvtiCunZQb
         ueag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pApeAoBn1TbpfXW2dmTLTf9gfqzvW3DOKNrNysvAldw=;
        b=tADsiCmbrT33mccYGtlzTAvHK3u5bggXXpiLbRcB94Mg5F2KGDs8/0HwgxrSheyBw5
         qNsJ09FaQ/bcwESlyLZwxKldkQwFeNIW/0wwaNBDt70rbL3MF0SsxqVa6YhKExODlVT8
         oVZa7l/loydQdtpbMO99924tr9maksnhl4WIuI8e6iK1QbnQXh+nWOZb2We4YuITzi29
         sbNdLHAEZz/B54KVd8+MvoxOB+x8ddBp/zjtrZgJ7Z3pdbwCM3CiNiCOhHdzDdWy2CB/
         UpiHEbTwnWgckIJQdk/5nuLW/8pOfVgmolcty5/kYzg5sbLXFUjVQMWtpZWJDFsa/HDA
         CiqQ==
X-Gm-Message-State: ANhLgQ0fcwwoG2jWweuJhQ/unN8TEs2D9gKrJgcqwVgvVPo0zvbqWisp
        oi8nwnmD2xkj3Ncq+DOke/SLtGQufG+rw/bgkKcwZQ==
X-Google-Smtp-Source: ADFU+vveCcd3mJKFto36ctzYcVg11SxOFVs72ItChP7e+OVk/jIhV2OoD94fhb4y3ETydv8N+LhTNJ4Zqmg9jvXAmZY=
X-Received: by 2002:a19:110:: with SMTP id 16mr2705207lfb.21.1583239617657;
 Tue, 03 Mar 2020 04:46:57 -0800 (PST)
MIME-Version: 1.0
References: <eeb12d7843fb06f80e19f98eb25711231c3b610f.1583205650.git.baolin.wang7@gmail.com>
In-Reply-To: <eeb12d7843fb06f80e19f98eb25711231c3b610f.1583205650.git.baolin.wang7@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 3 Mar 2020 13:46:46 +0100
Message-ID: <CACRpkdbDYZm26zmw6RKuB449ukXeXeJ9mnog8cFyKoExedSMDw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sprd: Fix the kconfig warning
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 4:32 AM Baolin Wang <baolin.wang7@gmail.com> wrote:

> On X86 plaform, if the CONFIG_OF is not selected, and set the
> CONFIG_SPRD_SC9860 as 'm', that will cause below waring:
>
> WARNING: unmet direct dependencies detected for PINCTRL_SPRD
>   Depends on [n]: PINCTRL [=y] && OF [=n] && (ARCH_SPRD || COMPILE_TEST [=y])
>   Selected by [m]:
>   - PINCTRL_SPRD_SC9860 [=m] && PINCTRL [=y]
>
> Thus move the configuration dependency under CONFIG_PINCTRL_SPRD_SC9860
> to fix the warning.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Oh there is a fix.

Patch applied, thanks!

Yours,
Linus Walleij
