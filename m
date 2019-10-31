Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5A4EB2C2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 15:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfJaOaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 10:30:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51950 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728193AbfJaOaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572532213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOUVT0tM1Rk0k66JwJCEU8B49lHWoxKSNJNje7XME9Y=;
        b=EgyADGXPYilyBPaHem5qxDAMIc+B67g2PmMM8h55JEizVr5HZB31Ae+aeiKMnoLdJlUzqu
        Bphu+veCSTFjzIA6atBxgSzGW/EnsAf+fW93S6OcjVHvTcoNtarU6khVeyXUN8Qz/yWNX2
        0GTgv883tlu4RDxdypUP7aCd/HocOVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-QQBS-wraPk-5GELsDba4IA-1; Thu, 31 Oct 2019 10:30:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEE3D2EDC;
        Thu, 31 Oct 2019 14:30:06 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E1C25D6D6;
        Thu, 31 Oct 2019 14:29:59 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arun KS <arunks@codeaurora.org>
Subject: [PATCH v1 05/12] powerpc/pseries: CMM: Use adjust_managed_page_count() insted of totalram_pages_*
Date:   Thu, 31 Oct 2019 15:29:26 +0100
Message-Id: <20191031142933.10779-6-david@redhat.com>
In-Reply-To: <20191031142933.10779-1-david@redhat.com>
References: <20191031142933.10779-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: QQBS-wraPk-5GELsDba4IA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adjust_managed_page_count() performs a totalram_pages_add(), but also
adjust the managed pages of the zone. Let's use that instead, similar to
virtio-balloon. Use it before freeing a page.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Richard Fontana <rfontana@redhat.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arun KS <arunks@codeaurora.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/=
pseries/cmm.c
index 33d31e48ec15..f82c468ca2c4 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -164,7 +164,7 @@ static long cmm_alloc_pages(long nr)
=20
 =09=09list_add(&page->lru, &cmm_page_list);
 =09=09loaned_pages++;
-=09=09totalram_pages_dec();
+=09=09adjust_managed_page_count(page, -1);
 =09=09spin_unlock(&cmm_lock);
 =09=09nr--;
 =09}
@@ -191,10 +191,10 @@ static long cmm_free_pages(long nr)
 =09=09=09break;
 =09=09plpar_page_set_active(page);
 =09=09list_del(&page->lru);
+=09=09adjust_managed_page_count(page, 1);
 =09=09__free_page(page);
 =09=09loaned_pages--;
 =09=09nr--;
-=09=09totalram_pages_inc();
 =09}
 =09spin_unlock(&cmm_lock);
 =09cmm_dbg("End request with %ld pages unfulfilled\n", nr);
@@ -518,10 +518,10 @@ static int cmm_mem_going_offline(void *arg)
 =09=09=09continue;
 =09=09plpar_page_set_active(page);
 =09=09list_del(&page->lru);
+=09=09adjust_managed_page_count(page, 1);
 =09=09__free_page(page);
 =09=09freed++;
 =09=09loaned_pages--;
-=09=09totalram_pages_inc();
 =09}
=20
 =09spin_unlock(&cmm_lock);
--=20
2.21.0

