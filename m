Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8139E110530
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 20:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfLCTcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 14:32:01 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35996 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfLCTbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:31:47 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3JOO27165045;
        Tue, 3 Dec 2019 19:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=lCSLHYSU4Y0Z6DmpOIPxgEep26mKHSiVXHQRmZGb4RQ=;
 b=dHVQRaRvmldPAbJ0tkwVYDl9wpEdZIJUyWrd+o8nmemGtycdAxhIexssbCEYRdGXMy5+
 aMrGqE1ae5ki0gCji+5RenrxSC5IAVImCYG+KRJ8c7yvl7M8xQ/1BFqPXEN8dzclN1kQ
 mo+J/w9kCI9EIy+XRZ3zPONNpNTFFh4xMtMhXnQR0qYhSEKRqMYl72KVc3QVx7SFrO0I
 ZfMPlZ5E00XX6Ot4E9C/BZnGvpHcPf0m8bQ0NhD1RnIhvFlBTlU2lWDAgkurXkEEzbwO
 Cpyw6H+Bww+i6ilMXjl/ZLJLEcFJvegWPMbshiO++3JJTLz9dxUn9ZYNcLfrIiTvEokp 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wkgcq9x9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 19:31:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3JEeXP188258;
        Tue, 3 Dec 2019 19:31:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wnvqwvu9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 19:31:37 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB3JVakM010089;
        Tue, 3 Dec 2019 19:31:36 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Dec 2019 11:31:35 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-crypto@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v2 5/5] padata: update documentation
Date:   Tue,  3 Dec 2019 14:31:14 -0500
Message-Id: <20191203193114.238912-6-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203193114.238912-1-daniel.m.jordan@oracle.com>
References: <20191203193114.238912-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove references to unused functions, standardize language, update to
reflect new functionality, migrate to rst format, and fix all kernel-doc
warnings.

Fixes: 815613da6a67 ("kernel/padata.c: removed unused code")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/core-api/index.rst  |   1 +
 Documentation/core-api/padata.rst | 169 ++++++++++++++++++++++++++++++
 Documentation/padata.txt          | 139 ------------------------
 include/linux/padata.h            |  15 ++-
 kernel/padata.c                   |  35 ++++---
 5 files changed, 198 insertions(+), 161 deletions(-)
 create mode 100644 Documentation/core-api/padata.rst
 delete mode 100644 Documentation/padata.txt

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index ab0eae1c153a..ab0b9ec85506 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -39,6 +39,7 @@ Core utilities
    ../RCU/index
    gcc-plugins
    symbol-namespaces
+   padata
 
 
 Interfaces for kernel debugging
