Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D38267418
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 19:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfGLRVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 13:21:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:57916 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbfGLRVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:21:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 519E2AF51;
        Fri, 12 Jul 2019 17:21:11 +0000 (UTC)
From:   Petr Tesarik <ptesarik@suse.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Petr Tesarik <ptesarik@suse.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add uncompressed Linux banner to s390 bzImage
Date:   Fri, 12 Jul 2019 19:20:59 +0200
Message-Id: <cover.1562950641.git.ptesarik@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches make it easy to determine the kernel version from a
compressed binary by scanning for the Linux banner string in the
uncompressed portion of bzImage.

Petr Tesarik (2):
  init: Separate banner from init_uts_ns
  s390: add Linux banner to the compressed image

 arch/s390/boot/compressed/Makefile |  1 +
 init/Makefile                      |  2 +-
 init/banner.c                      | 21 +++++++++++++++++++++
 init/version.c                     | 10 ----------
 4 files changed, 23 insertions(+), 11 deletions(-)
 create mode 100644 init/banner.c

-- 
2.16.4

