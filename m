Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF9D14A7E8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 17:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgA0QRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 11:17:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42010 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729505AbgA0QRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580141826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NPHIDBHIHn19+j0f45CcKBBFeX5G7EU5YQsaBeUB+i0=;
        b=Dyo2Lf2UiPxR4M8H4+JOJNz2sv2s2kQFtnWsrJ0rklj2Uv63jFTkny2KKyc1ve5uXp28ay
        Jdc6xm3pM7O/R3LNJUMWH1pvQnGUGAEePCocx9SXjgj8UwmUCHhAhqe4hqthxelf548CcV
        FybNb1hQxZth8qLtsClpgkkn6sca2Cg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-q64UPdiXOzamvKKWjkGniw-1; Mon, 27 Jan 2020 11:17:03 -0500
X-MC-Unique: q64UPdiXOzamvKKWjkGniw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2E85108597A;
        Mon, 27 Jan 2020 16:17:02 +0000 (UTC)
Received: from steredhat.redhat.com (unknown [10.43.2.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C84288832;
        Mon, 27 Jan 2020 16:17:01 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH liburing 0/1] test: add epoll test case
Date:   Mon, 27 Jan 2020 17:17:00 +0100
Message-Id: <20200127161701.153625-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
I wrote the test case for epoll.

Since it fails also without sqpoll (Linux 5.4.13-201.fc31.x86_64),
can you take a look to understand if the test is wrong?

Tomorrow I'll travel, but on Wednesday I'll try this test with the patch
that I sent and also with the upstream kernel.

Thanks,
Stefano

Stefano Garzarella (1):
  test: add epoll test case

 .gitignore    |   1 +
 test/Makefile |   5 +-
 test/epoll.c  | 307 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 311 insertions(+), 2 deletions(-)
 create mode 100644 test/epoll.c

--=20
2.24.1

