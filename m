Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78051EB2C4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 15:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfJaOaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 10:30:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57016 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728144AbfJaOa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572532228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AeVe0KaIImcMvsA2zdCbPU6IJySLMRv/7lmH02hn0Zk=;
        b=cJC83TYz2Ngn2ylY0NUGfmYtxpESdy4woMUFaB8kR32+/cEBFxa21bIUWOV+c0+GwF2+Tk
        2rGftjAGSvf9UyIhUeipcLqyo5Cv1iGHxOWzY7MjKgkXBfmibPbv4ENfqc2eoNKX5zQsWX
        c9Wj8QWBPsrCwAa6aS0rv++Clc9x4dk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-XjGab2tQP0mO-FypSObiTg-1; Thu, 31 Oct 2019 10:30:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35EA82EDC;
        Thu, 31 Oct 2019 14:30:22 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F0D75D6D6;
        Thu, 31 Oct 2019 14:30:19 +0000 (UTC)
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
Subject: [PATCH v1 07/12] powerpc/pseries: CMM: Convert loaned_pages to an atomic_long_t
Date:   Thu, 31 Oct 2019 15:29:28 +0100
Message-Id: <20191031142933.10779-8-david@redhat.com>
In-Reply-To: <20191031142933.10779-1-david@redhat.com>
References: <20191031142933.10779-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: XjGab2tQP0mO-FypSObiTg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching to balloon compaction, we want to drop the cmm_lock and
completely rely on the balloon compaction list lock internally.
loaned_pages is currently protected under the cmm_lock.

Note: Right now cmm_alloc_pages() and cmm_free_pages() can be called at
the same time, e.g., via the thread and a concurrent OOM notifier.

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
 arch/powerpc/platforms/pseries/cmm.c | 35 +++++++++++++++-------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/=
pseries/cmm.c
index 29416b621189..3a55dd1fdd39 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -73,7 +73,7 @@ MODULE_PARM_DESC(debug, "Enable module debugging logging.=
 Set to 1 to enable. "
=20
 #define cmm_dbg(...) if (cmm_debug) { printk(KERN_INFO "cmm: "__VA_ARGS__)=
; }
=20
-static unsigned long loaned_pages;
+static atomic_long_t loaned_pages;
 static unsigned long loaned_pages_target;
 static unsigned long oom_freed_pages;
=20
@@ -159,7 +159,7 @@ static long cmm_alloc_pages(long nr)
 =09=09}
=20
 =09=09list_add(&page->lru, &cmm_page_list);
-=09=09loaned_pages++;
+=09=09atomic_long_inc(&loaned_pages);
 =09=09adjust_managed_page_count(page, -1);
 =09=09spin_unlock(&cmm_lock);
 =09=09nr--;
@@ -189,7 +189,7 @@ static long cmm_free_pages(long nr)
 =09=09list_del(&page->lru);
 =09=09adjust_managed_page_count(page, 1);
 =09=09__free_page(page);
-=09=09loaned_pages--;
+=09=09atomic_long_dec(&loaned_pages);
 =09=09nr--;
 =09}
 =09spin_unlock(&cmm_lock);
