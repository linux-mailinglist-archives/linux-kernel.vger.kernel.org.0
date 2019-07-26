Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E655D75CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 04:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfGZCLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 22:11:51 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:63696 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGZCLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 22:11:45 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6Q2B03i020523;
        Fri, 26 Jul 2019 11:11:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6Q2B03i020523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564107061;
        bh=VSZ+nDcthk8Avn3CrAdYK5sPhL3K6KWdOgql9HZ9Oxg=;
        h=From:To:Cc:Subject:Date:From;
        b=lWDQdMTMT9Mjc1iKvtWCSkPqm91sIfgPzmpucnZqGeMzR6W4dLHnY61YKH/Xxct6j
         3i8+cIoVRqkBCtoQn78CllWT6Te1kLN7iObMqW69Qysc+nUukUlmjmGK4oN/v3L9VR
         8LQVyGrI1AB8R2Fh5GC+dfart6xHfG50BQ7MC351/PWOc0Nye4lRfLvbtnGrRkENcm
         z7zbXMqjyQ9qf57FYk0iMowozkr36yvCVFNak46T7mwYcTPVGL23lagNuaJdHrUbUW
         Ps98HgDjfoRnwG8eGyE5Qvd+CaLZoMUkkt1OvdJ4ENglAgL+aQW1sFwghuWg+YC/63
         6kNUDLOrB8gOA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dave Howells <dhowells@redhat.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 0/5] security: integrity: Makefile cleanups
Date:   Fri, 26 Jul 2019 11:10:53 +0900
Message-Id: <20190726021058.4212-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada (5):
  integrity: remove unneeded, broken attempt to add -fshort-wchar
  integrity: remove pointless subdir-$(CONFIG_...)
  integrity: use obj-y for non-modular objects
  IMA: use obj-y for non-modular objects
  EVM: use obj-y for non-modular objects

 security/integrity/Makefile     | 19 +++++++------------
 security/integrity/evm/Makefile |  6 ++----
 security/integrity/ima/Makefile |  8 +++-----
 3 files changed, 12 insertions(+), 21 deletions(-)

-- 
2.17.1

