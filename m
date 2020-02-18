Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBE4E161F99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 04:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgBRDmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 22:42:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41934 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726166AbgBRDmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 22:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581997326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tzy7lxjYbnUkHtCYHVDf/qTX7j4w0IobMZWxgRUZjx0=;
        b=E4bk1LPD5g4/XWDmMwYFvHUgQxv3q/iqcd67p+BPhOQK9tC5RJIN8eSuQpQaJPgUvAwTfl
        eb36booq0nVgT2Nf3+beuNZlDhxYWdsZcj1v5Lj72MXIA5RFvgpEf0CFALMIzGmvo5ncvN
        apa0SKPAgs+wsCc9kX+kA1tPfRUhWmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-PCeckORbNlqFQtuZFlVytw-1; Mon, 17 Feb 2020 22:42:04 -0500
X-MC-Unique: PCeckORbNlqFQtuZFlVytw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF102108442E;
        Tue, 18 Feb 2020 03:42:02 +0000 (UTC)
Received: from treble.redhat.com (ovpn-121-12.rdu2.redhat.com [10.10.121.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AED11001B3F;
        Tue, 18 Feb 2020 03:42:02 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 0/2] objtool: clang-related fixes
Date:   Mon, 17 Feb 2020 21:41:52 -0600
Message-Id: <cover.1581997059.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a couple of issues which were discovered after clang CI was broken
by 644592d32837 ("objtool: Fail the kernel build on fatal errors").

Josh Poimboeuf (2):
  objtool: Fix clang switch table edge case
  objtool: Improve call destination function detection

 tools/objtool/check.c | 38 +++++++++++++++++++++++++++-----------
 tools/objtool/elf.c   | 14 ++++++++++++--
 tools/objtool/elf.h   |  1 +
 3 files changed, 40 insertions(+), 13 deletions(-)

--=20
2.21.1

