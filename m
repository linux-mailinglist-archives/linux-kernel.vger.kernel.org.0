Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1965A1306B5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 08:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgAEHz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 02:55:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAEHz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 02:55:57 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60E1A20848;
        Sun,  5 Jan 2020 07:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578210956;
        bh=KHv0URgMb51Ry29VbaCs6lbRmSIyflQETcBE7Kw5R+Y=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=XayaYns7hBmNBlqIrXlPRSXOB75A6l8msBbFvLJEtqcV1SUUk0e/llbc8vZbRIFHW
         H8HCbyoBTonwIXjaFHTORH+zz0VyrNEQAwkkQn53cbW4fOdCF4v54PVVI/BSnSoLKA
         DYdezgHglvN08Xoiz/eX84+M4V9OQqwu1zgJbpPw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200105075050.1B93E20866@mail.kernel.org>
References: <20191001174439.182435-1-sboyd@kernel.org> <1jd0ffr1jh.fsf@starbuckisacylon.baylibre.com> <20200105075050.1B93E20866@mail.kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] clk: Don't cache errors from clk_ops::get_phase()
To:     Jerome Brunet <jbrunet@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sat, 04 Jan 2020 23:55:55 -0800
Message-Id: <20200105075556.60E1A20848@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-01-04 23:50:49)
>=20
> Quoting Jerome Brunet (2019-10-02 01:31:46)
> > >
> > > +     clk_core_get_phase(core);
> >=20
> > Should the error be checked here as well ?
>=20
> What error?
>=20

Ah the error when clk_ops::get_phase() returns an error? I guess we
should just silently ignore it to maintain the previous behavior? Or we
can bail out of clk registration. Seems low risk to do that in another
patch.

