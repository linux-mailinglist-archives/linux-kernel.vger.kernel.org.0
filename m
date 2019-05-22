Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8704925DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 08:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfEVGBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 02:01:50 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:41248 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfEVGBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 02:01:50 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 88021516CC;
        Wed, 22 May 2019 08:01:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id gLwQp6ocrRCj; Wed, 22 May 2019 08:01:27 +0200 (CEST)
Subject: Re: [PATCH] mtd: cfi_cmdset_0002: dynamically determine the max
 sectors
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190522000628.13073-1-chris.packham@alliedtelesis.co.nz>
From:   Stefan Roese <sr@denx.de>
Message-ID: <e4fb784f-ea00-6281-409c-d440ce13eb50@denx.de>
Date:   Wed, 22 May 2019 08:01:26 +0200
MIME-Version: 1.0
In-Reply-To: <20190522000628.13073-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.19 02:06, Chris Packham wrote:
> Because PPB unlocking unlocks the whole chip cfi_ppb_unlock() needs to
> remember the locked status for each sector so it can re-lock the
> unaddressed sectors. Dynamically calculate the maximum number of sectors
> rather than using a hardcoded value that is too small for larger chips.
> 
> Tested with Spansion S29GL01GS11TFI flash device.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

This hardcoded limit always annoyed me at that time, so thanks for
"fixing" this:

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan
