Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 931194F76B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 19:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfFVRcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 13:32:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbfFVRcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 13:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b6XBxGFGl5Yt+YXrYJbw/bdsKoxYS+kJOBPAVkYYz4g=; b=FPE98V2JG1eSjoBOq8IbYOpXLY
        Y5jhIBZuLtIh3i6RIR8ZfValTiyuhC95hRiOliSLxLoGUaq+soMMhHoBipFIVinbsgUVBZOmhQlM9
        Hcl/CdCc4kd0CNAhk92eGWEgYx+nSg4BwNp/mklpPnxU3yhvNKXyoHo1hkodhnCnCaQQGWJ4IqDJ+
        zAV4mAzKlnxu59X31qaqyST7AIRLdC/AaYGv2ESSqlaGE69x15Ux/Y9LA2felwx5YxilbCmDoMiZb
        iBlN0sVdpFAd3Emun2gxus6BeZAsi3zWq92wdBzM9zjt6EHO3Pb07Nm6uq4K0Yy3IWEYLAkq0i5ze
        vv8myUtg==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejrs-00076l-Aj; Sat, 22 Jun 2019 17:32:00 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejrq-0001Hb-BT; Sat, 22 Jun 2019 14:31:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [RFC v2 7/8] docs: abi-testing.rst: enable --rst-sources when building docs
Date:   Sat, 22 Jun 2019 14:31:55 -0300
Message-Id: <2aa802bb34d83a4b4b46c61deaa1c62f1f08b494.1561224093.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561224093.git.mchehab+samsung@kernel.org>
References: <cover.1561224093.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ABI/testing documents were fixed, add --rst-sources to
the ABI/testing too.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/abi-testing.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/abi-testing.rst b/Documentation/admin-guide/abi-testing.rst
index 5c886fc50b9e..b205b16a72d0 100644
--- a/Documentation/admin-guide/abi-testing.rst
+++ b/Documentation/admin-guide/abi-testing.rst
@@ -17,3 +17,4 @@ name to the description of these interfaces, so that the kernel
 developers can easily notify them if any changes occur.
 
 .. kernel-abi:: $srctree/Documentation/ABI/testing
+   :rst:
-- 
2.21.0

