Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0C9181A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 14:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgCKNzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 09:55:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58242 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729460AbgCKNzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583934943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LsB7SqOxdN9Ntj+X4ogYuc6qF9z51kmolybiq5BgoVQ=;
        b=TwKWc504x4LP3xo6qHj8ifyHlx+NOSKl46FBTgf22kfl304C+fbOSF5uDBOh4Ao3cLqlbk
        ebAYeUQQbHbQUYxzpR+yuF+2VAdrnqawY5axP9KUby9dtA5Gopu4zEr4nPEU/debf5oSIn
        /KuOoUQtD4Z3V2n/TxS4kWTRt73dYoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-vn-ErAR1Prq78oyGgIYs8g-1; Wed, 11 Mar 2020 09:55:38 -0400
X-MC-Unique: vn-ErAR1Prq78oyGgIYs8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97E88801E6C;
        Wed, 11 Mar 2020 13:55:36 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A417460C18;
        Wed, 11 Mar 2020 13:55:33 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Hildenbrand <david@redhat.com>,
        Tyler Sanderson <tysand@google.com>,
        David Rientjes <rientjes@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4] virtio-balloon: Switch back to OOM handler for VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date:   Wed, 11 Mar 2020 14:55:23 +0100
Message-Id: <20200311135523.18512-2-david@redhat.com>
In-Reply-To: <20200311135523.18512-1-david@redhat.com>
References: <20200311135523.18512-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker"=
)
changed the behavior when deflation happens automatically. Instead of
deflating when called by the OOM handler, the shrinker is used.

However, the balloon is not simply some other slab cache that should be
shrunk when under memory pressure. The shrinker does not have a concept o=
f
priorities yet, so this behavior cannot be configured. Eventually once
that is in place, we might want to switch back after doing proper
testing.

There was a report that this results in undesired side effects when
inflating the balloon to shrink the page cache. [1]
	"When inflating the balloon against page cache (i.e. no free memory
	 remains) vmscan.c will both shrink page cache, but also invoke the
	 shrinkers -- including the balloon's shrinker. So the balloon
	 driver allocates memory which requires reclaim, vmscan gets this
	 memory by shrinking the balloon, and then the driver adds the
	 memory back to the balloon. Basically a busy no-op."

The name "deflate on OOM" makes it pretty clear when deflation should
happen - after other approaches to reclaim memory failed, not while
reclaiming. This allows to minimize the footprint of a guest - memory
will only be taken out of the balloon when really needed.

Keep using the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT, because
this has no such side effects. Always register the shrinker with
VIRTIO_BALLOON_F_FREE_PAGE_HINT now. We are always allowed to reuse free
pages that are still to be processed by the guest. The hypervisor takes
care of identifying and resolving possible races between processing a
hinting request and the guest reusing a page.

In contrast to pre commit 71994620bb25 ("virtio_balloon: replace oom
notifier with shrinker"), don't add a module parameter to configure the
number of pages to deflate on OOM. Can be re-added if really needed.
Also, pay attention that leak_balloon() returns the number of 4k pages -
convert it properly in virtio_balloon_oom_notify().

Testing done by Tyler for future reference:
  Test setup: VM with 16 CPU, 64GB RAM. Running Debian 10. We have a 42
  GB file full of random bytes that we continually cat to /dev/null.
  This fills the page cache as the file is read. Meanwhile, we trigger
  the balloon to inflate, with a target size of 53 GB. This setup causes
  the balloon inflation to pressure the page cache as the page cache is
  also trying to grow. Afterwards we shrink the balloon back to zero (so
  total deflate =3D total inflate).

  Without this patch (kernel 4.19.0-5):
  Inflation never reaches the target until we stop the "cat file >
  /dev/null" process. Total inflation time was 542 seconds. The longest
  period that made no net forward progress was 315 seconds.
    Result of "grep balloon /proc/vmstat" after the test:
    balloon_inflate 154828377
    balloon_deflate 154828377

  With this patch (kernel 5.6.0-rc4+):
  Total inflation duration was 63 seconds. No deflate-queue activity
  occurs when pressuring the page-cache.
    Result of "grep balloon /proc/vmstat" after the test:
    balloon_inflate 12968539
    balloon_deflate 12968539

  Conclusion: This patch fixes the issue. In the test it reduced
  inflate/deflate activity by 12x, and reduced inflation time by 8.6x.
  But more importantly, if we hadn't killed the "cat file > /dev/null"
  process then, without the patch, the inflation process would never reac=
h
  the target.

[1] https://www.spinics.net/lists/linux-virtualization/msg40863.html

Reported-by: Tyler Sanderson <tysand@google.com>
Tested-by: Tyler Sanderson <tysand@google.com>
Acked-by: David Rientjes <rientjes@google.com>
Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker"=
)
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 103 +++++++++++++++-----------------
 1 file changed, 47 insertions(+), 56 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
