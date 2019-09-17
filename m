Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB14B5411
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 19:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbfIQRXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 13:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbfIQRXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:23:12 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD7CC20640;
        Tue, 17 Sep 2019 17:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568740991;
        bh=cQXZwJ3tGhoP3HxtYH0RfkDfqcLmpGLF2EtRk8KcnIk=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=2LpKjfwsJPtnUUnnm4SdTLuxuHF4te7U8nGRtWzyMtypCngGoTjIAVgo6H1UPQCGC
         R9X0otDFZTZpIoa6I/nzbl3b5TY0JUZVQWy5JlbX0m6qXJAytYGGrTSuEuiqKmk3mp
         nQZQYiyKXheDq6oyn9l/aFAsuPxEOkNyLyHIfRag=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1567414859-3244-2-git-send-email-weiyi.lu@mediatek.com>
References: <1567414859-3244-1-git-send-email-weiyi.lu@mediatek.com> <1567414859-3244-2-git-send-email-weiyi.lu@mediatek.com>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, CK Hu <ck.hu@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>, Weiyi Lu <weiyi.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RESEND PATCH v1 1/3] clk: mediatek: Register clock gate with device
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 10:23:10 -0700
Message-Id: <20190917172311.BD7CC20640@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2019-09-02 02:00:57)
> Allow those clocks under a power domain to do the runtime pm operation
> by forwarding the struct device pointer from clock provider.
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---

Applied to clk-next

