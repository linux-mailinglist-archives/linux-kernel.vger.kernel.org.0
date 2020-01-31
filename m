Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9C1514ED8D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 14:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgAaNkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 08:40:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41691 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728500AbgAaNkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580478023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T6e7+pBofYnjt3QldY4qP4iltFIflxkf4jWXjfI4xjQ=;
        b=YDAHZwhl/HtlhSVU/mDbJbYpuCmJOwY+UpeXXR+m/3GJXN42qIS9INbRgBfXZZhYZO9bcP
        Z3d+XMq7c4R++1/6I9fqsfuYH/FjqKLRE6/Z8C+VnfYzqP0NcP+kg/C4p1ZtcMHTjoqoea
        pohaWKqX/VfS+oqoJMbKleua95/gwPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-GLbc3fSPMJStbPrSFTZl1g-1; Fri, 31 Jan 2020 08:40:21 -0500
X-MC-Unique: GLbc3fSPMJStbPrSFTZl1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D115C1800D41
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 13:40:19 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93DA58883F;
        Fri, 31 Jan 2020 13:40:18 +0000 (UTC)
From:   xiubli@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     Xiubo Li <xiubli@redhat.com>
Subject: [RFC PATCH] seq_file: Introduce DEFINE_RW_ATTRIBUTE() helper macro
Date:   Fri, 31 Jan 2020 08:40:09 -0500
Message-Id: <20200131134009.14581-1-xiubli@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

It's time to introduce the DEFINE_RW_ATTRIBUTE() helper macro, this
would be useful for current users, there are many places are doing
the duplicated works. This could decrease code duplication.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 include/linux/seq_file.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 5998e1f4ff06..9e0c10a5aa4a 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -160,6 +160,21 @@ static const struct file_operations __name ## _fops =
=3D {			\
 	.release	=3D single_release,				\
 }
=20
+#define DEFINE_RW_ATTRIBUTE(__name)					\
+static int __name ## _open(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, __name ## _show, inode->i_private);	\
+}									\
+									\
+static const struct file_operations __name ## _fops =3D {			\
+	.owner		=3D THIS_MODULE,					\
+	.open		=3D __name ## _open,				\
+	.read		=3D seq_read,					\
+	.write		=3D __name ## _store,				\
+	.llseek		=3D seq_lseek,					\
+	.release	=3D single_release,				\
+}
+
 static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
 {
 #ifdef CONFIG_USER_NS
--=20
2.21.0

