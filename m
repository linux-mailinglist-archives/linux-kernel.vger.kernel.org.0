Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 279671888CC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 16:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgCQPNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 11:13:25 -0400
Received: from out28-170.mail.aliyun.com ([115.124.28.170]:42579 "EHLO
        out28-170.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgCQPNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:13:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2770793|-1;CH=green;DM=||false|;DS=CONTINUE|ham_system_inform|0.390991-0.00620451-0.602804;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03268;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.H0zKH5l_1584457917;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.H0zKH5l_1584457917)
          by smtp.aliyun-inc.com(10.147.42.241);
          Tue, 17 Mar 2020 23:13:12 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: Add support for TCU of X1000.
Date:   Tue, 17 Mar 2020 23:11:31 +0800
Message-Id: <1584457893-40418-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TCU of X1000 from Ingenic. X1000 has a different TCU,
since X1000 OST has been independent of TCU. This patch is add TCU
support of X1000, and prepare for later OST driver.

