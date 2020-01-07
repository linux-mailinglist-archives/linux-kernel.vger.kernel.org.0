Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E78131CF6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 02:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgAGBDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 20:03:18 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55969 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgAGBDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 20:03:17 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so8253973pjz.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 17:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UgFg1/ut7QmIumbn1uU+fVt69KUfyjkEA95WzaJYXK0=;
        b=FQpBpE9ygbqx/N8KjD17p2R+ZIlx4O9I5XTpKq0lvNLP65RPv2ZCdaQ1WY6W6w07Pz
         nPrQ0zPZ0iVq7G0F8XO872IPKa0MfnTdhNi1IaArRzoYJfHVAMSEmOZ91DDyh5xo318P
         2dLr+WXhYDkmFbCwf/AzPGp1ByLJxT1zaKcTbJthK+8S1t++o4k7VtmJoBYFmsFhlJbw
         12KGzBd6bagKaeeYhJ/NMOVhZ7vQXkXeyL0YeYKD/iCvkjEwWf2HPeFwr8HeZS2Pj6GY
         Nzphvqy3kqCXveS9kb+/hpQKn45t2q4NaJlZ+/5HyAvhfeb8NuzV9NnevgwvRdUR9ssC
         ed8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UgFg1/ut7QmIumbn1uU+fVt69KUfyjkEA95WzaJYXK0=;
        b=A5IfNWkpQKnbFd1vu9vCBRMz0dLVEJSuEHtBLEBUrEbc6Cd5APf3zeuJFZomVO5oxt
         INCbGAuxlq8a1JMj+82N5INR9flk5ZJP/p2QIxWq0gR4B6ZwOiXAM/CBNiQb7jkQApDU
         wMX9BuZ8vCmNMwLwBQZ6QIvJoFEYQBvG+8P1FcDyHmsf2wYbyNAeKxLG7CDh4UataiJF
         EiynAkY3cW73dmDOsxQhJqqjygGxHtXmOPdxC3NDAQdt3/aUZj0LFnySAwu42Il8HNYw
         5msy/C3rn+7BqCPEYXtV6eI+PsSfeC5UbWzrULBCYNqrajLJal0wgQF4OxeeFrvcYvYN
         C11Q==
X-Gm-Message-State: APjAAAX58VQ6027g9CNsZXoZp5OzvEsz3Rw9OSJsQizhbZkS5m3glMgH
        UdF2hMjKO2o/0TYUCIyR3BahlOC5HIM=
X-Google-Smtp-Source: APXvYqxJUhj7mmU7o7z8CZx/SlWy4uSKMEdT7kW4bx36vqKVdtainUKGfO1+HyhEMarbxgKqDeMAzQ==
X-Received: by 2002:a17:90a:8a8f:: with SMTP id x15mr46917582pjn.87.1578358996582;
        Mon, 06 Jan 2020 17:03:16 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id d21sm25361304pjs.25.2020.01.06.17.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 17:03:16 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH 1/2] tty: serial_core: Export uart_console_device so it can be used by modules
Date:   Tue,  7 Jan 2020 01:03:10 +0000
Message-Id: <20200107010311.58584-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support serial console w/ SERIAL_QCOM_GENI=m,
we need to export the uart_console_device() symbol so things
will build

Cc: Todd Kjos <tkjos@google.com>
Cc: Alistair Delva <adelva@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/tty/serial/serial_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7c2782785736..7b87c08f5bcb 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2603,6 +2603,7 @@ struct tty_driver *uart_console_device(struct console *co, int *index)
 	*index = co->index;
 	return p->tty_driver;
 }
+EXPORT_SYMBOL_GPL(uart_console_device);
 
 static ssize_t uart_get_attr_uartclk(struct device *dev,
 	struct device_attribute *attr, char *buf)
-- 
2.17.1

