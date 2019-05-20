Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF6222E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 10:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbfETIW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 04:22:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39827 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbfETIW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id e24so22523962edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mVMSkVkXVXoA7bd+CVw0neKzoieyYhVCa/oZdeVcz6s=;
        b=Sa5zP3JT5hyfGQAExSIWnPbCd2RrgT54fuBK2oWIXdhjEzKYlwkv2mj33KHHgR9Tb1
         OPZ84ScC4qk6uW/A2vVDIiq7WJFLyKaLezunk6D82VjXFVZkwLK6sw6PcT1GveLks2U6
         hhkRii8j3WVTGHSloOOpdQQ+9gDCXElisP1DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mVMSkVkXVXoA7bd+CVw0neKzoieyYhVCa/oZdeVcz6s=;
        b=mq6i55GTcJdtKDWqfsZ5VOjiQsMZIKc8HeXfY/lSCD69zSIJ+Wez3Jc1meJnLElF1i
         jI0SL5Rj1Pr/Nu9SseuNDebOTNo8rsT0tjYtXMfYpEPO3Ith+dXSJEBImtujTrc0SqJy
         sckMLSy8hoQsLZ/PSsvd/Qn+DZ0yY44DifXr6aSJEfrgYFX/oKldGxTmosjTKcyir86n
         s7SH0ECaF4IxSfso7yTTkPXpu2Xtk0xjTA3zV6CjGrJ1EVvtcpvT2USF7sPo4cRedhdD
         fFow32NYQhvBOQPm/BT4suNeSIGxZp19fDkOKiJ6rNCjQhFz++aFNy26Si0DnjhNSRRY
         sNbw==
X-Gm-Message-State: APjAAAVSl8Yrh+gXEqIviFk+sDzKQF0WP/TnuOrz10KsjHeU4m4BEjMH
        h8mC3lkPZvw5AVEopUhXoolrQA==
X-Google-Smtp-Source: APXvYqzgHYK7jVIgS4gfI7+Dv9xMQJnk2fhjsWys9x/6q7TmowQ0BrrlSYyon+rIUQknLGOfs4YtBw==
X-Received: by 2002:a50:ba4f:: with SMTP id 15mr18344027eds.210.1558340546096;
        Mon, 20 May 2019 01:22:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:25 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Martin Hostettler <textshell@uchuujin.de>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 03/33] vt: might_sleep() annotation for do_blank_screen
Date:   Mon, 20 May 2019 10:21:46 +0200
Message-Id: <20190520082216.26273-4-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For symmetry reasons with do_unblank_screen, except without the
oops_in_progress special case.

Just a drive-by annotation while I'm trying to untangle the fbcon vs.
fbdev screen blank/unblank maze.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Adam Borowski <kilobyte@angband.pl>
Cc: Martin Hostettler <textshell@uchuujin.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/tty/vt/vt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 650c66886c80..8b4b3a49ec33 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4158,6 +4158,8 @@ void do_blank_screen(int entering_gfx)
 	struct vc_data *vc = vc_cons[fg_console].d;
 	int i;
 
+	might_sleep();
+
 	WARN_CONSOLE_UNLOCKED();
 
 	if (console_blanked) {
-- 
2.20.1

