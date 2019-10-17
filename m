Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF1D6DAAC0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 13:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393417AbfJQLCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 07:02:32 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:52506 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393253AbfJQLCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:02:32 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iL3Y3-0002YT-Ar; Thu, 17 Oct 2019 12:02:27 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iL3Y2-00082E-TZ; Thu, 17 Oct 2019 12:02:26 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: make gfs2_fs_parameters static
Date:   Thu, 17 Oct 2019 12:02:25 +0100
Message-Id: <20191017110225.30841-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gfs2_fs_parameters is not used outside the unit
it is declared in, so make it static.

Fixes the following sparse warning:

fs/gfs2/ops_fstype.c:1331:39: warning: symbol 'gfs2_fs_parameters' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
---
 fs/gfs2/ops_fstype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 681b44682b0d..ebdef1c5f580 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1328,7 +1328,7 @@ static const struct fs_parameter_enum gfs2_param_enums[] = {
 	{}
 };
 
-const struct fs_parameter_description gfs2_fs_parameters = {
+static const struct fs_parameter_description gfs2_fs_parameters = {
 	.name = "gfs2",
 	.specs = gfs2_param_specs,
 	.enums = gfs2_param_enums,
-- 
2.23.0

