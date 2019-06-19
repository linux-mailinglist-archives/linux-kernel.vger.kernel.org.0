Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D32E44B857
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 14:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbfFSMas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 08:30:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50840 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731898AbfFSMaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so1588649wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z4INWegdUTe8Q6ns0c8f39S93Wy18nSWojE+tUkgp2w=;
        b=dmcHhDdGipAdmz/1MG7f4Ebjq8eJXFiz/14wjsDXSmoX1BRzeRdt2PJBya7G36QwlE
         GgdxlfaRJA6ch0awPlzHe3vlSQQemxVxaycr5VmZ53QovjDPjp2Qh41afFp33nliKWnr
         unmD2Hr2MBopJFayVifiKD+ApO/JGZGVjNwobfG0UhjWwPJM4D0R7uChYOqwkyDcotDQ
         jXRJHjslfR/hoWwX45TishLQ64c+QPmkbnyU1VF4o7bIb2Ms1zDof7vZmbNZx4APxq2Q
         /UznDeZ94T3iIqMF67xvHiBRLU3zPkWKoElEy3na0XpmlYMofx1Od269bBVcmV2i4aYN
         7FqA==
X-Gm-Message-State: APjAAAXzN7x1fX3WN/vbwH3t30u6jlXsFzGS+x8Ij0MsrNSdyDUb7Dxf
        xvQlOowWnkCC9vnqP5pnVNNexQ==
X-Google-Smtp-Source: APXvYqwjHs6lmB/m746hPFbtEy06SjhOEIMC6yffNLPHqQEgXE5XeQUFxlR0BzlXmc26vAqECvSlhg==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr7804571wmk.99.1560947444548;
        Wed, 19 Jun 2019 05:30:44 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:43 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] fusectl: don't ignore options
Date:   Wed, 19 Jun 2019 14:30:18 +0200
Message-Id: <20190619123019.30032-12-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The options "sync", "async", "dirsync", "lazytime", "nolazytime", "mand"
and "nomand" make no sense for the fusectl filesystem.  If these options
are supplied to fsconfig(FSCONFIG_SET_FLAG), then return -EINVAL instead of
silently ignoring the option.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index c35013ed7f65..f3aab288929f 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -351,7 +351,7 @@ static int fuse_ctl_get_tree(struct fs_context *fc)
 
 static const struct fs_context_operations fuse_ctl_context_ops = {
 	.get_tree	= fuse_ctl_get_tree,
-	.parse_param	= vfs_parse_fs_param,
+	.parse_param	= vfs_parse_ro_rw,
 };
 
 static int fuse_ctl_init_fs_context(struct fs_context *fc)
-- 
2.21.0

