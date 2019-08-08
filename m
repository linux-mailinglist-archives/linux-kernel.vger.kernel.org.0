Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1548651D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 17:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbfHHPF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 11:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfHHPF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:05:27 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F2A1217D7;
        Thu,  8 Aug 2019 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565276726;
        bh=fOS2h4GWI90AxufiprYZK3XN8pFdskKCIW7fKG4FeUI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VFMP51oCHDQdJoMYVsEVFhcHHo+wLWULdRccvSA78T9Lq4peRuwjjfseVgNaYxWAD
         KwFhyXc8R4nuoQ8mbh661ihCJ/mNEKqK9lAiUQUbqB+9dhnMMVC1aYNdUCrONTeU26
         bodgB479vAHOHDZvEHGgojYCWYdojpP/EH55ibS0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5961554a-6416-48ea-44e2-d8e3c7576af0@web.de>
References: <5961554a-6416-48ea-44e2-d8e3c7576af0@web.de>
Subject: Re: [PATCH] clk: Use seq_puts() in possible_parent_show()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To:     Markus Elfring <Markus.Elfring@web.de>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Thu, 08 Aug 2019 08:05:25 -0700
Message-Id: <20190808150526.9F2A1217D7@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Markus Elfring (2019-07-01 13:24:37)
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 1 Jul 2019 22:20:40 +0200
>=20
> A string which did not contain a data format specification should be put
> into a sequence. Thus use the corresponding function =E2=80=9Cseq_puts=E2=
=80=9D.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Applied to clk-next

