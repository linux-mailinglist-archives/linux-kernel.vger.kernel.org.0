Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4161C55F72
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 05:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfFZDSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 23:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfFZDSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:18:01 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DDC52146E;
        Wed, 26 Jun 2019 03:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561519080;
        bh=UAzBR8Dj63DBbTFMDOv88/PyvI2dT0MwVuHEAAsfnEo=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=x91NUAtHfPYSLF6HTJoWyzdczsv+ay4w6Nlo2VO+3U84jT9daqZZqcqkKQog20Nj4
         WaxdbvF6tJCD+V2o27D/6+ktW5jejScfSbaGMtUaNFgj/kl3k4k5AvImskofnSE2sO
         g1sweZRWn5xn+jYVK8Elr7nbEx0mtONXCr7lXtMs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f9ee627a0d4f94b894aa202fee8a98444049bed8.1561492937.git.leonard.crestez@nxp.com>
References: <f9ee627a0d4f94b894aa202fee8a98444049bed8.1561492937.git.leonard.crestez@nxp.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/2] scripts/gdb: add lx-genpd-summary command
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 20:17:59 -0700
Message-Id: <20190626031800.1DDC52146E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Leonard Crestez (2019-06-25 13:05:11)
> This is like /sys/kernel/debug/pm/pm_genpd_summary except it's
> accessible through a debugger.
>=20
> This can be useful if the target crashes or hangs because power domains
> were not properly enabled.
>=20
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

