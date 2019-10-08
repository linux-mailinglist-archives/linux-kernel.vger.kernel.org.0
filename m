Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB4CBCF554
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 10:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfJHIyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 04:54:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728866AbfJHIyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:54:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 356D310CC1FD;
        Tue,  8 Oct 2019 08:54:24 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-197.ams2.redhat.com [10.36.117.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9193619C68;
        Tue,  8 Oct 2019 08:54:22 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 0/1] s390/purgatory: Make sure we fail the build if purgatory has missing symbols
Date:   Tue,  8 Oct 2019 10:54:20 +0200
Message-Id: <20191008085421.11011-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Tue, 08 Oct 2019 08:54:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi s390 maintainers,

Here is a second RFC version of my patch for $subject, mirroring the
changes in v2 of the x86 patch.

As last time this patch is completely UNTESTED.

Changes in v2:
- Using 2 if_changed lines under a single rule does not work, then
  1 of the 2 will always execute each build.
  Instead add a new (unused) purgatory.chk intermediate which gets
  linked from purgatory.ro without -r to do the missing symbols check
- This also fixes the check generating an a.out file (oops)

Relevant part of the cover letter from v1:

In 5.4-rc1 the 2 different sha256 implementations for the purgatory resp.
for crypto/sha256_generic.c have been consolidated into 1 single shared
implementation under lib/crypto/sha256.c .

At least on x86 this was causing silent corruption of the purgatory due
to a missing memzero_explicit symbol in the purgatory string.c/.o file.

With the x86 equivalent of this patch applied a x86 build of 5.4-rc1 now
correctly fails:

  CHK     arch/x86/purgatory/purgatory.ro
ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'
make[2]: *** [arch/x86/purgatory/Makefile:72:
    arch/x86/purgatory/kexec-purgatory.c] Error 1
make[1]: *** [scripts/Makefile.build:509: arch/x86/purgatory] Error 2
make: *** [Makefile:1650: arch/x86] Error 2

It would be great if the s390 maintainers can test this equivalent patch
on s390.

As for fixing the missing memzero_explicit symbol, we are currently
discussing making memzero_explicit a static inline wrapper of memset
in string.h, so that we do not need to implement it in multiple places.

This discussion is Cc-ed to the generic linux-kernel@vger.kernel.org list,
it is happening in the
"[PATCH v2 5.4 regression fix] x86/boot: Provide memzero_explicit" thread.

Regards,

Hans



