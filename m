Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF89E7721F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 21:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfGZT3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 15:29:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfGZT3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m8kf/sPEYGMDUeP6JoO5tSRSz84bxy3DCh0yf5UUIs0=; b=CelJnS/c4Xzu7s5d91k3foSXuG
        UQh6mku33sviwqWU2K6acBiqmR5Y0FhNi5DwcAO9T/KorPIFMd9PLDz/UECUpFx90TS7oZFOFnWxR
        liK7HAzFQq63s3NX6rfwaobmqbN/47fZ6UYLXuX2AFPkn1rLNIRYy0micCfJxfgCSdyCmYSg7BluF
        uDsgdBP1l0oWDTVKXLzt7pA6WxX6jmJy1ASd070RTjlFmVhk8LXNp8IDgWB9gcaP56Lb30GuNk+95
        0kTIl3Qvi6Cmk9cT8OSpfE2meXGVNyl3KTr/Fwcfo4BtVwqlcKpktAeUvw9D4R27gTCDvJp4T7CG/
        ggcLft/A==;
Received: from [179.95.31.157] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr5u1-00046s-TI; Fri, 26 Jul 2019 19:29:17 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hr5tz-0004yq-MW; Fri, 26 Jul 2019 16:29:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH 5/5] docs: zh_CN: howto.rst: fix a broken reference
Date:   Fri, 26 Jul 2019 16:29:14 -0300
Message-Id: <36ee207d43dd40be23639a3b00de4216a8465624.1564169297.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <5c44856436bbaeb4f2d4b750365b82de973ad054.1564169297.git.mchehab+samsung@kernel.org>
References: <5c44856436bbaeb4f2d4b750365b82de973ad054.1564169297.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a broken reference there pointing to the long gone
DocBook dir.

While I don't read chinese, Google translator translates it
to:
	"The generated documentation will be placed in
	 the Documentation/DocBook/ directory."

Well, we know that the output will be Documentation/output
dir. So, let's fix this one.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/translations/zh_CN/process/howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index 5b671178b17b..c4ff8356b88d 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -147,7 +147,7 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
     关于补丁是什么以及如何将它打在不同内核开发分支上的好介绍
 
 内核还拥有大量从代码自动生成的文档。它包含内核内部API的全面介绍以及如何
-妥善处理加锁的规则。生成的文档会放在 Documentation/DocBook/目录下。在内
+妥善处理加锁的规则。生成的文档会放在 Documentation/output/目录下。在内
 核源码的主目录中使用以下不同命令将会分别生成PDF、Postscript、HTML和手册
 页等不同格式的文档::
 
-- 
2.21.0

