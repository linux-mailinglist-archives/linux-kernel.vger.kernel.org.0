Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA81B460E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 05:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392245AbfIQDiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 23:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfIQDiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 23:38:21 -0400
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2BC120650;
        Tue, 17 Sep 2019 03:38:19 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.4
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <a6d7c0bc-a6df-62be-ed2b-944551def5af@linux-m68k.org>
Date:   Tue, 17 Sep 2019 13:38:17 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Can you please pull the m68knommu git tree, for-next branch.

Only a single change, fix up header include in ColdFire specific GPIO
handling code.

Regards
Greg




The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e:

   Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next

for you to fetch changes up to 372ea263b3d9cdeb70f8cffa025b2e0875e51b62:

   m68k: coldfire: Include the GPIO driver header (2019-09-09 09:32:32 +1000)

----------------------------------------------------------------
Linus Walleij (1):
       m68k: coldfire: Include the GPIO driver header

  arch/m68k/coldfire/gpio.c | 1 +
  1 file changed, 1 insertion(+)
