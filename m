Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F221162F3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2019 17:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfLHQPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 11:15:37 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49520 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726475AbfLHQPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 11:15:37 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [131.188.30.136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 0A31A241632;
        Sun,  8 Dec 2019 17:07:09 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id E6556C20BC6; Sun,  8 Dec 2019 17:07:08 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panze@fau.de>
Subject: [PATCH 00/12] PCMCIA: Fix style issues in i82092.c
Date:   Sun,  8 Dec 2019 17:06:02 +0100
Message-Id: <20191208160613.19904-1-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series removes all style issues detected
by checkpatch.pl.

Simon Geis (12):
  PCMCIA: use dev_err/dev_info instead of printk
  PCMCIA: remove trailing whitespaces
  PCMCIA: add/remove wrong spaces
  PCMCIA: Remove spaces before tabs
  PCMCIA: remove braces around single statement blocks
  PCMCIA: insert blank line after declarations
  PCMCIA: change incorrect code indentation
  PCMCIA: move assignment out of if condition
  PCMCIA: shorten the lines with over 80 characters
  PCMCIA: include <linux/io.h> instead of <asm/io.h>
  PCMCIA: use pr_debug instead of enter/leave
  PCMCIA: remove ifdef 0 block

 drivers/pcmcia/i82092.c   | 714 +++++++++++++++++++++-----------------
 drivers/pcmcia/i82092aa.h |  11 -
 2 files changed, 396 insertions(+), 329 deletions(-)

-- 
2.20.1

