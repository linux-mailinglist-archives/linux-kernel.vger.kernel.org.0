Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6611F34A1F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 16:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfFDOTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 10:19:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfFDOSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=49OX8NmvmI055r/OXImGhv4c7c/FNWltAI84LJFVh/A=; b=fi4odz0CcZkQgAroB59pt3fkKR
        YOlYGx+2Khehitc5h84rSj9HrV2itUypVSSnL0uVn0lCrA38rF20ogqiYo0uFOahLKxVfV3SMmFay
        cekZdnv4H+I7N8o19U5SycWaX3OXQBpcGPcteYjhKgQ6GKDLkkOtNukpXOwZvh0akIww516rMyTFF
        MXbe0H8KPm9VyDKITothwl7CfjI0702MUTdANFBs5mZH/F36mrL0GVJbJOKBWSJV4y1Bdn3yMecQt
        9XlqQQUz8K2XWPm7ylvRXE0MAviOkDshVO2E9ntL35ZnSZK8sLKIrjEEJex2o+jKDpIDYSeT9wY4n
        iP/ANkTQ==;
Received: from [179.182.172.34] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYAGH-0001Ri-UA; Tue, 04 Jun 2019 14:18:01 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hYAGE-0002lF-OP; Tue, 04 Jun 2019 11:17:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org
Subject: [PATCH v2 10/22] docs: vm: hmm.rst: fix some warnings
Date:   Tue,  4 Jun 2019 11:17:44 -0300
Message-Id: <ee4ae1fd9119e1a69b80ccea8ed642b18e3d0eb2.1559656538.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559656538.git.mchehab+samsung@kernel.org>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Documentation/vm/hmm.rst:292: WARNING: Unexpected indentation.
    Documentation/vm/hmm.rst:300: WARNING: Unexpected indentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/vm/hmm.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 7cdf7282e022..f22bb5fb5eec 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -283,7 +283,8 @@ The hmm_range struct has 2 fields default_flags and pfn_flags_mask that allows
 to set fault or snapshot policy for a whole range instead of having to set them
 for each entries in the range.
 
-For instance if the device flags for device entries are:
+For instance if the device flags for device entries are::
+
     VALID (1 << 63)
     WRITE (1 << 62)
 
-- 
2.21.0

