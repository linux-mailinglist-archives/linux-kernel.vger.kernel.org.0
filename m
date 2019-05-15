Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2582B1F4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 14:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfEOMr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 08:47:59 -0400
Received: from ns.iliad.fr ([212.27.33.1]:33166 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfEOMr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:47:59 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 955111FF4E;
        Wed, 15 May 2019 14:47:57 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 7D59D1FF2C;
        Wed, 15 May 2019 14:47:57 +0200 (CEST)
To:     arm-soc <arm@kernel.org>, Joe Perches <joe@perches.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH] Opt out of scripts/get_maintainer.pl
Message-ID: <d1427cd2-9111-025c-1a97-d0fa498f1a03@free.fr>
Date:   Wed, 15 May 2019 14:47:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed May 15 14:47:57 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few months ago, I submitted a trivial arm64 defconfig update.
get_maintainer.pl now outputs my address for every defconfig tweak.
Add me to .get_maintainer.ignore to opt out of these notifications.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 .get_maintainer.ignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
index cca6d870f7a5..a64d21913745 100644
--- a/.get_maintainer.ignore
+++ b/.get_maintainer.ignore
@@ -1 +1,2 @@
 Christoph Hellwig <hch@lst.de>
+Marc Gonzalez <marc.w.gonzalez@free.fr>
-- 
2.17.1
