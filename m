Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F345833A20
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 23:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfFCVtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 17:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfFCVtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 17:49:13 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07C4A23A48;
        Mon,  3 Jun 2019 21:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559598553;
        bh=roe7k85B1WBARYVkgdFOauIjF/htR4Atr22VzMKxNss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aHoSjDuYs+ZX4i6zuooI42FjZrBT6jsYBTiyfvLT8vIiE2+NJ4cpctPy3uJslHaoD
         DuOAqey1CzPQxtM6n7R7knkOHI2Tkhnh2bGu84jZ9Qjh9Br1aMTrU9/qB0sRq8fZ+B
         ZZBE8Z1SJPdqOtoBIHdsiJwu9Lv1ZaysBitSi/AU=
Date:   Mon, 3 Jun 2019 14:49:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        keescook@chromium.org, gustavo@embeddedor.com, joe@perches.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 0/4] zstd: reduce stack usage
Message-Id: <20190603144912.34e1414376e07c7b1af53205@linux-foundation.org>
In-Reply-To: <1559552526-4317-1-git-send-email-maninder1.s@samsung.com>
References: <CGME20190603090227epcas5p348327061a3facbb9dfcf662bf2bc196e@epcas5p3.samsung.com>
        <1559552526-4317-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Jun 2019 14:32:02 +0530 Maninder Singh <maninder1.s@samsung.com> wrote:

> This patch set reduces stack usage for zstd code, because target like ARM has
> limited 8KB kernel stack, which is getting overflowed due to hight stack usage
> of zstd code with call flow like:

That's rather bad behaviour.  I assume the patchset actually fixes this?

I think I'll schedule the patchset for 5.2-rcX so that zstd is actually
usable on arm in 5.2.  Does that sound OK?

