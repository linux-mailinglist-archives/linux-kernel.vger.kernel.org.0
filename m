Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B4A19A015
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 22:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgCaUrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 16:47:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55499 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbgCaUrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:47:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id r16so4076478wmg.5;
        Tue, 31 Mar 2020 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URzAYQUInQifDn7ykYRco8lV5cECUKCgwVjuJFBTBJc=;
        b=C5sJkZiv/+qAiUzkr++MnslstGhtqgA8eFjGC6JV0RnZoOt4HEQHIuDeVc6QgXw3kg
         Fd5psALOWd485Giuce77ekmBMxDgBZ+vkj9bTvofeSmioQn/tH+acq+5nxpyS1t+xuQZ
         QlN5Ay2EYLd5h3RXwNrViHsI7FMXiT91VZ6yhml/I3eb38FSS2DlaSn/yk50VBf6AL2R
         Vtly6FeqULoGHQ9CH+/65qY1AC8GLDkA5pMcbxRJ8kiGuU8tVawCYSiTsoazLzL9sZO+
         liTmd4I1+TuKmnBHEa38CzfN+oXvRIiNOjVlBgtL/I6fZd9qyHJR3xfN7Kf2yriPG2Kf
         JcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URzAYQUInQifDn7ykYRco8lV5cECUKCgwVjuJFBTBJc=;
        b=r/dIVq15biZX0eQZrfeHfi17sgWZmQkEVEDLgN8XlG1yT2nSu4iGZaktgD+Se38iBS
         WmiiuwZ378m42TwxVDCCc/mq1F/9CNvZSYtHuxHnxzjoLE+j5YmvxIfkyrtxk/RPhg7N
         oIwyqrCdRUAuZoWsgO/NAIq6Vb2I94PwS1ufjpCwhtzKzyr7glEuROmq0AEhDDBWQazn
         JGbwgbAlITVD9mlZZMtHOePDYQMxrs2oB+CrpsJsaqYQ4cAjt+OBcjmVGObg0giLUmqA
         BflU0LhuNugU3O4vMmGCLdvdtTRtleSHcP/GQNfps00GplmA50/8jqxklCbe8n1znLcc
         Bh6w==
X-Gm-Message-State: AGi0PubihG3Fqi7EJqul0uwi71+2+ZapoDAX2pVkOEI8qUk6Zg0lH8DT
        pKgU0jS8DsYLJ6XSBVdVEKGzwR+Hb1fw
X-Google-Smtp-Source: APiQypJltWeqKmccBiLrWtnDBzINSMJjskqeHsMfyoMohcvWUBJgAgGgNKtIMeE7+YzGaYEoNTpeyg==
X-Received: by 2002:a1c:7d83:: with SMTP id y125mr718304wmc.21.1585687637795;
        Tue, 31 Mar 2020 13:47:17 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id o9sm28335491wrx.48.2020.03.31.13.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:47:17 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS)
Subject: [PATCH 7/7] tty: serial_core: Add missing annotation for _unlock_and_check_sysrq()
Date:   Tue, 31 Mar 2020 21:46:43 +0100
Message-Id: <20200331204643.11262-8-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331204643.11262-1-jbi.octave@gmail.com>
References: <0/7>
 <20200331204643.11262-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at _unlock_and_check_sysrq()

warning: context imbalance in uart_unlock_and_check_sysrq()
	- unexpected unlock

The root cause is the missing annotation at _unlock_and_check_sysrq()
Add the missing __releases(&port->lock) annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/tty/serial/serial_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 76e506ee335c..32f93f03efce 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3121,6 +3121,7 @@ int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
 EXPORT_SYMBOL_GPL(uart_prepare_sysrq_char);
 
 void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
+	__releases(&port->lock)
 {
 	int sysrq_ch;
 
-- 
2.24.1

