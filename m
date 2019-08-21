Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A323D973EA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 09:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfHUHvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 03:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfHUHvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:51:23 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FB6622DA7;
        Wed, 21 Aug 2019 07:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566373882;
        bh=UwB5meX7vznGepPgdAytPL5pzFFhozjObnM5Emeu3Rc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZcC2iBocY8Bq2caYhsOh9nB+bjqi61sGfQLMGW90vuMUZdyPCDLoDooBI7QohuyoX
         zhcIqqbJqgYjjVH+1appGwsH73Hco46tlKuvhKJoAvC0Mv0EPNjrKurs5HMygnKLd2
         MmaG/Rz8PqJ9tj8Thc8GQGUyR4sfJNiQ4qQH9mq4=
Received: by mail-lj1-f179.google.com with SMTP id f9so1187185ljc.13;
        Wed, 21 Aug 2019 00:51:22 -0700 (PDT)
X-Gm-Message-State: APjAAAUAvJGd+U0Qu21pcY3joTbZ3tp6/jWDuu41mJXQ5XDYmGO/eRsU
        BE+iFDweNKv650RZJ+Lku1KFofKb+YTLeWiabrE=
X-Google-Smtp-Source: APXvYqyr3SjkA9GUYgeOfJkgxOJK4q881xniyq1fC4O0Cj/XRVNHydTVuF3his48XC6s8Vs0/qhvB6HW5gQzVguV0e4=
X-Received: by 2002:a2e:b4d4:: with SMTP id r20mr18143652ljm.5.1566373880466;
 Wed, 21 Aug 2019 00:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190816163042.6604-1-krzk@kernel.org>
In-Reply-To: <20190816163042.6604-1-krzk@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 21 Aug 2019 09:51:09 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcgZ2_ofZyAeTSxALkALaP-SFNfvNmNPYSPyLzuhpGZ0w@mail.gmail.com>
Message-ID: <CAJKOXPcgZ2_ofZyAeTSxALkALaP-SFNfvNmNPYSPyLzuhpGZ0w@mail.gmail.com>
Subject: Re: [GIT PULL 1/3] soc: samsung: Exynos for v5.4
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 at 18:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
>
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-5.4
>
> for you to fetch changes up to 40d8aff614f71ab3cab20785b4f213e3802d4e87:
>
>   soc: samsung: chipid: Convert exynos-chipid driver to use the regmap API (2019-08-15 20:25:25 +0200)
>
> ----------------------------------------------------------------
> Samsung soc drivers changes for v5.4
>
> Add Exynos Chipid driver for identification of product IDs and SoC
> revisions.  The driver also exposes chipid regmap, later to be used by
> Exynos Adaptive Supply Voltage driver (adjusting voltages to different
> revisions of same SoC).

It turns out that it brings troubles (code is executed on every
platform polluting logs because it is an initcall, not a driver) so
Sylwester (submitter) asked to skip the submission.

Please ignore the pull request.

Best regards,
Krzysztof
