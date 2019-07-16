Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A486E6AD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbfGPQ5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 12:57:47 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:40086 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387770AbfGPQ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 12:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1563296264; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CIm3UF72t/CRg7HORY+Eekv1Vqd9sqRYBC3uCb2LKlM=;
        b=VHz5QeQgZ5hB0hgGOJGzgGjgugrTeuWCnReAedxYYFdWXRN4W1tiyp6M8tkAoxtQlUP2vk
        53k+NfFAeAErF1yKNfjRcVB49kDadT8UnJHTH2AQh3xV/8fTCCHIoFhpLfSgkA9oe5xr/u
        xxlR6OrjI944llv4VisxfBvGGMhWzWg=
Date:   Tue, 16 Jul 2019 12:57:31 -0400
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic: Remove OF_POPULATED flag to probe children
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>, od@zcrc.me,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1563296252.1773.1@crapouillou.net>
In-Reply-To: <20190716164821.6ED922064B@mail.kernel.org>
References: <20190714215715.11412-1-paul@crapouillou.net>
        <20190716164821.6ED922064B@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mar. 16 juil. 2019 =E0 12:48, Stephen Boyd <sboyd@kernel.org> a=20
=E9crit :
> Quoting Paul Cercueil (2019-07-14 14:57:15)
>>  Remove the OF_POPULATED flag, in order to probe children when the
>>  device node is compatible with "simple-mfd".
>=20
> We have CLK_OF_DECLARE_DRIVER for this. Can you use that?

Didn't see it. I'll send an updated patch then, thanks.


>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/clk/ingenic/cgu.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>=20

=