index 9e0177529bad..0ef16566c3f3 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/balloon_compaction.h>
+#include <linux/oom.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/mount.h>
@@ -28,7 +29,9 @@
  */
 #define VIRTIO_BALLOON_PAGES_PER_PAGE (unsigned)(PAGE_SIZE >> VIRTIO_BAL=
LOON_PFN_SHIFT)
 #define VIRTIO_BALLOON_ARRAY_PFNS_MAX 256
-#define VIRTBALLOON_OOM_NOTIFY_PRIORITY 80
+/* Maximum number of (4k) pages to deflate on OOM notifications. */
+#define VIRTIO_BALLOON_OOM_NR_PAGES 256
+#define VIRTIO_BALLOON_OOM_NOTIFY_PRIORITY 80
=20
 #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWAR=
N | \
 					     __GFP_NOMEMALLOC)
@@ -114,9 +117,12 @@ struct virtio_balloon {
 	/* Memory statistics */
 	struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
=20
-	/* To register a shrinker to shrink memory upon memory pressure */
+	/* Shrinker to return free pages - VIRTIO_BALLOON_F_FREE_PAGE_HINT */
 	struct shrinker shrinker;
=20
+	/* OOM notifier to deflate on OOM - VIRTIO_BALLOON_F_DEFLATE_ON_OOM */
+	struct notifier_block oom_nb;
+
 	/* Free page reporting device */
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
@@ -830,50 +836,13 @@ static unsigned long shrink_free_pages(struct virti=
o_balloon *vb,
 	return blocks_freed * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
 }
=20
-static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
-                                          unsigned long pages_to_free)
-{
-	return leak_balloon(vb, pages_to_free * VIRTIO_BALLOON_PAGES_PER_PAGE) =
/
-		VIRTIO_BALLOON_PAGES_PER_PAGE;
-}
-
-static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
-					  unsigned long pages_to_free)
-{
-	unsigned long pages_freed =3D 0;
-
-	/*
-	 * One invocation of leak_balloon can deflate at most
-	 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
-	 * multiple times to deflate pages till reaching pages_to_free.
-	 */
-	while (vb->num_pages && pages_freed < pages_to_free)
-		pages_freed +=3D leak_balloon_pages(vb,
-						  pages_to_free - pages_freed);
-
-	update_balloon_size(vb);
-
-	return pages_freed;
-}
-
 static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrin=
ker,
 						  struct shrink_control *sc)
 {
-	unsigned long pages_to_free, pages_freed =3D 0;
 	struct virtio_balloon *vb =3D container_of(shrinker,
 					struct virtio_balloon, shrinker);
=20
-	pages_to_free =3D sc->nr_to_scan;
-
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
-		pages_freed =3D shrink_free_pages(vb, pages_to_free);
-
-	if (pages_freed >=3D pages_to_free)
-		return pages_freed;
-
-	pages_freed +=3D shrink_balloon_pages(vb, pages_to_free - pages_freed);
-
-	return pages_freed;
+	return shrink_free_pages(vb, sc->nr_to_scan);
 }
