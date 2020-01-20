Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37CC2143157
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 19:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgATSOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 13:14:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53919 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726982AbgATSO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579544066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lg/ZhzUvCBxZUtp2Z0dP5Q+woJPKdQPaDnNC1ktU+j0=;
        b=U0R1XvBh1vVCmrZo1GBJ/DsoMLzBhBC+e1Uu6hTx33oWQ55Wp9lqORgFNtg+39JXYkmR0f
        CFKZXm+Vt3DUmLDns5p4/x6K+pXsoNwH6RMNtPQiZScD81CjRDJ3cmaQP/Kqsd2fB7kcpP
        oFFNBm9jtxshJhzjEHa+TPMGZwaqnYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-NIu47y58NIiheq6PSNufIQ-1; Mon, 20 Jan 2020 13:14:22 -0500
X-MC-Unique: NIu47y58NIiheq6PSNufIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37B8918A8C81;
        Mon, 20 Jan 2020 18:14:21 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-19.rdu2.redhat.com [10.10.125.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B30D31001B30;
        Mon, 20 Jan 2020 18:14:20 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/3] objtool: minor fixes
Date:   Mon, 20 Jan 2020 12:14:06 -0600
Message-Id: <cover.1579543924.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three minor fixes which help objtool integrate better with the kernel
build.

Josh Poimboeuf (1):
  objtool: Skip samples subdirectory

Olof Johansson (1):
  objtool: Silence build output

Shile Zhang (1):
  objtool: Fix ARCH=3Dx86_64 build error

 samples/Makefile            | 1 +
 tools/objtool/Makefile      | 6 +-----
 tools/objtool/sync-check.sh | 2 --
 3 files changed, 2 insertions(+), 7 deletions(-)

--=20
2.21.1

