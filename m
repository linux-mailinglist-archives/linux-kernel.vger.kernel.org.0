Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E65FA4C568
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 04:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbfFTCZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 22:25:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfFTCZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:25:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C47C988E55;
        Thu, 20 Jun 2019 02:25:21 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5777B1001E69;
        Thu, 20 Jun 2019 02:25:10 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v5 24/25] userfaultfd: selftests: refactor statistics
Date:   Thu, 20 Jun 2019 10:20:07 +0800
Message-Id: <20190620022008.19172-25-peterx@redhat.com>
In-Reply-To: <20190620022008.19172-1-peterx@redhat.com>
References: <20190620022008.19172-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 20 Jun 2019 02:25:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce uffd_stats structure for statistics of the self test, at the
same time refactor the code to always pass in the uffd_stats for either
read() or poll() typed fault handling threads instead of using two
different ways to return the statistic results.  No functional change.

With the new structure, it's very easy to introduce new statistics.

Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 76 +++++++++++++++---------
 1 file changed, 49 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index b3e6497b080c..417dbdf4d379 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -88,6 +88,12 @@ static char *area_src, *area_src_alias, *area_dst, *area_dst_alias;
 static char *zeropage;
 pthread_attr_t attr;
 
+/* Userfaultfd test statistics */
+struct uffd_stats {
+	int cpu;
+	unsigned long missing_faults;
+};
+
 /* pthread_mutex_t starts at page offset 0 */
 #define area_mutex(___area, ___nr)					\
 	((pthread_mutex_t *) ((___area) + (___nr)*page_size))
@@ -127,6 +133,17 @@ static void usage(void)
 	exit(1);
 }
 
+static void uffd_stats_reset(struct uffd_stats *uffd_stats,
+			     unsigned long n_cpus)
+{
+	int i;
+
+	for (i = 0; i < n_cpus; i++) {
+		uffd_stats[i].cpu = i;
+		uffd_stats[i].missing_faults = 0;
+	}
+}
+
 static int anon_release_pages(char *rel_area)
 {
 	int ret = 0;
@@ -469,8 +486,8 @@ static int uffd_read_msg(int ufd, struct uffd_msg *msg)
 	return 0;
 }
 
-/* Return 1 if page fault handled by us; otherwise 0 */
-static int uffd_handle_page_fault(struct uffd_msg *msg)
+static void uffd_handle_page_fault(struct uffd_msg *msg,
+				   struct uffd_stats *stats)
 {
 	unsigned long offset;
 
@@ -485,18 +502,19 @@ static int uffd_handle_page_fault(struct uffd_msg *msg)
 	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
 	offset &= ~(page_size-1);
 
-	return copy_page(uffd, offset);
+	if (copy_page(uffd, offset))
+		stats->missing_faults++;
 }
 
 static void *uffd_poll_thread(void *arg)
 {
-	unsigned long cpu = (unsigned long) arg;
+	struct uffd_stats *stats = (struct uffd_stats *)arg;
+	unsigned long cpu = stats->cpu;
 	struct pollfd pollfd[2];
 	struct uffd_msg msg;
 	struct uffdio_register uffd_reg;
 	int ret;
 	char tmp_chr;
-	unsigned long userfaults = 0;
 
 	pollfd[0].fd = uffd;
 	pollfd[0].events = POLLIN;
@@ -526,7 +544,7 @@ static void *uffd_poll_thread(void *arg)
 				msg.event), exit(1);
 			break;
 		case UFFD_EVENT_PAGEFAULT:
-			userfaults += uffd_handle_page_fault(&msg);
+			uffd_handle_page_fault(&msg, stats);
 			break;
 		case UFFD_EVENT_FORK:
 			close(uffd);
@@ -545,28 +563,27 @@ static void *uffd_poll_thread(void *arg)
 			break;
 		}
 	}
-	return (void *)userfaults;
+
+	return NULL;
 }
 
 pthread_mutex_t uffd_read_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 static void *uffd_read_thread(void *arg)
 {
-	unsigned long *this_cpu_userfaults;
+	struct uffd_stats *stats = (struct uffd_stats *)arg;
 	struct uffd_msg msg;
 
-	this_cpu_userfaults = (unsigned long *) arg;
-	*this_cpu_userfaults = 0;
-
 	pthread_mutex_unlock(&uffd_read_mutex);
 	/* from here cancellation is ok */
 
 	for (;;) {
 		if (uffd_read_msg(uffd, &msg))
 			continue;
-		(*this_cpu_userfaults) += uffd_handle_page_fault(&msg);
+		uffd_handle_page_fault(&msg, stats);
 	}
-	return (void *)NULL;
+
+	return NULL;
 }
 
 static void *background_thread(void *arg)