diff --git a/Documentation/core-api/padata.rst b/Documentation/core-api/padata.rst
new file mode 100644
index 000000000000..9a24c111781d
--- /dev/null
+++ b/Documentation/core-api/padata.rst
@@ -0,0 +1,169 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+The padata parallel execution mechanism
+=======================================
+
+:Date: December 2019
+
+Padata is a mechanism by which the kernel can farm jobs out to be done in
+parallel on multiple CPUs while retaining their ordering.  It was developed for
+use with the IPsec code, which needs to be able to perform encryption and
+decryption on large numbers of packets without reordering those packets.  The
+crypto developers made a point of writing padata in a sufficiently general
+fashion that it could be put to other uses as well.
+
+Usage
+=====
+
+Initializing
+------------
+
+The first step in using padata is to set up a padata_instance structure for
+overall control of how jobs are to be run::
+
+    #include <linux/padata.h>
+
+    struct padata_instance *padata_alloc_possible(const char *name);
+
+'name' simply identifies the instance.
+
+There are functions for enabling and disabling the instance::
+
+    int padata_start(struct padata_instance *pinst);
+    void padata_stop(struct padata_instance *pinst);
+
+These functions are setting or clearing the "PADATA_INIT" flag; if that flag is
+not set, other functions will refuse to work.  padata_start() returns zero on
+success (flag set) or -EINVAL if the padata cpumask contains no active CPU
+(flag not set).  padata_stop() clears the flag and blocks until the padata
+instance is unused.
+
+Finally, complete padata initialization by allocating a padata_shell::
+
+   struct padata_shell *padata_alloc_shell(struct padata_instance *pinst);
+
+A padata_shell is used to submit a job to padata and allows a series of such
+jobs to be serialized independently.  A padata_instance may have one or more
+padata_shells associated with it, each allowing a separate series of jobs.
+
+Modifying cpumasks
+------------------
+
+The CPUs used to run jobs can be changed in two ways, programatically with
+padata_set_cpumask() or via sysfs.  The former is defined::
+
+    int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
+			   cpumask_var_t cpumask);
+
+Here cpumask_type is one of PADATA_CPU_PARALLEL or PADATA_CPU_SERIAL, where a
+parallel cpumask describes which processors will be used to execute jobs
+submitted to this instance in parallel and a serial cpumask defines which
+processors are allowed to be used as the serialization callback processor.
+cpumask specifies the new cpumask to use.
+
+There may be sysfs files for an instance's cpumasks.  For example, pcrypt's
+live in /sys/kernel/pcrypt/<instance-name>.  Within an instance's directory
+there are two files, parallel_cpumask and serial_cpumask, and either cpumask
+may be changed by echoing a bitmask into the file, for example::
+
+    echo f > /sys/kernel/pcrypt/pencrypt/parallel_cpumask
+
+Reading one of these files shows the user-supplied cpumask, which may be
+different from the 'usable' cpumask.
+
+Padata maintains two pairs of cpumasks internally, the user-supplied cpumasks
+and the 'usable' cpumasks.  (Each pair consists of a parallel and a serial
+cpumask.)  The user-supplied cpumasks default to all possible CPUs on instance
+allocation and may be changed as above.  The usable cpumasks are always a
+subset of the user-supplied cpumasks and contain only the online CPUs in the
+user-supplied masks; these are the cpumasks padata actually uses.  So it is
+legal to supply a cpumask to padata that contains offline CPUs.  Once an
+offline CPU in the user-supplied cpumask comes online, padata is going to use
+it.
+
+Changing the CPU masks are expensive operations, so it should not be done with
+great frequency.
+
+Running A Job
+-------------
+
+Actually submitting work to the padata instance requires the creation of a
+padata_priv structure, which represents one job::
+
+    struct padata_priv {
+        /* Other stuff here... */
+	void                    (*parallel)(struct padata_priv *padata);
+	void                    (*serial)(struct padata_priv *padata);
+    };
+
+This structure will almost certainly be embedded within some larger
+structure specific to the work to be done.  Most of its fields are private to
+padata, but the structure should be zeroed at initialisation time, and the
+parallel() and serial() functions should be provided.  Those functions will
+be called in the process of getting the work done as we will see
+momentarily.
+
+The submission of the job is done with::
+
+    int padata_do_parallel(struct padata_shell *ps,
+		           struct padata_priv *padata, int *cb_cpu);
+
+The ps and padata structures must be set up as described above; cb_cpu
+points to the preferred CPU to be used for the final callback when the job is
+done; it must be in the current instance's CPU mask (if not the cb_cpu pointer
+is updated to point to the CPU actually chosen).  The return value from
+padata_do_parallel() is zero on success, indicating that the job is in
+progress. -EBUSY means that somebody, somewhere else is messing with the
+instance's CPU mask, while -EINVAL is a complaint about cb_cpu not being in the
+serial cpumask, no online CPUs in the parallel or serial cpumasks, or a stopped
+instance.
+
+Each job submitted to padata_do_parallel() will, in turn, be passed to
+exactly one call to the above-mentioned parallel() function, on one CPU, so
+true parallelism is achieved by submitting multiple jobs.  parallel() runs with
+software interrupts disabled and thus cannot sleep.  The parallel()
+function gets the padata_priv structure pointer as its lone parameter;
+information about the actual work to be done is probably obtained by using
+container_of() to find the enclosing structure.
+
+Note that parallel() has no return value; the padata subsystem assumes that
+parallel() will take responsibility for the job from this point.  The job
+need not be completed during this call, but, if parallel() leaves work
+outstanding, it should be prepared to be called again with a new job before
+the previous one completes.
+
+Serializing Jobs
+----------------
+
+When a job does complete, parallel() (or whatever function actually finishes
+the work) should inform padata of the fact with a call to::
+
+    void padata_do_serial(struct padata_priv *padata);
+
+At some point in the future, padata_do_serial() will trigger a call to the
+serial() function in the padata_priv structure.  That call will happen on
+the CPU requested in the initial call to padata_do_parallel(); it, too, is
+run with local software interrupts disabled.
+Note that this call may be deferred for a while since the padata code takes
+pains to ensure that jobs are completed in the order in which they were
+submitted.
+
+Destroying
+----------
+
+Cleaning up a padata instance predictably involves calling the three free
+functions that correspond to the allocation in reverse::
+
+    void padata_free_shell(struct padata_shell *ps);
+    void padata_stop(struct padata_instance *pinst);
+    void padata_free(struct padata_instance *pinst);
+
+It is the user's responsibility to ensure all outstanding jobs are complete
+before any of the above are called.
+
+Interface
+=========
+
+.. kernel-doc:: include/linux/padata.h
+.. kernel-doc:: kernel/padata.c
diff --git a/Documentation/padata.txt b/Documentation/padata.txt
deleted file mode 100644
index b45df9c6547b..000000000000
--- a/Documentation/padata.txt
+++ /dev/null
@@ -1,139 +0,0 @@
-=======================================
-The padata parallel execution mechanism
-=======================================
-
-:Last updated: for 2.6.36
-
-Padata is a mechanism by which the kernel can farm work out to be done in
-parallel on multiple CPUs while retaining the ordering of tasks.  It was
-developed for use with the IPsec code, which needs to be able to perform
-encryption and decryption on large numbers of packets without reordering
-those packets.  The crypto developers made a point of writing padata in a
-sufficiently general fashion that it could be put to other uses as well.
-
-The first step in using padata is to set up a padata_instance structure for
-overall control of how tasks are to be run::
-
-    #include <linux/padata.h>
-
-    struct padata_instance *padata_alloc(const char *name,
-					 const struct cpumask *pcpumask,
-					 const struct cpumask *cbcpumask);
-
-'name' simply identifies the instance.
-
-The pcpumask describes which processors will be used to execute work
-submitted to this instance in parallel. The cbcpumask defines which
-processors are allowed to be used as the serialization callback processor.
-The workqueue wq is where the work will actually be done; it should be
-a multithreaded queue, naturally.
-
-To allocate a padata instance with the cpu_possible_mask for both
-cpumasks this helper function can be used::
-
-    struct padata_instance *padata_alloc_possible(struct workqueue_struct *wq);
-
-Note: Padata maintains two kinds of cpumasks internally. The user supplied
-cpumasks, submitted by padata_alloc/padata_alloc_possible and the 'usable'
-cpumasks. The usable cpumasks are always a subset of active CPUs in the
-user supplied cpumasks; these are the cpumasks padata actually uses. So
-it is legal to supply a cpumask to padata that contains offline CPUs.
-Once an offline CPU in the user supplied cpumask comes online, padata
-is going to use it.
-
-There are functions for enabling and disabling the instance::
-
-    int padata_start(struct padata_instance *pinst);
-    void padata_stop(struct padata_instance *pinst);
-
-These functions are setting or clearing the "PADATA_INIT" flag;
-if that flag is not set, other functions will refuse to work.
-padata_start returns zero on success (flag set) or -EINVAL if the
-padata cpumask contains no active CPU (flag not set).
-padata_stop clears the flag and blocks until the padata instance
-is unused.
-
-The list of CPUs to be used can be adjusted with these functions::
-
-    int padata_set_cpumasks(struct padata_instance *pinst,
-			    cpumask_var_t pcpumask,
-			    cpumask_var_t cbcpumask);
-    int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
-			   cpumask_var_t cpumask);
-    int padata_add_cpu(struct padata_instance *pinst, int cpu, int mask);
-    int padata_remove_cpu(struct padata_instance *pinst, int cpu, int mask);
-
-Changing the CPU masks are expensive operations, though, so it should not be
-done with great frequency.
-
-It's possible to change both cpumasks of a padata instance with
-padata_set_cpumasks by specifying the cpumasks for parallel execution (pcpumask)
-and for the serial callback function (cbcpumask). padata_set_cpumask is used to
-change just one of the cpumasks. Here cpumask_type is one of PADATA_CPU_SERIAL,
-PADATA_CPU_PARALLEL and cpumask specifies the new cpumask to use.
-To simply add or remove one CPU from a certain cpumask the functions
-padata_add_cpu/padata_remove_cpu are used. cpu specifies the CPU to add or
-remove and mask is one of PADATA_CPU_SERIAL, PADATA_CPU_PARALLEL.
-
-Actually submitting work to the padata instance requires the creation of a
-padata_priv structure::
-
-    struct padata_priv {
-        /* Other stuff here... */
-	void                    (*parallel)(struct padata_priv *padata);
-	void                    (*serial)(struct padata_priv *padata);
-    };
-
-This structure will almost certainly be embedded within some larger
-structure specific to the work to be done.  Most of its fields are private to
-padata, but the structure should be zeroed at initialisation time, and the
-parallel() and serial() functions should be provided.  Those functions will
-be called in the process of getting the work done as we will see
-momentarily.
-
-The submission of work is done with::
-
-    int padata_do_parallel(struct padata_instance *pinst,
-		           struct padata_priv *padata, int cb_cpu);
-
-The pinst and padata structures must be set up as described above; cb_cpu
-specifies which CPU will be used for the final callback when the work is
-done; it must be in the current instance's CPU mask.  The return value from
-padata_do_parallel() is zero on success, indicating that the work is in
-progress. -EBUSY means that somebody, somewhere else is messing with the
-instance's CPU mask, while -EINVAL is a complaint about cb_cpu not being
-in that CPU mask or about a not running instance.
-
-Each task submitted to padata_do_parallel() will, in turn, be passed to
-exactly one call to the above-mentioned parallel() function, on one CPU, so
-true parallelism is achieved by submitting multiple tasks.  parallel() runs with
-software interrupts disabled and thus cannot sleep.  The parallel()
-function gets the padata_priv structure pointer as its lone parameter;
-information about the actual work to be done is probably obtained by using
-container_of() to find the enclosing structure.
-
-Note that parallel() has no return value; the padata subsystem assumes that
-parallel() will take responsibility for the task from this point.  The work
-need not be completed during this call, but, if parallel() leaves work
-outstanding, it should be prepared to be called again with a new job before
-the previous one completes.  When a task does complete, parallel() (or
-whatever function actually finishes the job) should inform padata of the
-fact with a call to::
-
-    void padata_do_serial(struct padata_priv *padata);
-
-At some point in the future, padata_do_serial() will trigger a call to the
-serial() function in the padata_priv structure.  That call will happen on
-the CPU requested in the initial call to padata_do_parallel(); it, too, is
-run with local software interrupts disabled.
-Note that this call may be deferred for a while since the padata code takes
-pains to ensure that tasks are completed in the order in which they were
-submitted.
-
-The one remaining function in the padata API should be called to clean up
-when a padata instance is no longer needed::
-
-    void padata_free(struct padata_instance *pinst);
-
-This function will busy-wait while any remaining tasks are completed, so it
-might be best not to call it while there is work outstanding.
diff --git a/include/linux/padata.h b/include/linux/padata.h
index faa2e36832f8..a0d8b41850b2 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -19,7 +19,7 @@
 #define PADATA_CPU_PARALLEL 0x02
 
 /**
- * struct padata_priv -  Embedded to the users data structure.
+ * struct padata_priv - Represents one job
  *
  * @list: List entry, to attach to the padata lists.
  * @pd: Pointer to the internal control structure.
@@ -42,7 +42,7 @@ struct padata_priv {
 };
 
 /**
- * struct padata_list
+ * struct padata_list - one per work type per CPU
  *
  * @list: List head.
  * @lock: List lock.
@@ -70,9 +70,6 @@ struct padata_serial_queue {
  *
  * @parallel: List to wait for parallelization.
  * @reorder: List to wait for reordering after parallel processing.
- * @serial: List to wait for serialization after reordering.
- * @pwork: work struct for parallelization.
- * @swork: work struct for serialization.
  * @work: work struct for parallelization.
  * @num_obj: Number of objects that are processed by this cpu.
  */