@@ -214,7 +214,7 @@ static int cmm_oom_notify(struct notifier_block *self,
=20
 =09cmm_dbg("OOM processing started\n");
 =09nr =3D cmm_free_pages(nr);
-=09loaned_pages_target =3D loaned_pages;
+=09loaned_pages_target =3D atomic_long_read(&loaned_pages);
 =09*freed +=3D KB2PAGES(oom_kb) - nr;
 =09oom_freed_pages +=3D KB2PAGES(oom_kb) - nr;
 =09cmm_dbg("OOM processing complete\n");
@@ -231,10 +231,11 @@ static int cmm_oom_notify(struct notifier_block *self=
,
  **/
 static void cmm_get_mpp(void)
 {
+=09const long __loaned_pages =3D atomic_long_read(&loaned_pages);
+=09const long total_pages =3D totalram_pages() + __loaned_pages;
 =09int rc;
 =09struct hvcall_mpp_data mpp_data;
 =09signed long active_pages_target, page_loan_request, target;
-=09signed long total_pages =3D totalram_pages() + loaned_pages;
 =09signed long min_mem_pages =3D (min_mem_mb * 1024 * 1024) / PAGE_SIZE;
=20
 =09rc =3D h_get_mpp(&mpp_data);
@@ -243,7 +244,7 @@ static void cmm_get_mpp(void)
 =09=09return;
=20
 =09page_loan_request =3D div_s64((s64)mpp_data.loan_request, PAGE_SIZE);
-=09target =3D page_loan_request + (signed long)loaned_pages;
+=09target =3D page_loan_request + __loaned_pages;
=20
 =09if (target < 0 || total_pages < min_mem_pages)
 =09=09target =3D 0;
@@ -264,7 +265,7 @@ static void cmm_get_mpp(void)
 =09loaned_pages_target =3D target;
=20
 =09cmm_dbg("delta =3D %ld, loaned =3D %lu, target =3D %lu, oom =3D %lu, to=
talram =3D %lu\n",
-=09=09page_loan_request, loaned_pages, loaned_pages_target,
+=09=09page_loan_request, __loaned_pages, loaned_pages_target,
 =09=09oom_freed_pages, totalram_pages());
 }
=20
@@ -282,6 +283,7 @@ static struct notifier_block cmm_oom_nb =3D {
 static int cmm_thread(void *dummy)
 {
 =09unsigned long timeleft;
+=09long __loaned_pages;
=20
 =09while (1) {
 =09=09timeleft =3D msleep_interruptible(delay * 1000);
@@ -312,11 +314,12 @@ static int cmm_thread(void *dummy)
=20
 =09=09cmm_get_mpp();
=20
-=09=09if (loaned_pages_target > loaned_pages) {
-=09=09=09if (cmm_alloc_pages(loaned_pages_target - loaned_pages))
-=09=09=09=09loaned_pages_target =3D loaned_pages;
-=09=09} else if (loaned_pages_target < loaned_pages)
-=09=09=09cmm_free_pages(loaned_pages - loaned_pages_target);
+=09=09__loaned_pages =3D atomic_long_read(&loaned_pages);
+=09=09if (loaned_pages_target > __loaned_pages) {
+=09=09=09if (cmm_alloc_pages(loaned_pages_target - __loaned_pages))
+=09=09=09=09loaned_pages_target =3D __loaned_pages;
+=09=09} else if (loaned_pages_target < __loaned_pages)
+=09=09=09cmm_free_pages(__loaned_pages - loaned_pages_target);
 =09}
 =09return 0;
 }
@@ -330,7 +333,7 @@ static int cmm_thread(void *dummy)
 =09}=09=09=09=09=09=09=09\
 =09static DEVICE_ATTR(name, 0444, show_##name, NULL)
=20
-CMM_SHOW(loaned_kb, "%lu\n", PAGES2KB(loaned_pages));
+CMM_SHOW(loaned_kb, "%lu\n", PAGES2KB(atomic_long_read(&loaned_pages)));
 CMM_SHOW(loaned_target_kb, "%lu\n", PAGES2KB(loaned_pages_target));
=20
 static ssize_t show_oom_pages(struct device *dev,
@@ -433,7 +436,7 @@ static int cmm_reboot_notifier(struct notifier_block *n=
b,
 =09=09if (cmm_thread_ptr)
 =09=09=09kthread_stop(cmm_thread_ptr);
 =09=09cmm_thread_ptr =3D NULL;
-=09=09cmm_free_pages(loaned_pages);
+=09=09cmm_free_pages(atomic_long_read(&loaned_pages));
 =09}
 =09return NOTIFY_DONE;
 }
@@ -540,7 +543,7 @@ static void cmm_exit(void)
 =09unregister_oom_notifier(&cmm_oom_nb);
 =09unregister_reboot_notifier(&cmm_reboot_nb);
 =09unregister_memory_notifier(&cmm_mem_nb);
-=09cmm_free_pages(loaned_pages);
+=09cmm_free_pages(atomic_long_read(&loaned_pages));
 =09cmm_unregister_sysfs(&cmm_dev);
 }
=20
@@ -561,7 +564,7 @@ static int cmm_set_disable(const char *val, const struc=
t kernel_param *kp)
 =09=09if (cmm_thread_ptr)
 =09=09=09kthread_stop(cmm_thread_ptr);
 =09=09cmm_thread_ptr =3D NULL;
-=09=09cmm_free_pages(loaned_pages);
+=09=09cmm_free_pages(atomic_long_read(&loaned_pages));
 =09} else if (!disable && cmm_disabled) {
 =09=09cmm_thread_ptr =3D kthread_run(cmm_thread, NULL, "cmmthread");
 =09=09if (IS_ERR(cmm_thread_ptr))
--=20
2.21.0

