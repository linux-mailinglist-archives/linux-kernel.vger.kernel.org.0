Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD49181A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 14:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgCKNzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 09:55:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44408 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729460AbgCKNzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583934939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=B0fQvRnnbCIzTHm/Is/o3N8IvV36jYDTfCd8QuUaXqI=;
        b=WYQFm7zBpLKQjK+8I2LvjuWJoWjJng17T16vZ4KczBDMnSv6OwcrRmtdIqdnXiZbaNQsii
        DuR9cLx0CJ8QIB7SRTSdVf8JHsjYGUQXJOt/KNf6HtByyJf6IajCuJbwN2kFCqWx7cvBAb
        9vXFb+fXVSEFYOKgJVXom6XjxieF1Go=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-2UXIatH7OA-f802487RpQQ-1; Wed, 11 Mar 2020 09:55:35 -0400
X-MC-Unique: 2UXIatH7OA-f802487RpQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 534A41005513;
        Wed, 11 Mar 2020 13:55:33 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A72DE60C99;
        Wed, 11 Mar 2020 13:55:24 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Tyler Sanderson <tysand@google.com>,
        Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v4 0/1] mm: virtio-balloon fix to go through the -mm tree
Date:   Wed, 11 Mar 2020 14:55:22 +0100
Message-Id: <20200311135523.18512-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Andrew, as this fix is based on free page reporting, can this go through
your tree?

Patch #1 contains a proper description.

v3 -> v4:
- Add Ack from David Rientjes
- Minor tweaks to test details in the patch description

v2 -> v3:
- Use vb->vdev instead of vdev in all feature checks. We'll clean the
  other ones up later.
- Add one empty line virtballoon_probe() to make it look consistent.
- Drop one unrelated added line in virtballoon_remove()

v1 -> v2:
- Rebase on top of linux-next (free page reporting)
- Clarified some parts in the patch description and added testing
  instructions/results
- Added Fixes: and Tested-by:

David Hildenbrand (1):
  virtio-balloon: Switch back to OOM handler for
    VIRTIO_BALLOON_F_DEFLATE_ON_OOM

 drivers/virtio/virtio_balloon.c | 103 +++++++++++++++-----------------
 1 file changed, 47 insertions(+), 56 deletions(-)

--=20
2.24.1