@@ -98,11 +95,11 @@ struct padata_cpumask {
  * struct parallel_data - Internal control structure, covers everything
  * that depends on the cpumask in use.
  *
- * @sh: padata_shell object.
+ * @ps: padata_shell object.
  * @pqueue: percpu padata queues used for parallelization.
  * @squeue: percpu padata queues used for serialuzation.
  * @refcnt: Number of objects holding a reference on this parallel_data.
- * @max_seq_nr:  Maximal used sequence number.
+ * @seq_nr: Sequence number of the parallelized data object.
  * @processed: Number of already processed objects.
  * @cpu: Next CPU to be processed.
  * @cpumask: The cpumasks in use for parallel and serial workers.
@@ -119,7 +116,7 @@ struct parallel_data {
 	int				cpu;
 	struct padata_cpumask		cpumask;
 	struct work_struct		reorder_work;
-	spinlock_t                      lock ____cacheline_aligned;
+	spinlock_t                      ____cacheline_aligned lock;
 };
 
 /**
@@ -142,7 +139,7 @@ struct padata_shell {
 /**
  * struct padata_instance - The overall control structure.
  *
- * @cpu_notifier: cpu hotplug notifier.
+ * @node: Used by CPU hotplug.
  * @parallel_wq: The workqueue used for parallel work.
  * @serial_wq: The workqueue used for serial work.
  * @pslist: List of padata_shell objects attached to this instance.
diff --git a/kernel/padata.c b/kernel/padata.c
index 2aaf677db85c..376e5d8d1c5c 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -2,7 +2,7 @@
 /*
  * padata.c - generic interface to process data streams in parallel
  *
- * See Documentation/padata.txt for an api documentation.
+ * See Documentation/core-api/padata.rst for more information.
  *
  * Copyright (C) 2008, 2009 secunet Security Networks AG
  * Copyright (C) 2008, 2009 Steffen Klassert <steffen.klassert@secunet.com>
@@ -99,6 +99,8 @@ static void padata_parallel_worker(struct work_struct *parallel_work)
  * The parallelization callback function will run with BHs off.
  * Note: Every object which is parallelized by padata_do_parallel
  * must be seen by padata_do_serial.
+ *
+ * Return: 0 on success or else negative error code.
  */
 int padata_do_parallel(struct padata_shell *ps,
 		       struct padata_priv *padata, int *cb_cpu)
@@ -163,14 +165,12 @@ EXPORT_SYMBOL(padata_do_parallel);
 /*
  * padata_find_next - Find the next object that needs serialization.
  *
- * Return values are:
- *
- * A pointer to the control struct of the next object that needs
- * serialization, if present in one of the percpu reorder queues.
- *
- * NULL, if the next object that needs serialization will
- *  be parallel processed by another cpu and is not yet present in
- *  the cpu's reorder queue.
+ * Return:
+ * * A pointer to the control struct of the next object that needs
+ *   serialization, if present in one of the percpu reorder queues.
+ * * NULL, if the next object that needs serialization will
+ *   be parallel processed by another cpu and is not yet present in
+ *   the cpu's reorder queue.
  */
 static struct padata_priv *padata_find_next(struct parallel_data *pd,
 					    bool remove_object)
@@ -582,13 +582,14 @@ static int __padata_set_cpumasks(struct padata_instance *pinst,
 }
 
 /**
- * padata_set_cpumask: Sets specified by @cpumask_type cpumask to the value
- *                     equivalent to @cpumask.
- *
+ * padata_set_cpumask - Sets specified by @cpumask_type cpumask to the value
+ *                      equivalent to @cpumask.
  * @pinst: padata instance
  * @cpumask_type: PADATA_CPU_SERIAL or PADATA_CPU_PARALLEL corresponding
  *                to parallel and serial cpumasks respectively.
  * @cpumask: the cpumask to use
+ *
+ * Return: 0 on success or negative error code
  */
 int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
 		       cpumask_var_t cpumask)
