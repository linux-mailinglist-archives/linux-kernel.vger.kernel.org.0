Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FC212473
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 00:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfEBWLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 18:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfEBWLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 18:11:36 -0400
Received: from localhost (unknown [104.132.0.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9AB12080C;
        Thu,  2 May 2019 22:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556835095;
        bh=2Npcycgwql1NQwXWHBSmcFCyRTuCpGuk4AWq0e9cSUI=;
        h=In-Reply-To:References:To:Cc:From:Subject:Date:From;
        b=SqczSP24PSwwh51HipvMPIHWCAgkSQYRBX9iVLL0l3kbSCXTluWEQF/+H7gcMfnWg
         tlFI3LseEmvmcfVp1jpEQaMU3IR0vH8gGfmWFlAixbSnetJQRbFRd7O77kvP/LMX5L
         u2DAf3zOR5K3fNUtZMy4O0b9J4YmlpgMZ1Ie93Lw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190430205055.25673-2-paul.walmsley@sifive.com>
References: <20190430205055.25673-1-paul.walmsley@sifive.com> <20190430205055.25673-2-paul.walmsley@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>, mturquette@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 1/2] clk: analogbits: add Wide-Range PLL library
Message-ID: <155683509491.200842.3659543106794259397@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 02 May 2019 15:11:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2019-04-30 13:50:58)
> Add common library code for the Analog Bits Wide-Range PLL (WRPLL) IP
> block, as implemented in TSMC CLN28HPC.
>=20
> There is no bus interface or register target associated with this PLL.
> This library is intended to be used by drivers for IP blocks that
> expose registers connected to the PLL configuration and status
> signals.
>=20
> Based on code originally written by Wesley Terpstra
> <wesley@sifive.com>:
> https://github.com/riscv/riscv-linux/commit/999529edf517ed75b56659d456d22=
1b2ee56bb60
>=20
> This version incorporates several changes requested by Stephen
> Boyd <sboyd@kernel.org>.
>=20
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Wesley Terpstra <wesley@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Megan Wachs <megan@sifive.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

Applied to clk-next

