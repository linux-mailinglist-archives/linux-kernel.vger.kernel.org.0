Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93ADD10A6BD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 23:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKZWn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 17:43:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50447 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726103AbfKZWn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 17:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574808235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BDiy4464Umn5P4mtuCmXuryCcZFijTYcLQRYOPE+8D8=;
        b=hMcqqG4GTYWrCs3n3NeCMuqStlsrOoZQtmlBzQ9GGpLwgg35fnAoKa2cJohBMxk/Lms9ap
        3NklCingt4JNFm94z4oG4ZdpsZYw8YdKWJ0R9iE39Zlw/8joAP4n+xJZlZq9E1Jq3GKLQj
        3t6riq6z4nM695D5RJ8Ualr5J3j2rHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-UhEfoINhPkm7Z_9hqYNzmA-1; Tue, 26 Nov 2019 17:43:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE1B9800C76;
        Tue, 26 Nov 2019 22:43:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-161.rdu2.redhat.com [10.10.120.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C22EB60BE2;
        Tue, 26 Nov 2019 22:43:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Minor cleanups and a minor bugfix
MIME-Version: 1.0
Content-ID: <27496.1574808228.1@warthog.procyon.org.uk>
Date:   Tue, 26 Nov 2019 22:43:48 +0000
Message-ID: <27497.1574808228@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: UhEfoINhPkm7Z_9hqYNzmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Can you pull these AFS patches please?  They are:

 (1) Minor fix to make some debugging statements display information from
     the correct iov_iter.

 (2,3) Rename some members and variables to make things more obvious or
     consistent.

 (4) Provide a helper to wrap increments of the usage count on the afs_read
     struct.

 (5) Use scnprintf() to print into a stack buffer rather than sprintf().

 (6,7) Remove some set but unused variables.

There should be no functional changes from (2) - (7).

Thanks,
David
---
The following changes since commit a99d8080aaf358d5d23581244e5da23b35e340b9=
:

  Linux 5.4-rc6 (2019-11-03 14:07:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/=
afs-next-20191121

for you to fetch changes up to 4fe171bb81b13b40bf568330ec3716dfb304ced1:

  afs: Remove set but not used variable 'ret' (2019-11-21 20:36:04 +0000)

----------------------------------------------------------------
AFS development

----------------------------------------------------------------
David Howells (4):
      afs: Use call->_iter not &call->iter in debugging statements
      afs: Switch the naming of call->iter and call->_iter
      afs: Rename desc -> req in afs_fetch_data()
      afs: Introduce an afs_get_read() refcount helper

Mark Salyzyn (1):
      afs: xattr: use scnprintf

zhengbin (2):
      afs: Remove set but not used variables 'before', 'after'
      afs: Remove set but not used variable 'ret'

 fs/afs/cmservice.c |  6 +++---
 fs/afs/dir_edit.c  | 12 ++----------
 fs/afs/file.c      |  6 +++---
 fs/afs/fsclient.c  | 16 +++++++---------
 fs/afs/internal.h  | 16 +++++++++++-----
 fs/afs/rxrpc.c     | 12 ++++++------
 fs/afs/server.c    |  3 +--
 fs/afs/vlclient.c  |  6 +++---
 fs/afs/xattr.c     | 16 +++++++++-------
 fs/afs/yfsclient.c | 11 +++++------
 10 files changed, 50 insertions(+), 54 deletions(-)

