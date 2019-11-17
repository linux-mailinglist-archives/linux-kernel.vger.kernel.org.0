Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E900FFBE8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 23:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfKQWQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 17:16:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59611 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfKQWQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 17:16:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75A8A2B478;
        Sun, 17 Nov 2019 17:16:54 -0500 (EST)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=wcY
        WHxFEdPGu96zhB6XLRqRXRqk=; b=FLYYwMN7PWljVMfb0l23CeKQyzUEqe997DP
        BfXUNMQuc1G9fVLaUCMgqgJCXXBUbV3f5hbJbcoQLKGEwN8ASS39ItDll9PZn7Ia
        abUGpQmR76R9/KFLQKSpfD2x+Cua90smpuoHQdypkDJpIgQKf6Om38Zy+FijuxVz
        46keSIQM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D81D2B477;
        Sun, 17 Nov 2019 17:16:54 -0500 (EST)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=VPUiBA0m2ubsMx0l7aIsQYg5aaKSCZSBG+kwg8bHAWQ=;
 b=CExqKagde+GJpexnUSG56A0r1F8TzfqHDB0GTfIf3urZfqyEOZXgRNtTAk4YJuvPk7QkTmFdd6Tf3mhAPl3jwOVntzOx3rakg/kbVQrDj7FBe2EI2WyEdfTjWHQLXQDjZE0RcLRJ5WaVp45t0Bd7DyyFgK7rzIhUDLda2+pmzEE=
Received: from Cheese (unknown [24.19.107.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C3772B476;
        Sun, 17 Nov 2019 17:16:53 -0500 (EST)
        (envelope-from tdavies@darkphysics.net)
Date:   Sun, 17 Nov 2019 14:16:47 -0800
From:   Travis Davies <tdavies@darkphysics.net>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] net: Fix comment block per style guide
Message-ID: <20191117221647.GA10337@Cheese>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Pobox-Relay-ID: F5D151CE-0987-11EA-A2C8-D1361DBA3BAF-64344220!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch places /* and */ on sepperate lines for a
multiline block comment, in order to keep code style
consistant with majority of blocks throughout the file.

This will prevent a checkpatch.pl warning:
'Block comments use a trailing */ on a separate line'

Signed-off-by: Travis Davies <tdavies@darkphysics.net>

---
 include/linux/netdevice.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c20f190b4c18..a2605e043fa2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -95,9 +95,11 @@ void netdev_set_default_ethtool_ops(struct net_device *dev,
 #define NET_XMIT_CN		0x02	/* congestion notification	*/
 #define NET_XMIT_MASK		0x0f	/* qdisc flags in net/sch_generic.h */
 
-/* NET_XMIT_CN is special. It does not guarantee that this packet is lost. It
+/*
+ * NET_XMIT_CN is special. It does not guarantee that this packet is lost. It
  * indicates that the device will soon be dropping packets, or already drops
- * some packets of the same priority; prompting us to send less aggressively. */
+ * some packets of the same priority; prompting us to send less aggressively.
+ */
 #define net_xmit_eval(e)	((e) == NET_XMIT_CN ? 0 : (e))
 #define net_xmit_errno(e)	((e) != NET_XMIT_CN ? -ENOBUFS : 0)
 
-- 
2.21.0

