Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0815837C60
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 20:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfFFSiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 14:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfFFSiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:38:50 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E21820868;
        Thu,  6 Jun 2019 18:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559846329;
        bh=JzQqaRmZwOMurAoy8+YC4u2pY20QAdiwZNKgQAQJ5qA=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=ONAhlg/bWC/qFxfVmTMoY8G9PmitxBKXNxTwC93OxNUxSAp8fML2unVAMoptK4qCB
         nP+Vgmb+UO1v+7YgHgYjYBd22FzvGzEgDYzwoxcuFLE6aMsCWwalgECwn4/dC+h5O0
         UcDQsq4R81eiPA2wmaC5dmWIGqam6hMEFzC9/gm4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190525184253.3088-2-martin.blumenstingl@googlemail.com>
References: <20190525184253.3088-1-martin.blumenstingl@googlemail.com> <20190525184253.3088-2-martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/1] clk: pwm: implement the .get_duty_cycle callback
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 11:38:48 -0700
Message-Id: <20190606183849.9E21820868@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2019-05-25 11:42:53)
> Commit 9fba738a53dda2 ("clk: add duty cycle support") added support for
> getting and setting the duty cycle of a clock. This implements the
> get_duty_cycle callback for PWM based clocks so the duty cycle is shown
> in the debugfs output (/sys/kernel/debug/clk/clk_summary).
>=20
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Seems ok to me. I'm not sure how useful it will be if pwm has debugfs
that can be read too, but I'm not too worried about it.

Applied to clk-next

