Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C140913B0AE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 18:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgANRTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 12:19:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40064 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgANRTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:19:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id q8so6883867pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 09:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hq/EvgiMsTwoOsHfLL6j/V5911tAUEbQwTvWzcMkXl4=;
        b=Vjx3E4JwkKqeNef514E2ovt3+pcGt0kgEQ2W5bbWBdVQnRwAEXmmROtG5wMEX8qGaJ
         OAcGsk/n6T0N+lr8edoCWdlX7fU2cDxx2agWzou93FwA4WvcmvqIXNY+CIFMPttVakmp
         E3RL/FnLpgQ+zvA0ycAW2ybiZ3ScTlfsJ8RjpvhmPVBoT7zJQel5X6dCgYDtsgpryKa6
         FC2jceLuGy3UlXNaQAezZ26/sudduCi3K932H9PkeugRA7FWOiJEMKmfjwdi4WUSvple
         U3Goq3AbiBs2mOSV6a+wGt45TFoXEFuadEYX3yxQCb/SNIQ+vTDlp3bqvJjS/LCSWTLx
         6YkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hq/EvgiMsTwoOsHfLL6j/V5911tAUEbQwTvWzcMkXl4=;
        b=cesEhn1XDdOdQ6YmgIpXouhSiNLYC7wT6ZI+CfdzIkynxiaq9U8F6pnA9B2ukE4I1k
         5u+2QvaKXqampOMydPi4wamRz054lHpwcp7cAmsg5BPnmgl4mXEP1ZK9SM6KMq0NZKiI
         0PICYY/veUtxFSKl2azenamrFC2ggpxWXJZEZ/i5I21G6OH3QFHgie9k2KQqpOVWVoRc
         C3Ai03i4Unz0lRDB4OPtzSP0Ww/41guK+lhSgG9F3ZxrTk9gXQKn9AlFfo7onls4tt4S
         wDXTW6kWSJ2L6FLGldNLKJ5o8wcqbTbdzMTNpPRIsu3I3BNf0xNACCzpz7FO00eqPh1v
         07zg==
X-Gm-Message-State: APjAAAU5eyHXHjZvL4/TbVLJCJj/LU5ckgLANxVsKSMhV/+OAoXd+c4s
        FUAXDx3F44ZztnnqdSrXSxQlw9gC9gA=
X-Google-Smtp-Source: APXvYqw4cQ24d4qqEj9mv//Q3oGEq2B5gjJCmq88gtdREVehBYurFyG1jZyK0xA8XfyHNIbJT7usmw==
X-Received: by 2002:a63:6fca:: with SMTP id k193mr29045745pgc.416.1579022363280;
        Tue, 14 Jan 2020 09:19:23 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m128sm18965687pfm.183.2020.01.14.09.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 09:19:22 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCHv2-next 0/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
Date:   Tue, 14 Jan 2020 17:19:09 +0000
Message-Id: <20200114171912.261787-1-dima@arista.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Magic sysrq has proven for Arista usecases to be useful for debugging issues in field, over serial line when the switch is in such bad state
that it can't accept network connections anymore.

Unfortunately, having sysrq always enabled doesn't work for some
embedded boards that tend to generate garbage on serial line (including
BREAKs). Since commit 732dbf3a6104 ("serial: do not accept sysrq
characters via serial port"), it's possible to keep sysrq enabled, but
over serial line.

Add a way to enable sysrq on a uart, where currently it can be
constantly either on or off (CONFIG_MAGIC_SYSRQ_SERIAL).
While doing so, cleanup __sysrq_enabled and serial_core header file.

Sending against -next tree as it's based on removing SUPPORT_SYSRQ
ifdeffery [1].

Changes since v1 [2]:
- Fix typo in pr_info() message (noticed by Randy Dunlap, thanks)
- Add SYSRQ_TIMEOUT define for timeout after BREAK and separate removing
  @unused member of uart_port into cleanup patch (by Greg's review, thanks)
- Add const qualifier, make uart_try_toggle_sysrq() bool function
  (Joe Perches, thanks)
- Fix !CONFIG_SYSRQ and CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
  build failures (kudos to kbuild test robot)

[1]: https://lkml.kernel.org/r/20191213000657.931618-1-dima@arista.com
[2]: https://lkml.kernel.org/r/20200109215444.95995-1-dima@arista.com

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Iurii Zaikin <yzaikin@google.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Joe Perches <joe@perches.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Vasiliy Khoruzhick <vasilykh@arista.com>
Cc: linux-serial@vger.kernel.org

Thanks,
             Dmitry

Dmitry Safonov (3):
  sysctl/sysrq: Remove __sysrq_enabled copy
  serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
  serial_core: Remove unused member in uart_port

 drivers/tty/serial/serial_core.c | 75 +++++++++++++++++++++++++++++---
 drivers/tty/sysrq.c              |  7 +++
 include/linux/serial_core.h      |  2 +-
 include/linux/sysrq.h            |  7 +++
 kernel/sysctl.c                  | 41 +++++++++--------
 lib/Kconfig.debug                |  8 ++++
 6 files changed, 113 insertions(+), 27 deletions(-)

-- 
2.24.1

