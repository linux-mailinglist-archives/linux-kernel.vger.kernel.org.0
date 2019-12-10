Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F10D1186BB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 12:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLJLn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 06:43:56 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:38896 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726957AbfLJLnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:43:55 -0500
Received: from faui04g.informatik.uni-erlangen.de (faui04g.informatik.uni-erlangen.de [131.188.30.137])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 2270A241838;
        Tue, 10 Dec 2019 12:43:54 +0100 (CET)
Received: by faui04g.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id C8BE1843353; Tue, 10 Dec 2019 12:43:53 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH v2 00/10] PCMCIA/i82092: Fix style issues in i82092.c
Date:   Tue, 10 Dec 2019 12:43:24 +0100
Message-Id: <20191210114333.12239-1-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series removes all style issues in i82092.c
detected by checkpatch.pl.

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
  PCMCIA/i82092: improve enter/leave macro
  PCMCIA/i82092: remove ifdef 0 block

 drivers/pcmcia/i82092.c   | 685 ++++++++++++++++++++------------------
 drivers/pcmcia/i82092aa.h |  16 +-
 2 files changed, 377 insertions(+), 324 deletions(-)

-- 
2.20.1

