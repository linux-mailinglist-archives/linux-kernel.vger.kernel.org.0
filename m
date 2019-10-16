Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7981DA233
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 01:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438050AbfJPXcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 19:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391320AbfJPXcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:32:43 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83F592168B;
        Wed, 16 Oct 2019 23:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571268762;
        bh=vAF5XacPrBySfE8BGCFHA/CHcjKVK/jG0R7JNz0rJaE=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=v1uOlhhqTROos2qFhHq5LOyv0BLXvrjL+UPbFZIBSc3//okVWL4copu78NIZymb/0
         M9AYnInwvQfiXBaTX29PP9VeQTjDQ1rS2EKlnmqRHlfMiAFxrUVn41FrIsqFzau1vX
         RsgnF5DCNpzykDkhG+nhmpeZjwtRIioVhRPzjK10=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191014144014.20644-1-yuehaibing@huawei.com>
References: <20191014144014.20644-1-yuehaibing@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     allison@lohutok.net, kstewart@linuxfoundation.org,
        mturquette@baylibre.com, opensource@jilayne.com,
        swinslow@gmail.com, tglx@linutronix.de, yuehaibing@huawei.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] clk: hisilicon: use devm_platform_ioremap_resource() to simplify code
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 16:32:41 -0700
Message-Id: <20191016233242.83F592168B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-10-14 07:40:14)
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next

