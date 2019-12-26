Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE62212AF03
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Dec 2019 22:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfLZV7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 16:59:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfLZV7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:59:20 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFD572080D;
        Thu, 26 Dec 2019 21:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577397559;
        bh=lWn5ZrhQ46qp8zNoIfQsiIEIyzXajafK7i+t8OWkpJI=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=xZqvSYndZ6xXOzX67Dd8GhQLizZ8WIP5c+lvroKfQfP6vK90ra7N6ewBDxKvAFH3I
         /GnzMMwb3engj33QgVGQ9qqbDSsdQ2CTIJm4bNuePjye2MDuI8SWW9wNWR5Jqnvh66
         533WcaGedLAYMLISsw1BLW8dqDwWwYAcWiPwGfkY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fed37460-6097-1a3d-3c05-e203871610ac@roeck-us.net>
References: <20191225163429.29694-1-linux@roeck-us.net> <1jd0cbpg77.fsf@starbuckisacylon.baylibre.com> <fed37460-6097-1a3d-3c05-e203871610ac@roeck-us.net>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Guenter Roeck <linux@roeck-us.net>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] clk: Don't try to enable critical clocks if prepare failed
User-Agent: alot/0.8.1
Date:   Thu, 26 Dec 2019 13:59:19 -0800
Message-Id: <20191226215919.CFD572080D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Guenter Roeck (2019-12-26 09:22:10)
> On 12/26/19 1:51 AM, Jerome Brunet wrote:
> >=20
> > However, we would not want a critical clock to silently fail to
> > enable. This might lead to unexpected behavior which are generally hard
> > (and annoying) to debug.
> >=20
> > Would you mind adding some kind of warning trace in case this fails ?
> >=20
>=20
> The really relevant information is:
>=20
> bcm2835-clk 3f101000.cprman: plld: couldn't lock PLL
>=20
> which is already displayed (and not surprising since cprman isn't impleme=
nted
> in qemu). While I agree that an error message might be useful, replacing
> one traceback with another doesn't really make sense to me, and I am not
> really a friend of spreading tracebacks throughout the kernel. Please feel
> free to consider this patch to be a bug report, and feel free to ignore it
> and suggest something else.

Can the cprman device node be disabled or removed in the DT that qemu
uses? If it isn't actually implemented then it shouldn't be in the DT.
Presumably that will make this traceback go away.

