Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 367F969C22
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 22:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732870AbfGOUB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 16:01:57 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:43773 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732546AbfGOUAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:42 -0400
Received: by mail-qt1-f202.google.com with SMTP id o11so7283417qtq.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+BVs4+IbUnzxqigablcI43G/OcpEsyLzvDMqSyBhvlI=;
        b=jgN+Hy5rzJRsBCdzAEzybx+UKxNAwDH+7UJAzEJ2Cej0p1BYdTOfvUb/mP4HbNphci
         wrI7yB5rVVj8A0KGE1Fb6LoYjo7Pbc9q5dzrpOD95LWQon1UmAeJE4nwUMagb5z8r8d3
         wJS0X52iwL8P8Dk14P9COut/Pc9XhvXqzQ+SyzWPSqAFqRoPJ0Eg5MTWcfS304S/WHfS
         iWIW3wBMWMj0oDP+DU/dD4dI2hPNlFGpu6neH8iTGqAP7t7Im0bNLKehHfrhvor/J0oZ
         Ymvh2xn8z+PugScxAa/rXUXqRxdwnHJ3iJQNEakHptBYqM/si+stCFQjrTP56XmKQOFA
         d2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+BVs4+IbUnzxqigablcI43G/OcpEsyLzvDMqSyBhvlI=;
        b=guZxX3YvcLMWpjynYGv8hAmwdbJN1H50410IXGWUmpnFDViRuuRLac6r1tsTmrwnec
         b4IN1CXKNkXNfhX3SFs457E/8/e2NEekEs3NsqXNGfdF9MVugnvzjS4TCElG+lq17C0E
         e2oxX0V2IKvI3lE7kkBv4hCaXVg+SXqO1Obmrjn5DFEg38UrI9r6+9jmTsSQc46xH7IZ
         jaTwl7G8zdwX8dxdBVQALlVhg37kMh7XU1jZfce9cdPg/MiTNSERKNYAodw1+SX8CiPo
         8h46kNqLKy1s4a156t7b7VLQJL29wYKQbMh2GVPN24KTca+v1dij7b5VxOQdtZmSdGze
         TUFQ==
X-Gm-Message-State: APjAAAXyYcclKnbN1dKCteesi0ejzD1/dz67Yi7deGaddifqeBVuFR66
        9NsfOwGw0Ho1dESB96Ik4qcBg97G13WCELfMnG6ziA==
X-Google-Smtp-Source: APXvYqz5vvHyqfroaIhAkEducyiSejDIwwb5RxaoLydNSP26fz0XARD+t+kfcq7TPA3VrlndqDtTAjK4bu1ie1cI3VCE7g==
X-Received: by 2002:a05:620a:1286:: with SMTP id w6mr17687717qki.219.1563220841099;
 Mon, 15 Jul 2019 13:00:41 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:35 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 18/29] Lock down TIOCSSERIAL
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Lock down TIOCSSERIAL as that can be used to change the ioport and irq
settings on a serial port.  This only appears to be an issue for the serial
drivers that use the core serial code.  All other drivers seem to either
ignore attempts to change port/irq or give an error.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/serial_core.c | 5 +++++
 include/linux/security.h         | 1 +
 security/lockdown/lockdown.c     | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4223cb496764..6e713be1d4e9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -22,6 +22,7 @@
 #include <linux/serial_core.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/security.h>
 
 #include <linux/irq.h>
 #include <linux/uaccess.h>
@@ -862,6 +863,10 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 		goto check_and_exit;
 	}
 
+	retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
+	if (retval && (change_irq || change_port))
+		goto exit;
+
 	/*
 	 * Ask the low level driver to verify the settings.
 	 */
diff --git a/include/linux/security.h b/include/linux/security.h
index 3773ad09b831..8f7048395114 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -112,6 +112,7 @@ enum lockdown_reason {
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_PCMCIA_CIS,
+	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 96106c2870ef..07a49667f234 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -27,6 +27,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
+	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

