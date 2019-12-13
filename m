Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76CA611E111
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 10:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLMJmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 04:42:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38488 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725770AbfLMJmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576230169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uigEN0nLQI71ck507PDuSZrIZl/Tr9AMoJ7h/plhVG4=;
        b=PJczH307WDsxhznsDYFs9VhqQT3Wemz/FfF16PqfVQ6vz/HJsU6IBTnNy0QA52pt11p4B6
        +vLLfdxDdV8SXfznLsMBnoiVnieHAlQhpEXsvkGRk5uOOtk3Qdgjg4u7FQJOSWyG+Jr5h8
        uCWjJz/jRW+t2sE7xS5Q6YJRHmYZL48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-SD6U9BGIPm6_9_RZObwPHA-1; Fri, 13 Dec 2019 04:42:48 -0500
X-MC-Unique: SD6U9BGIPm6_9_RZObwPHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 876E4107ACC7;
        Fri, 13 Dec 2019 09:42:47 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B751A5D9C9;
        Fri, 13 Dec 2019 09:42:43 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH] KVM: arm/arm64: vgic-its: Fix restoration of unmapped collections
Date:   Fri, 13 Dec 2019 10:42:37 +0100
Message-Id: <20191213094237.19627-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Saving/restoring an unmapped collection is a valid scenario. For
example this happens if a MAPTI command was sent, featuring an
unmapped collection. At the moment the CTE fails to be restored.
Only compare against the number of online vcpus if the rdist
base is set.

Cc: stable@vger.kernel.org # v4.11+
Fixes: ea1ad53e1e31a ("KVM: arm64: vgic-its: Collection table save/restor=
e")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 98c7360d9fb7..17920d1b350a 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -2475,7 +2475,8 @@ static int vgic_its_restore_cte(struct vgic_its *it=
s, gpa_t gpa, int esz)
 	target_addr =3D (u32)(val >> KVM_ITS_CTE_RDBASE_SHIFT);
 	coll_id =3D val & KVM_ITS_CTE_ICID_MASK;
=20
-	if (target_addr >=3D atomic_read(&kvm->online_vcpus))
+	if (target_addr !=3D COLLECTION_NOT_MAPPED &&
+	    target_addr >=3D atomic_read(&kvm->online_vcpus))
 		return -EINVAL;
=20
 	collection =3D find_collection(its, coll_id);
--=20
2.20.1

