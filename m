Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E22816AE93
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 19:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBXSVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 13:21:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbgBXSVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:21:52 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD2F320838;
        Mon, 24 Feb 2020 18:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582568511;
        bh=3uuYpt3nQYMeadAa82+/i1C5QW/D3Q/Z/LNaGFGi5G4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Smojl4eTOIb7UDz5NZf1+LzXNL6WQvqt0YuKyd0mlOyEGFnO8f4Iv3Si1kRPjnuik
         XTlROfhXa/y2AcbTHeXtoXXscydlfbaKdPqzb8AwJQyISkh9BVDqTlXVRXvdgjPpnI
         6lsRTp5n9wzycsGlsfvigYSrpV+P50UNeCMxGAJU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 0/2] tty: fix bugs in compat TIOCGSERIAL
Date:   Mon, 24 Feb 2020 10:20:42 -0800
Message-Id: <20200224182044.234553-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200224181532.GA109047@gmail.com>
References: <20200224181532.GA109047@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two bugs in the compat implementation of TIOCGSERIAL, both of which
were introduced by the compat ioctl refactoring in Linux v4.20.

Eric Biggers (2):
  tty: fix compat TIOCGSERIAL leaking uninitialized memory
  tty: fix compat TIOCGSERIAL checking wrong function ptr

 drivers/tty/tty_io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.0.265.gbab2e86ba0-goog

