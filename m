Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F88711E4F6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 14:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfLMNyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 08:54:53 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:43638 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727335AbfLMNyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:54:52 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 8A1D72417DD;
        Fri, 13 Dec 2019 14:54:49 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 72116C20BC7; Fri, 13 Dec 2019 14:54:49 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH v3 00/10] PCMCIA/i82092: Fix style issues in i82092.c
Date:   Fri, 13 Dec 2019 14:53:02 +0100
Message-Id: <20191213135311.9111-1-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series removes all style issues in i82092.c
detected by checkpatch.pl.

Version 3 changes:
- patch 1: remove 'i82092aa' out of dev_<level> output
- patch 7: merge comments
- patch 9: remove enter/leave entirely
- changes in commit descriptions

Version 2 changes:
- merge whitespace patches into a single patch
- convert ?-operator to if statement (patch 7)
- rewrite commit messages
- add i82092 to subject
- modify enter/leave macro

Simon Geis (10):
  PCMCIA/i82092: use dev_<level> instead of printk
  PCMCIA/i82092: add/remove spaces to improve readability
  PCMCIA/i82092: remove braces around single statement blocks
  PCMCIA/i82092: insert blank line after declarations
  PCMCIA/i82092: change code indentation
  PCMCIA/i82092: move assignment out of if condition
  PCMCIA/i82092: shorten the lines with over 80 characters
  PCMCIA/i82092: include <linux/io.h> instead of <asm/io.h>
  PCMCIA/i82092: delete enter/leave macro
  PCMCIA/i82092: remove #if 0 block

 drivers/pcmcia/i82092.c   | 639 ++++++++++++++++++--------------------
 drivers/pcmcia/i82092aa.h |  11 -
 2 files changed, 307 insertions(+), 343 deletions(-)

-- 
2.20.1

