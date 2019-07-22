Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F1D70C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 00:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbfGVWY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 18:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbfGVWY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:24:27 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4980221985;
        Mon, 22 Jul 2019 22:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563834266;
        bh=RUAzHw0HpGhBGFpbCBz+OfMJci0eEv0tJXsUiAyM2b4=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=07kCOgSUTdS6inhLNy0uXWAxPcaTixm+GwHsak258pxkb3aHsqvt495qaSZND9jWM
         +6w2jVAkrag/ewmWIj0rrqBY29HHLqQlLv3Bs59eHQaatcXVMDRt7tjMpaFJaTBraH
         d+riC4kTN0Uidc088dIa2S4lE1V79WAKBrEqCQjk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a92ca50d-b33e-8779-294c-301535d0f0d5@wanadoo.fr>
References: <20190701165020.19840-1-colin.king@canonical.com> <20190722212414.6EF8D21900@mail.kernel.org> <d1cd2b10-8fd4-f224-3bcd-5b938f72d249@wanadoo.fr> <20190722215314.9F4F121951@mail.kernel.org> <a92ca50d-b33e-8779-294c-301535d0f0d5@wanadoo.fr>
Subject: Re: [PATCH][next] clk: Si5341/Si5340: remove redundant assignment to n_den
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Colin King <colin.king@canonical.com>,
        linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 15:24:25 -0700
Message-Id: <20190722222426.4980221985@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2019-07-22 15:00:24)
>
> I don't use it explicitly, but the suggestions I get include some git=20
> history, so I guess that it is on by default.
>=20
> I was thinking at parsing files to see if MODULE_AUTHOR includes an email.
>=20

Ok. Feel free to write a patch. Just know that MODULE_AUTHOR isn't
always there so it's not a substitute for looking at git history or git
blame to figure out who wrote the code.

I suspect it's better to try to work on code and infrastructure to make
these sorts of patches and questions irrelevant by detecting these
problems before the code is merged, instead of after, by trawling the
mailing lists and trying to apply patches and test them for common
problems and then notifying the people working on the code. I don't have
unlimited time in my life, so getting patches like this just makes me
spend more time doing mundane tasks I don't want to do.

TL;DR: Please help automate this sort of stuff!

