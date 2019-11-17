Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E6CFFB6D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 19:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfKQS5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 13:57:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64844 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfKQS5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 13:57:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9500B8A0E3;
        Sun, 17 Nov 2019 13:57:31 -0500 (EST)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=4su
        KPxAfpoIaml4yNy/yiCovNBU=; b=YAzPfXC8pi47HKeejQTopMRRfYQa4ZQAunf
        t4x1r60eTEof7suaPKoeKwFt73UjJ1zsLP2WFoN2cBMHZw0lH0OZjrPhPTnZVRVh
        a1zvoo1HqzMoocCNRuOIGoFD8aN5frZNVG8gfwWjSZTR/Rr7+awGTGYGw6iC2L3d
        x7MU/5V0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B2B08A0E2;
        Sun, 17 Nov 2019 13:57:31 -0500 (EST)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=eDqP58Q886By0+IKivo5GpqSAzhdVL6l00Pe07gV1+g=;
 b=tjz6Iy4wK1MjUud8KzEXmdKol3DgGEJTYuTWEQKtpbrdjRc1zlKJrEbtPAf4IaPnY5//HSXbm/IBOyFeToUy2LnOoXo9A25URmRD8/pmelqbIiEBfk2zweVAyRrbsvOMKSj2EewGP81nLVb8gMAoc5DTnSuumOJSDaFkLOqySlU=
Received: from Cheese (unknown [24.19.107.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D75CC8A0DD;
        Sun, 17 Nov 2019 13:57:28 -0500 (EST)
        (envelope-from tdavies@darkphysics.net)
Date:   Sun, 17 Nov 2019 10:57:22 -0800
From:   Travis Davies <tdavies@darkphysics.net>
To:     akpm@linux-foundation.org, davem@davemloft.net,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] /linux/netdevice.h: Fix checkpatch.pl comment warning
Message-ID: <20191117185722.GA4637@Cheese>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Pobox-Relay-ID: 1A3C60D8-096C-11EA-AFE7-B0405B776F7B-64344220!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch Warning:
'...netdevice.h:100: WARNING: Block comments use a trailing */ on a separate line'

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

