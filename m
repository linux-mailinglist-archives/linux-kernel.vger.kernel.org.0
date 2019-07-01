Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7B723AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 16:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392041AbfETOsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 10:48:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34542 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388786AbfETOsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t7V/jAIyRWeGVCJDZeH1LhdUcZQK43LHg68xT8DRQOM=; b=LmVRQ3gzj8VtszQFIgX67ROzsl
        6/iqi/nAxzLJFkuTvQx+5veHrB3XqNeUdUcJoUZ0s8/r+mZwDbz+3hGnmxQDUxv7PS+OXYTb8thTs
        bKly2jX/THGWlIGrkYIWjBcNDRJgLM0pTBnY6JxqoxYp1UEhtRUBSso4f/5CxyIdIs1y+37saY7xk
        fF9lHbelfjtF9BTGq3kT2fGJ/yNY+VMXP5qvWL1Ig/3qvD0TKljWbcT6LqSJKIPD8JhBqZhSvd430
        VTvaShLjgwnPjrQp9qj1fs1kPjZVf6w4jZkC2wLj97R+GswRdv+HUWjQrtliCUmfSvyvi7iy+IjSy
        Hj/IIAbQ==;
Received: from [179.176.119.151] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSja3-0000E4-Rv; Mon, 20 May 2019 14:47:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hSjZq-00010m-5v; Mon, 20 May 2019 11:47:46 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 03/10] scripts/documentation-file-ref-check: improve tools ref handling
Date:   Mon, 20 May 2019 11:47:32 -0300
Message-Id: <f8e2c31af50adea864711a000d3f628f139f8df4.1558362030.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558362030.git.mchehab+samsung@kernel.org>
References: <cover.1558362030.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a false positive on perf/util:

	tools/perf/util/s390-cpumsf.c: Documentation/perf.data-file-format.txt

The file is there at tools/perf/Documentation/, but the logic
with detects relative documentation references inside tools is
not capable of detecting it.

So, improve it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/documentation-file-ref-check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
index 05235775cc71..5d775ca7469b 100755
--- a/scripts/documentation-file-ref-check
+++ b/scripts/documentation-file-ref-check
@@ -127,7 +127,7 @@ while (<IN>) {
 		if ($f =~ m/tools/) {
 			my $path = $f;
 			$path =~ s,(.*)/.*,$1,;
-			next if (grep -e, glob("$path/$ref $path/$fulref"));
+			next if (grep -e, glob("$path/$ref $path/../$ref $path/$fulref"));
 		}
 
 		# Discard known false-positives
-- 
2.21.0