@@ -626,6 +627,8 @@ EXPORT_SYMBOL(padata_set_cpumask);
  * padata_start - start the parallel processing
  *
  * @pinst: padata instance to start
+ *
+ * Return: 0 on success or negative error code
  */
 int padata_start(struct padata_instance *pinst)
 {
@@ -880,6 +883,8 @@ static struct kobj_type padata_attr_type = {
  * @name: used to identify the instance
  * @pcpumask: cpumask that will be used for padata parallelization
  * @cbcpumask: cpumask that will be used for padata serialization
+ *
+ * Return: new instance on success, NULL on error
  */
 static struct padata_instance *padata_alloc(const char *name,
 					    const struct cpumask *pcpumask,
@@ -967,6 +972,8 @@ static struct padata_instance *padata_alloc(const char *name,
  *                         parallel workers.
  *
  * @name: used to identify the instance
+ *
+ * Return: new instance on success, NULL on error
  */
 struct padata_instance *padata_alloc_possible(const char *name)
 {
@@ -977,7 +984,7 @@ EXPORT_SYMBOL(padata_alloc_possible);
 /**
  * padata_free - free a padata instance
  *
- * @padata_inst: padata instance to free
+ * @pinst: padata instance to free
  */
 void padata_free(struct padata_instance *pinst)
 {
@@ -989,6 +996,8 @@ EXPORT_SYMBOL(padata_free);
  * padata_alloc_shell - Allocate and initialize padata shell.
  *
  * @pinst: Parent padata_instance object.
+ *
+ * Return: new shell on success, NULL on error
  */
 struct padata_shell *padata_alloc_shell(struct padata_instance *pinst)
 {
-- 
2.24.0