@@ -582,13 +599,12 @@ static void *background_thread(void *arg)
 	return NULL;
 }
 
-static int stress(unsigned long *userfaults)
+static int stress(struct uffd_stats *uffd_stats)
 {
 	unsigned long cpu;
 	pthread_t locking_threads[nr_cpus];
 	pthread_t uffd_threads[nr_cpus];
 	pthread_t background_threads[nr_cpus];
-	void **_userfaults = (void **) userfaults;
 
 	finished = 0;
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
@@ -597,12 +613,13 @@ static int stress(unsigned long *userfaults)
 			return 1;
 		if (bounces & BOUNCE_POLL) {
 			if (pthread_create(&uffd_threads[cpu], &attr,
-					   uffd_poll_thread, (void *)cpu))
+					   uffd_poll_thread,
+					   (void *)&uffd_stats[cpu]))
 				return 1;
 		} else {
 			if (pthread_create(&uffd_threads[cpu], &attr,
 					   uffd_read_thread,
-					   &_userfaults[cpu]))
+					   (void *)&uffd_stats[cpu]))
 				return 1;
 			pthread_mutex_lock(&uffd_read_mutex);
 		}
@@ -639,7 +656,8 @@ static int stress(unsigned long *userfaults)
 				fprintf(stderr, "pipefd write error\n");
 				return 1;
 			}
-			if (pthread_join(uffd_threads[cpu], &_userfaults[cpu]))
+			if (pthread_join(uffd_threads[cpu],
+					 (void *)&uffd_stats[cpu]))
 				return 1;
 		} else {
 			if (pthread_cancel(uffd_threads[cpu]))
@@ -910,11 +928,11 @@ static int userfaultfd_events_test(void)
 {
 	struct uffdio_register uffdio_register;
 	unsigned long expected_ioctls;
-	unsigned long userfaults;
 	pthread_t uffd_mon;
 	int err, features;
 	pid_t pid;
 	char c;
+	struct uffd_stats stats = { 0 };
 
 	printf("testing events (fork, remap, remove): ");
 	fflush(stdout);
@@ -941,7 +959,7 @@ static int userfaultfd_events_test(void)
 			"unexpected missing ioctl for anon memory\n"),
 			exit(1);
 
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, NULL))
+	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
 		perror("uffd_poll_thread create"), exit(1);
 
 	pid = fork();
@@ -957,13 +975,13 @@ static int userfaultfd_events_test(void)
 
 	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
 		perror("pipe write"), exit(1);
-	if (pthread_join(uffd_mon, (void **)&userfaults))
+	if (pthread_join(uffd_mon, NULL))
 		return 1;
 
 	close(uffd);
-	printf("userfaults: %ld\n", userfaults);
+	printf("userfaults: %ld\n", stats.missing_faults);
 
-	return userfaults != nr_pages;
+	return stats.missing_faults != nr_pages;
 }
 
 static int userfaultfd_sig_test(void)
@@ -975,6 +993,7 @@ static int userfaultfd_sig_test(void)
 	int err, features;
 	pid_t pid;
 	char c;
+	struct uffd_stats stats = { 0 };
 
 	printf("testing signal delivery: ");
 	fflush(stdout);
@@ -1006,7 +1025,7 @@ static int userfaultfd_sig_test(void)
 	if (uffd_test_ops->release_pages(area_dst))
 		return 1;
 
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, NULL))
+	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
 		perror("uffd_poll_thread create"), exit(1);
 
 	pid = fork();
@@ -1032,6 +1051,7 @@ static int userfaultfd_sig_test(void)
 	close(uffd);
 	return userfaults != 0;
 }
+
 static int userfaultfd_stress(void)
 {
 	void *area;
@@ -1040,7 +1060,7 @@ static int userfaultfd_stress(void)
 	struct uffdio_register uffdio_register;
 	unsigned long cpu;
 	int err;
-	unsigned long userfaults[nr_cpus];
+	struct uffd_stats uffd_stats[nr_cpus];
 
 	uffd_test_ops->allocate_area((void **)&area_src);
 	if (!area_src)
@@ -1169,8 +1189,10 @@ static int userfaultfd_stress(void)
 		if (uffd_test_ops->release_pages(area_dst))
 			return 1;
 
+		uffd_stats_reset(uffd_stats, nr_cpus);
+
 		/* bounce pass */
-		if (stress(userfaults))
+		if (stress(uffd_stats))
 			return 1;
 
 		/* unregister */
@@ -1213,7 +1235,7 @@ static int userfaultfd_stress(void)
 
 		printf("userfaults:");
 		for (cpu = 0; cpu < nr_cpus; cpu++)
-			printf(" %lu", userfaults[cpu]);
+			printf(" %lu", uffd_stats[cpu].missing_faults);
 		printf("\n");
 	}
 
-- 
2.21.0

