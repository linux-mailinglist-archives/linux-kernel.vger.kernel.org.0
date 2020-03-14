Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD5A18542F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Mar 2020 04:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgCNDQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 23:16:14 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:65480 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726559AbgCNDQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 23:16:12 -0400
X-UUID: c779de278cab48e0a6a91a5c8bc88aa4-20200314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Cp6nxJDmK0by+hyxNgFAHL/aGR7OEaDHIQICFVZiGaQ=;
        b=NAxn80v6BI852R+Ii3cMKJ4RmIW4wwZ7+AUJp1okdJU2yE0ObCm/sAOpLsOSDTn7QedDBuYmtJ6JEkKfR48I7dLIDbp0wANVIiVqTpGidlqhBxILbRnHpiS8de/jCm9cyyz9dAbeDdsk/1zCEG1mnnhpBml8xHJGpFecpZaZSRs=;
X-UUID: c779de278cab48e0a6a91a5c8bc88aa4-20200314
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1218980132; Sat, 14 Mar 2020 11:16:04 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 14 Mar 2020 11:15:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 14 Mar 2020 11:15:58 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <jejb@linux.ibm.com>
CC:     <beanhuo@micron.com>, <asutoshd@codeaurora.org>,
        <cang@codeaurora.org>, <matthias.bgg@gmail.com>,
        <bvanassche@acm.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>, Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v1 0/2] scsi: ufs: add error recovery for suspend and resume in ufs-mediatek
Date:   Sat, 14 Mar 2020 11:15:58 +0800
Message-ID: <20200314031600.10616-1-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5C892599D836B07E4273D5D50073766BC77ACDA29FAE6827C18AF61F3F5B7CE52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoaXMgcGF0Y2hzZXQgYWRkcyBlcnJvciByZWNvdmVyeSBmbG93IGZvciBzdXNwZW5k
IGFuZCByZXN1bWUgaW4gdWZzLW1lZGlhdGVrIGRyaXZlci4NCg0KU3RhbmxleSBDaHUgKDIpOg0K
ICBzY3NpOiB1ZnM6IGV4cG9ydCB1ZnNoY2RfbGlua19yZWNvdmVyeSBmb3IgdmVuZG9yJ3MgZXJy
b3IgcmVjb3ZlcnkNCiAgc2NzaTogdWZzLW1lZGlhdGVrOiBhZGQgZXJyb3IgcmVjb3ZlcnkgZm9y
IHN1c3BlbmQgYW5kIHJlc3VtZQ0KDQogZHJpdmVycy9zY3NpL3Vmcy91ZnMtbWVkaWF0ZWsuYyB8
IDEyICsrKysrKysrKystLQ0KIGRyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMgICAgICAgfCAgMyAr
Ky0NCiBkcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5oICAgICAgIHwgIDEgKw0KIDMgZmlsZXMgY2hh
bmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE4LjANCg==

