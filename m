Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6FE136144
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 20:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbgAITj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 14:39:29 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:57254 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730696AbgAITj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:39:29 -0500
X-Greylist: delayed 969 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2020 14:39:28 EST
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id C2ADF3AA859
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jan 2020 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A6517200003;
        Thu,  9 Jan 2020 19:14:39 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Wenwen Wang <wenwen@cs.uga.edu>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: sm_ftl: fix NULL pointer warning
Date:   Thu,  9 Jan 2020 20:14:38 +0100
Message-Id: <20200109191438.10651-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107212509.4004137-1-arnd@arndb.de>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: de08b5ac10420db597cb24c41b4d8d06cce15ffd
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-07 at 21:24:52 UTC, Arnd Bergmann wrote:
> With gcc -O3, we get a new warning:
> 
> In file included from arch/arm64/include/asm/processor.h:28,
>                  from drivers/mtd/sm_ftl.c:8:
> In function 'memset',
>     inlined from 'sm_read_sector.constprop' at drivers/mtd/sm_ftl.c:250:3:
> include/linux/string.h:411:9: error: argument 1 null where non-null expected [-Werror=nonnull]
>   return __builtin_memset(p, c, size);
> 
> >From all I can tell, this cannot happen (the function is called
> either with a NULL buffer or with a -1 block number but not both),
> but adding a check makes it more robust and avoids the warning.
> 
> Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
