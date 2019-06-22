Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A50A44F77A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 19:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfFVRcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 13:32:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfFVRcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 13:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ra0xbYPSU+4H3pFb2eOnhM3NB1hvssFTkUjTKCV0aRM=; b=Uvpvucfg0+ovXQDKJRAUWClzuh
        UYP9WjcxSuROyqDb3gP2QHRT8ND68+xuoRz3R34BoSvHzBGLuSpc98XqfeIP4Cd2JWK23RxrG0DHl
        wjJxCnsoswrV6LLJa1qbn2DOqUhIk04XYzvOf6iATnWYUbq98UD44dJlPNCNVcXq8aTlVMW9FcM2k
        bJHOdRD/Wy5RfbZ4DYfHt+X7kq+wxEdpllM9ix2wCL6Kawy9EuGSDWRN65yZ6N/7SXokBrpRQwS4J
        uUOGbAZu3c5RsSVVKdDwlC4mmpUfaumIKtSBcBZ4w2kFL439lO30fr71+b0o8zkOb+QDPDfvIEJw/
        vRapRmpg==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejrs-00076j-8T; Sat, 22 Jun 2019 17:32:00 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejrq-0001HR-9C; Sat, 22 Jun 2019 14:31:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [RFC v2 5/8] docs: ABI: create a 2-depth index for ABI
Date:   Sat, 22 Jun 2019 14:31:53 -0300
Message-Id: <e2b9be336c940f2087ed21bb59b5a0c488b97467.1561224093.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561224093.git.mchehab+samsung@kernel.org>
References: <cover.1561224093.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That helps to identify what ABI files are adding titles.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/abi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/abi.rst b/Documentation/admin-guide/abi.rst
index 3b9645c77469..bcab3ef2597c 100644
--- a/Documentation/admin-guide/abi.rst
+++ b/Documentation/admin-guide/abi.rst
@@ -3,7 +3,7 @@ Linux ABI description
 =====================
 
 .. toctree::
-   :maxdepth: 1
+   :maxdepth: 2
 
    abi-stable
    abi-testing
-- 
2.21.0

