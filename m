Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE24742DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 03:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbfGYBZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 21:25:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43079 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfGYBZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 21:25:19 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so93668942ios.10;
        Wed, 24 Jul 2019 18:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eS818rhIBK7ubAziwLWgLj+2ZiumjMha54cYbp9Jr3A=;
        b=Hmpr70lvHA49jQoCF1u7GDuhGYhxa3P+R6pW9b0/x+ywkzfFwvTpk7M+F2/NgktyP4
         a3wohKoahGYEwVXpLPJZ8AcnYWAvY5IZqaA/cSGpFc6eJF4/lnF88hCE/S/TFQJbZa5B
         J3pIojX27rKC+kZlvO6Rn3rNJwxtzqy1aJO4lQg1MSkxxhobN7sXnjKaDFE+Eb2UiSmc
         BSBZf89RqnA6xaGqj9itSgz2N+g3Cx72+8BLajVS6M5qq8RuP3xVCOC7IZUNGFAjTmke
         c6KKVtI34zeyLvCyKzXdiA4OaAl9WKAjEdlIOBUeOehOb+i/xvpPh3Qf5bawSkmFf+mJ
         oNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eS818rhIBK7ubAziwLWgLj+2ZiumjMha54cYbp9Jr3A=;
        b=t7KZ1ng88LHRU37hzcKV7iiiJvwo3+y4IZXoOsuxkB3faemsqbvwLTiFlq7NLm6q4C
         /lZ06YOVO4OJyN1GzdWXSvmE7yZkrBoe0NfMM0DMu+GmCDeNdsW4y8vdIZ7zWZ4hyc6B
         sfkGYyJkzp1wnJnMWSIZCLNOs1o9RSHY/Ygeh5EwbBxGzd75C2QEnE9+V0NGGXeERc0C
         wAEnVDH4Kxj2rdpH1gHav06IhqhpS0mIVi6klZjHSr2q14cLQA48NlWAhBsdI/k9k1SP
         JMf4fgE46G8bWf+rrMXdPJXov4eNhdVfwcbHrq3XyeE4lW+pm6Q1pkST8x5kTbj+G3lc
         FUAQ==
X-Gm-Message-State: APjAAAUX1xEA9NYd3u94c8+qCfcaXFrWsdpPcma7qm0t/mZxuCaCvJgz
        2ThFWPQl8DFXEirNAydAfJk=
X-Google-Smtp-Source: APXvYqzvIu84h9LaMmZsWI4NsvNtPJGAuNf6pa+YMQqxk8pY+sRM2PyopYu6ZCW55SB1F1wD9ER/1g==
X-Received: by 2002:a5d:85c3:: with SMTP id e3mr40637257ios.265.1564017918910;
        Wed, 24 Jul 2019 18:25:18 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id u17sm45222173iob.57.2019.07.24.18.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 18:25:18 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        secalert@redhat.com, Navid Emamdoost <navid.emamdoost@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pata_ali: check the pci_get_device failure
Date:   Wed, 24 Jul 2019 20:25:06 -0500
Message-Id: <20190725012506.17831-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_get_device may fail and return NULL. This eventually will be
dereferenced in __pci_register_driver. So null check is necessary.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/ata/pata_ali.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 0b122f903b8a..47d9bec1f2e2 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -627,6 +627,8 @@ static int __init ali_init(void)
 {
 	int ret;
 	ali_isa_bridge = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
+	if (!ali_isa_bridge)
+		return -EINVAL;
 
 	ret = pci_register_driver(&ali_pci_driver);
 	if (ret < 0)
-- 
2.17.1

