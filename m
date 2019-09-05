Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4FE4A9C44
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 09:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbfIEHx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 03:53:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43556 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729366AbfIEHx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:53:28 -0400
X-UUID: c510fcd413834ba6bf1fd53ee9a77ea9-20190905
X-UUID: c510fcd413834ba6bf1fd53ee9a77ea9-20190905
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 932262458; Thu, 05 Sep 2019 15:53:22 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 5 Sep 2019 15:53:19 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Sep 2019 15:53:18 +0800
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ming Lei <ming.lei@redhat.com>, Chris Boot <bootc@bootc.net>,
        Zachary Hays <zhays@lexmark.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v2] fix device in programming state after ioctl() 
Date:   Thu, 5 Sep 2019 15:53:16 +0800
Message-ID: <20190905075318.15554-1-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 vs v1:
	base on Avri's comment, drop the ioctl_rpmb_card_status_poll()

the user space program may access eMMC by ioctl(), after the ioctl() was
completed, it should ensure that eMMC is in transfer state, or it will
cause other thread which access eMMC got timeout error, as it assume that
card was in transfer state.

this patch add CMD13 polling for R1B command to avoid this issue.

Chaotian Jing (2):
  mmc: block: make the card_busy_detect() more generic
  mmc: block: add CMD13 polling for ioctl() cmd with R1B response

 drivers/mmc/core/block.c | 150 +++++++++++++++------------------------
 1 file changed, 57 insertions(+), 93 deletions(-)

-- 
2.18.0


