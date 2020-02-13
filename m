Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C6B15C9E8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 19:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgBMSGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 13:06:19 -0500
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:55275 "EHLO
        13.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMSGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:06:19 -0500
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 13:06:19 EST
Received: from player715.ha.ovh.net (unknown [10.110.171.5])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id B10581AF052
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 18:48:56 +0100 (CET)
Received: from sk2.org (cre33-1_migr-88-122-126-116.fbx.proxad.net [88.122.126.116])
        (Authenticated sender: steve@sk2.org)
        by player715.ha.ovh.net (Postfix) with ESMTPSA id 865B7F2A671A;
        Thu, 13 Feb 2020 17:48:45 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH 4/6] docs: add missing IPC documentation in sysctl/kernel.rst
Date:   Thu, 13 Feb 2020 18:46:59 +0100
Message-Id: <20200213174701.3200366-5-steve@sk2.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213174701.3200366-1-steve@sk2.org>
References: <20200213174701.3200366-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10090314967056797061
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrieekgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucfkpheptddrtddrtddrtddpkeekrdduvddvrdduvdeirdduudeinecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeduhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds short descriptions of msgmax, msgmnb, msgmni, and shmmni,
which were previously listed in kernel.rst but not described.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 9221366901af..29a712e24610 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -413,6 +413,15 @@ to false.  Generally used with the `kexec_load_disabled`_ toggle.
 msgmax, msgmnb, and msgmni
 ==========================
 
+``msgmax`` is the maximum size of an IPC message, in bytes. 8192 by
+default (``MSGMAX``).
+
+``msgmnb`` is the maximum size of an IPC queue, in bytes. 16384 by
+default (``MSGMNB``).
+
+``msgmni`` is the maximum number of IPC queues. 32000 by default
+(``MSGMNI``).
+
 
 msg_next_id, sem_next_id, and shm_next_id (System V IPC)
 ========================================================
@@ -961,6 +970,9 @@ kernel.  This value defaults to ``SHMMAX``.
 shmmni
 ======
 
+This value determines the maximum number of shared memory segments.
+4096 by default (``SHMMNI``).
+
 
 shm_rmid_forced
 ===============
-- 
2.24.1

