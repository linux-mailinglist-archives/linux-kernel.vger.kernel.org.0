Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F5F85674
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 01:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbfHGX2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 19:28:16 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53100 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbfHGX2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565220494; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfQ9BqFAq8e3E9UBKWqWbxCELoLpoolgTNWK+UTm9tA=;
        b=fD55OoxLQDoAKvLrIU1X1slVdUZsoj2zhtbRRO4OqU+EF5hVsmnJQ0BYZfdZVn73M/UjLa
        wl8p/jOHVCICUEDD7dbx6WtmOkhrImAxARiTH3z6TqfDryNLUitwG0aQyoaep7uhGIHOq8
        3ACVINufhw+oNhs+ZJTT8joq8GT+MLQ=
Date:   Thu, 08 Aug 2019 01:28:10 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic/jz4740: Fix "pll half" divider not
 read/written properly
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1565220490.15188.0@crapouillou.net>
In-Reply-To: <20190807213358.A62002186A@mail.kernel.org>
References: <20190701113606.4130-1-paul@crapouillou.net>
        <20190807213358.A62002186A@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mer. 7 ao=FBt 2019 =E0 23:33, Stephen Boyd <sboyd@kernel.org> a =E9crit=20
:
> Quoting Paul Cercueil (2019-07-01 04:36:06)
>>  The code was setting the bit 21 of the CPCCR register to use a=20
>> divider
>>  of 2 for the "pll half" clock, and clearing the bit to use a divider
>>  of 1.
>>=20
>>  This is the opposite of how this register field works: a cleared bit
>>  means that the /2 divider is used, and a set bit means that the=20
>> divider
>>  is 1.
>>=20
>>  Restore the correct behaviour using the newly introduced .div_table
>>  field.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>=20
> Applied to clk-next. Does this need a fixes tag?

It depends on commit a9fa2893fcc6 ("clk: ingenic: Add support for
divider tables") which was sent without a fixes tag, so it'd be
a bit difficult. Probably not worth the trouble.

-Paul

=

