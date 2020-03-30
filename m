Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 421C0197DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 16:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgC3OGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 10:06:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27534 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726981AbgC3OGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585577190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=6gQMdKyxolj/mpbgItMNlKheqVPkOjcF0N0K4kdp9rc=;
        b=BhfkRIhSLCVLH/LRFzw1PpBeZ2GBf9s9L8KxJKbmSX8hiy9E3HiGn5ZYA3QY5Oi3+9gUGA
        8XPR+c3OIwL87u0ski6K0YEdhbIwZlrNNveHOQyh2ss07Lyc+M0WhXyVfUl1nzCFpzYEeX
        TwJYVl42IF7hocu2mEOXi1OgNsKNz6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-sLoEzOxENUez8D-VYyvFDg-1; Mon, 30 Mar 2020 10:06:28 -0400
X-MC-Unique: sLoEzOxENUez8D-VYyvFDg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B968FDB61;
        Mon, 30 Mar 2020 14:06:26 +0000 (UTC)
Received: from llong.com (ovpn-116-140.rdu2.redhat.com [10.10.116.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DA9648;
        Mon, 30 Mar 2020 14:06:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Sonny Rao <sonnyrao@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] docs: cgroup-v1: Document the cpuset_v2_mode mount option
Date:   Mon, 30 Mar 2020 10:06:15 -0400
Message-Id: <20200330140615.25549-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpuset in cgroup v1 accepts a special "cpuset_v2_mode" mount
option that make cpuset.cpus and cpuset.mems behave more like those in
cgroup v2.  Document it to make other people more aware of this feature
that can be useful in some circumstances.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v1/cpusets.rst | 11 +++++++++++
 kernel/cgroup/cpuset.c                          |  8 ++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
index 86a6ae995d54..7ade3abd342a 100644
--- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
+++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
@@ -223,6 +223,17 @@ cpu_online_mask using a CPU hotplug notifier, and the mems file
 automatically tracks the value of node_states[N_MEMORY]--i.e.,
 nodes with memory--using the cpuset_track_online_nodes() hook.
 
+The cpuset.effective_cpus and cpuset.effective_mems files are
+normally read-only copies of cpuset.cpus and cpuset.mems files
+respectively.  If the cpuset cgroup filesystem is mounted with the
+special "cpuset_v2_mode" option, the behavior of these files will become
+similar to the corresponding files in cpuset v2.  In other words, hotplug
+events will not change cpuset.cpus and cpuset.mems.  Those events will
+only affect cpuset.effective_cpus and cpuset.effective_mems which show
+the actual cpus and memory nodes that are currently used by this cpuset.
+See Documentation/admin-guide/cgroup-v2.rst for more information about
+cpuset v2 behavior.
+
 
 1.4 What are exclusive cpusets ?
 --------------------------------
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58f5073acff7..729d3a5c772e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -358,8 +358,12 @@ static DECLARE_WORK(cpuset_hotplug_work, cpuset_hotplug_workfn);
 static DECLARE_WAIT_QUEUE_HEAD(cpuset_attach_wq);
 
 /*
- * Cgroup v2 behavior is used when on default hierarchy or the
- * cgroup_v2_mode flag is set.
+ * Cgroup v2 behavior is used on the "cpus" and "mems" control files when
+ * on default hierarchy or when the cpuset_v2_mode flag is set by mounting
+ * the v1 cpuset cgroup filesystem with the "cpuset_v2_mode" mount option.
+ * With v2 behavior, "cpus" and "mems" are always what the users have
+ * requested and won't be changed by hotplug events. Only the effective
+ * cpus or mems will be affected.
  */
 static inline bool is_in_v2_mode(void)
 {
-- 
2.18.1

