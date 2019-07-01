Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF56B394F1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 20:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfFGS4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 14:56:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732071AbfFGSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=78L7zd88IqXfMHKxzazz3S43SQAX6wKuWyWb6jrb4ew=; b=q7aY4MVborpafsU7iQgHjHtkE6
        nKvF1RG43TkIakvK3tqiv9jzPrSU6bdLzVsqRTI8VSG8XBdHX3TQM2JPpY9fVoIwa9r4AgWUg8tYI
        Xd0h1f757oVGPwY9nGms8KQzEEcU7K8miOIhDfq5b2dcjVdkAf/TGfGlgsQoUv9/BGA/+frttZUfv
        Sjs/qHB574OjEscU8USL4AwDmyrLZUjdiYu5hV/C8oiueNpxQS2jUnvzfUA9dfnDkyT6xoQyo0FQX
        P6BCyONO2QA6kTPhgV8xDvgbdneuiVkGhiPwcdsBoa/zQFX+57fs2ZC643MvK27LCxnT1DoM0uz+d
        SWPEueBw==;
Received: from [179.181.119.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZK0d-0005se-JN; Fri, 07 Jun 2019 18:54:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZK0b-0007Ea-8r; Fri, 07 Jun 2019 15:54:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v3 03/20] docs: zh_CN: get rid of basic_profiling.txt
Date:   Fri,  7 Jun 2019 15:54:19 -0300
Message-Id: <5763c80f208b4943cf487d2224f8fd32fb1c9bc9.1559933665.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 5700d1974818 ("docs: Get rid of the "basic profiling" guide")
removed an old basic-profiling.txt file that was not updated over
the last 11 years and won't reflect the post-perf era.

It makes no sense to keep its translation, so get rid of it too.

Fixes: 5700d1974818 ("docs: Get rid of the "basic profiling" guide")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Alex Shi <alex.shi@linux.alibaba.com>
---
 .../translations/zh_CN/basic_profiling.txt    | 71 -------------------
 1 file changed, 71 deletions(-)
 delete mode 100644 Documentation/translations/zh_CN/basic_profiling.txt

diff --git a/Documentation/translations/zh_CN/basic_profiling.txt b/Documentation/translations/zh_CN/basic_profiling.txt
deleted file mode 100644
index 1e6bf0bdf8f5..000000000000
--- a/Documentation/translations/zh_CN/basic_profiling.txt
+++ /dev/null
@@ -1,71 +0,0 @@
-Chinese translated version of Documentation/basic_profiling
-
-If you have any comment or update to the content, please post to LKML directly.
-However, if you have problem communicating in English you can also ask the
-Chinese maintainer for help.  Contact the Chinese maintainer, if this
-translation is outdated or there is problem with translation.
-
-Chinese maintainer: Liang Xie <xieliang@xiaomi.com>
----------------------------------------------------------------------
-Documentation/basic_profiling的中文翻译
-
-如果想评论或更新本文的内容，请直接发信到LKML。如果你使用英文交流有困难的话，也可
-以向中文版维护者求助。如果本翻译更新不及时或者翻译存在问题，请联系中文版维护者。
-
-中文版维护者： 谢良 Liang Xie <xieliang007@gmail.com>
-中文版翻译者： 谢良 Liang Xie <xieliang007@gmail.com>
-中文版校译者：
-以下为正文
----------------------------------------------------------------------
-
-下面这些说明指令都是非常基础的，如果你想进一步了解请阅读相关专业文档：）
-请不要再在本文档增加新的内容，但可以修复文档中的错误：）(mbligh@aracnet.com)
-感谢John Levon，Dave Hansen等在撰写时的帮助
-
-<test> 用于表示要测量的目标
-请先确保您已经有正确的System.map / vmlinux配置！
-
-对于linux系统来说，配置vmlinuz最容易的方法可能就是使用“make install”，然后修改
-/sbin/installkernel将vmlinux拷贝到/boot目录，而System.map通常是默认安装好的
-
-Readprofile
------------
-2.6系列内核需要版本相对较新的readprofile，比如util-linux 2.12a中包含的，可以从:
-
-http://www.kernel.org/pub/linux/utils/util-linux/ 下载
-
-大部分linux发行版已经包含了.
-
-启用readprofile需要在kernel启动命令行增加”profile=2“
-
-clear		readprofile -r
-		<test>
-dump output	readprofile -m /boot/System.map > captured_profile
-
-Oprofile
---------
-
-从http://oprofile.sourceforge.net/获取源代码（请参考Changes以获取匹配的版本）
-在kernel启动命令行增加“idle=poll”
-
-配置CONFIG_PROFILING=y和CONFIG_OPROFILE=y然后重启进入新kernel
-
-./configure --with-kernel-support
-make install
-
-想得到好的测量结果，请确保启用了本地APIC特性。如果opreport显示有0Hz CPU，
-说明APIC特性没有开启。另外注意idle=poll选项可能有损性能。
-
-One time setup:
-		opcontrol --setup --vmlinux=/boot/vmlinux
-
-clear		opcontrol --reset
-start		opcontrol --start
-		<test>
-stop		opcontrol --stop
-dump output	opreport >  output_file
-
-如果只看kernel相关的报告结果，请运行命令 opreport -l /boot/vmlinux > output_file
-
-通过reset选项可以清理过期统计数据，相当于重启的效果。
-
-- 
2.21.0

