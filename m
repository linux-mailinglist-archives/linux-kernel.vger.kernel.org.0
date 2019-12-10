Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B87F11855F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 11:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfLJKnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 05:43:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22407 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbfLJKnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575974598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QeLkFWwrMkorI96amP0PUDWveJeOajJe9WkJWUSYsG8=;
        b=eJhUNk+x3T2mjZzIv4r2nah/7StUURBXg617aabAaRs7KvLfp3+/Sh69bOsZINW2fapbO4
        Ncaz45vnAskR3MAZiqgLZVCgyL7V863b3S9mXUwlW4692ZvrUHr+I0kgjQmtcDKWaoXVsW
        iRKq3kqpaX4LNBrpKzzFpe3gjWqEFJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-T8h34d17OraQX2hFRsHDTg-1; Tue, 10 Dec 2019 05:43:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68AAD800D5E;
        Tue, 10 Dec 2019 10:43:15 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-168.ams2.redhat.com [10.36.117.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65FAE60568;
        Tue, 10 Dec 2019 10:43:13 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     Dexuan Cui <decui@microsoft.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next v2 1/6] vsock/virtio_transport_common: remove unused virtio header includes
Date:   Tue, 10 Dec 2019 11:43:02 +0100
Message-Id: <20191210104307.89346-2-sgarzare@redhat.com>
In-Reply-To: <20191210104307.89346-1-sgarzare@redhat.com>
References: <20191210104307.89346-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: T8h34d17OraQX2hFRsHDTg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can remove virtio header includes, because virtio_transport_common
doesn't use virtio API, but provides common functions to interface
virtio/vhost transports with the af_vsock core, and to handle
the protocol.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio=
_transport_common.c
index e5ea29c6bca7..0e20b0f6eb65 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -11,9 +11,6 @@
 #include <linux/sched/signal.h>
 #include <linux/ctype.h>
 #include <linux/list.h>
-#include <linux/virtio.h>
-#include <linux/virtio_ids.h>
-#include <linux/virtio_config.h>
 #include <linux/virtio_vsock.h>
 #include <uapi/linux/vsockmon.h>
=20
--=20
2.23.0

