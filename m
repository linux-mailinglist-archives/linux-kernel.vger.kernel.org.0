Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAF855A43
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 23:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfFYVvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 17:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfFYVvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:51:45 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A5B82086D;
        Tue, 25 Jun 2019 21:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561499504;
        bh=zJpQRqXOj6DwCE1GBSj6EfyABK5ll9X4V3VtqR4B+8I=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=FixI2VzZO5Nhs1oXo3I3h7qsVVQtRa6pqivxgXefsZnDxrFJcrRpiaa1bum2lMwwu
         J6tUdYZ09Z32NzeTSCit8EbD76vmPRbpIrx8Iscswky8JOENRfIg3dx0FRcJLLPugr
         p6QEsBAua1Xs6JT0+J267jkN5VHR8Pj+vV/P5yA4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190617135602.32766-1-geert+renesas@glider.be>
References: <20190617135602.32766-1-geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH trivial] clk: Grammar missing "and", Spelling s/statisfied/satisfied/
Cc:     Jiri Kosina <trivial@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 14:51:43 -0700
Message-Id: <20190625215144.1A5B82086D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2019-06-17 06:56:02)
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied to clk-next

