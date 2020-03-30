Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57BF1197259
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 04:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgC3CT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 22:19:29 -0400
Received: from m12-12.163.com ([220.181.12.12]:39856 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbgC3CT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:19:29 -0400
X-Greylist: delayed 923 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Mar 2020 22:19:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=YLkRY
        spmaUn4AjagqkUkZTcLSwz0UO59vIe9hnXKdrw=; b=b8U+e1jb8DLxrjmg3TMWK
        KVON0oEb+0L5GQRr5SmTe6rnowWqyi4p+2wu/NamIHCjLdNK9Uj+p++LTJGRNxWH
        2MImBKoENyT14BPVTybqnp41KWgDCk+dZVnXNErP+CfSNaWFGJMc5xGDSf6yGRLv
        BEwyPxBunCu9JtiHr+4ogs=
Received: from localhost.localdomain (unknown [125.82.11.174])
        by smtp8 (Coremail) with SMTP id DMCowAB3e2fEUoFe5nNMBQ--.2270S4;
        Mon, 30 Mar 2020 10:00:48 +0800 (CST)
From:   Hu Haowen <xianfengting221@163.com>
To:     linux@dominikbrodowski.net
Cc:     jeyu@kernel.org, maennich@google.com, axboe@kernel.dk,
        nborisov@suse.com, josef@toxicpanda.com, stfrench@microsoft.com,
        chris@chris-wilson.co.uk, wqu@suse.com, xiubli@redhat.com,
        airlied@redhat.com, xianfengting221@163.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: remove some unused space characters
Date:   Mon, 30 Mar 2020 10:00:24 +0800
Message-Id: <20200330020024.8174-1-xianfengting221@163.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAB3e2fEUoFe5nNMBQ--.2270S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw15Zr1fuw1DtFyrCr48JFb_yoW8JFykpF
        43Cw18AFs3ZFWUXa15Ar48ur1Sqw1ktayUtryak3y8JFyjk3srKay8u3W5ZFZ8CFZFyF1U
        Kr45A34UuF4DXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UDb15UUUUU=
X-Originating-IP: [125.82.11.174]
X-CM-SenderInfo: h0ld0wxhqj3xtqjsjii6rwjhhfrp/1tbiWwb2AFSImCKWagAAsx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few space characters I found by chance. I think they are
redundant, so I removed them.

Signed-off-by: Hu Haowen <xianfengting221@163.com>
---
 drivers/pcmcia/sa1100_simpad.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/sa1100_simpad.c b/drivers/pcmcia/sa1100_simpad.c
index e2e8729afd9d..784ada5b8c4f 100644
--- a/drivers/pcmcia/sa1100_simpad.c
+++ b/drivers/pcmcia/sa1100_simpad.c
@@ -14,7 +14,7 @@
 #include <asm/mach-types.h>
 #include <mach/simpad.h>
 #include "sa1100_generic.h"
- 
+
 static int simpad_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 
@@ -66,7 +66,7 @@ simpad_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 		simpad_clear_cs3_bit(VCC_3V_EN|VCC_5V_EN|EN0|EN1);
 		break;
 
-	case 33:  
+	case 33:
 		simpad_clear_cs3_bit(VCC_3V_EN|EN1);
 		simpad_set_cs3_bit(VCC_5V_EN|EN0);
 		break;
@@ -95,7 +95,7 @@ static void simpad_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
 	simpad_set_cs3_bit(PCMCIA_RESET);
 }
 
-static struct pcmcia_low_level simpad_pcmcia_ops = { 
+static struct pcmcia_low_level simpad_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 	.hw_init		= simpad_pcmcia_hw_init,
 	.hw_shutdown		= simpad_pcmcia_hw_shutdown,
-- 
2.20.1


