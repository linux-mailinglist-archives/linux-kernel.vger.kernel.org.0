Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00521171821
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 14:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgB0NCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 08:02:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:37262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgB0NCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:02:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7626BB308;
        Thu, 27 Feb 2020 13:02:21 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/3] lib/test_printf: Clean up basic pointer testing
Date:   Thu, 27 Feb 2020 14:01:20 +0100
Message-Id: <20200227130123.32442-1-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The discussion about hashing NULL pointer value[1] uncovered that
the basic tests of pointer formatting do not follow the original
structure and cause confusion.

I feel responsible for it and here is a proposed clean up.

[1] https://lkml.kernel.org/r/bcfb2f94-e7a8-0860-86e3-9fc866d98742@rasmusvillemoes.dk

Petr Mladek (3):
  lib/test_printf: Clean up test of hashed pointers
  lib/test_printf: Fix structure of basic pointer tests
  lib/test_printf: Clean up invalid pointer value testing

 lib/test_printf.c | 170 ++++++++++++++++++++----------------------------------
 1 file changed, 64 insertions(+), 106 deletions(-)

-- 
2.16.4