=20
 static unsigned long virtio_balloon_shrinker_count(struct shrinker *shri=
nker,
@@ -881,12 +850,22 @@ static unsigned long virtio_balloon_shrinker_count(=
struct shrinker *shrinker,
 {
 	struct virtio_balloon *vb =3D container_of(shrinker,
 					struct virtio_balloon, shrinker);
-	unsigned long count;
=20
-	count =3D vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
-	count +=3D vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
+	return vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
+}
+
+static int virtio_balloon_oom_notify(struct notifier_block *nb,
+				     unsigned long dummy, void *parm)
+{
+	struct virtio_balloon *vb =3D container_of(nb,
+						 struct virtio_balloon, oom_nb);
+	unsigned long *freed =3D parm;
+
+	*freed +=3D leak_balloon(vb, VIRTIO_BALLOON_OOM_NR_PAGES) /
+		  VIRTIO_BALLOON_PAGES_PER_PAGE;
+	update_balloon_size(vb);
=20
-	return count;
+	return NOTIFY_OK;
 }
=20
 static void virtio_balloon_unregister_shrinker(struct virtio_balloon *vb=
)
@@ -971,7 +950,23 @@ static int virtballoon_probe(struct virtio_device *v=
dev)
 						  VIRTIO_BALLOON_CMD_ID_STOP);
 		spin_lock_init(&vb->free_page_list_lock);
 		INIT_LIST_HEAD(&vb->free_page_list);
+		/*
+		 * We're allowed to reuse any free pages, even if they are
+		 * still to be processed by the host.
+		 */
+		err =3D virtio_balloon_register_shrinker(vb);
+		if (err)
+			goto out_del_balloon_wq;
+	}
+
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
+		vb->oom_nb.notifier_call =3D virtio_balloon_oom_notify;
+		vb->oom_nb.priority =3D VIRTIO_BALLOON_OOM_NOTIFY_PRIORITY;
+		err =3D register_oom_notifier(&vb->oom_nb);
+		if (err < 0)
+			goto out_unregister_shrinker;
 	}
+
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
 		/* Start with poison val of 0 representing general init */
 		__u32 poison_val =3D 0;
@@ -986,15 +981,6 @@ static int virtballoon_probe(struct virtio_device *v=
dev)
 		virtio_cwrite(vb->vdev, struct virtio_balloon_config,
 			      poison_val, &poison_val);
 	}
-	/*
-	 * We continue to use VIRTIO_BALLOON_F_DEFLATE_ON_OOM to decide if a
-	 * shrinker needs to be registered to relieve memory pressure.
-	 */
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
-		err =3D virtio_balloon_register_shrinker(vb);
-		if (err)
-			goto out_del_balloon_wq;
-	}
=20
 	vb->pr_dev_info.report =3D virtballoon_free_page_report;
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
@@ -1003,12 +989,12 @@ static int virtballoon_probe(struct virtio_device =
*vdev)
 		capacity =3D virtqueue_get_vring_size(vb->reporting_vq);
 		if (capacity < PAGE_REPORTING_CAPACITY) {
 			err =3D -ENOSPC;
-			goto out_unregister_shrinker;
+			goto out_unregister_oom;
 		}
=20
 		err =3D page_reporting_register(&vb->pr_dev_info);
 		if (err)
-			goto out_unregister_shrinker;
+			goto out_unregister_oom;
 	}
=20
 	virtio_device_ready(vdev);
@@ -1017,8 +1003,11 @@ static int virtballoon_probe(struct virtio_device =
*vdev)
 		virtballoon_changed(vdev);
 	return 0;
=20
-out_unregister_shrinker:
+out_unregister_oom:
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+		unregister_oom_notifier(&vb->oom_nb);
+out_unregister_shrinker:
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		virtio_balloon_unregister_shrinker(vb);
 out_del_balloon_wq:
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
@@ -1061,6 +1050,8 @@ static void virtballoon_remove(struct virtio_device=
 *vdev)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
 		page_reporting_unregister(&vb->pr_dev_info);
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+		unregister_oom_notifier(&vb->oom_nb);
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		virtio_balloon_unregister_shrinker(vb);
 	spin_lock_irq(&vb->stop_update_lock);
 	vb->stop_update =3D true;
--=20
2.24.1

