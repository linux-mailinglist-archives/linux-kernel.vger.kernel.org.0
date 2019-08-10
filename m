Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D339F88B5E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 14:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfHJMeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 08:34:09 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53434 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfHJMeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 08:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565440447; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ZQhsJMabqbRgpu68UVwl7fKUsSYukSxskB1Wg8hBko=;
        b=xmHrxd/naP+Nzl/Rz/T3Rui2kt5MEn6Y1mTOZqob8Y1F+ncvodduz3SLATl+cT2C6AP2t5
        H+msk9mCXIuf+JbJ+Bsc9hDUougyjX5GnoqT6gMOSLv07NTtB18YIL6WH65zSlYoNh0nwH
        7IM2ZSDTssR51hEX+z27QzAE2HaJQ0s=
Date:   Sat, 10 Aug 2019 14:34:02 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic: Use CLK_OF_DECLARE_DRIVER macro
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>, od@zcrc.me,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1565440442.2007.0@crapouillou.net>
In-Reply-To: <20190808042354.5168A21743@mail.kernel.org>
References: <20190716170800.23668-1-paul@crapouillou.net>
        <20190808042354.5168A21743@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le jeu. 8 ao=FBt 2019 =E0 6:23, Stephen Boyd <sboyd@kernel.org> a =E9crit :
> Quoting Paul Cercueil (2019-07-16 10:08:00)
>>  By using CLK_OF_DECLARE_DRIVER instead of the CLK_OF_DECLARE macro,=20
>> we
>>  allow the driver to probe also as a platform driver.
>>=20
>>  While this driver does not have code to probe as a platform driver,=20
>> this
>>  is still useful for probing children devices in the case where the
>>  device node is compatible with "simple-mfd".
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>=20
> What's the baseline for this? It doesn't apply cleanly to v5.3-rc1

I think it was v5.2-rc7. I'll send a V2 rebased on v5.3-rc3.

-Paul

=

