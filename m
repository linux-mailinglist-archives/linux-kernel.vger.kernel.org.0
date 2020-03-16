Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E887E1865EE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 08:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgCPHu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 03:50:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28447 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729745AbgCPHu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:50:58 -0400
X-UUID: 303c1eb3ace14b8bb5b36e74a4de3748-20200316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yeo4h6DvN3NLgI/noju6bhQdpGHApRy5klUw2BjdFtc=;
        b=Jxr+spec7j3GKcjuG4+wLqMymXiyGHEMRDUzlnB7XTjnZdCSlG7nrxqkj9FTP4cWfyrn8F94LwQWQGzW7juwdSpez7i3W8OopglWQRMqRCvbFLhTafc/35gJLOrtMGjrzL9575dDf9HLX1jiSrA+OF5sOETGnsr/dNvs5df2xsY=;
X-UUID: 303c1eb3ace14b8bb5b36e74a4de3748-20200316
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 291186682; Mon, 16 Mar 2020 15:50:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 16 Mar 2020 15:49:55 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 16 Mar 2020 15:47:55 +0800
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Hanks Chen <hanks.chen@mediatek.com>
Subject: [PATCH v2 1/1] dt-bindings: cpu: Add a support cpu type for cortex-a75
Date:   Mon, 16 Mar 2020 15:50:50 +0800
Message-ID: <1584345050-3738-1-git-send-email-hanks.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGFybSBjcHUgdHlwZSBjb3J0ZXgtYTc1Lg0KDQpTaWduZWQtb2ZmLWJ5OiBIYW5rcyBDaGVu
IDxoYW5rcy5jaGVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vY3B1cy55YW1sIHwgICAgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2NwdXMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
Y3B1cy55YW1sDQppbmRleCBjMjNjMjRmLi41MWI3NWY3IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9jcHVzLnlhbWwNCisrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY3B1cy55YW1sDQpAQCAtMTI4LDYgKzEyOCw3IEBA
IHByb3BlcnRpZXM6DQogICAgICAgLSBhcm0sY29ydGV4LWE1Nw0KICAgICAgIC0gYXJtLGNvcnRl
eC1hNzINCiAgICAgICAtIGFybSxjb3J0ZXgtYTczDQorICAgICAgLSBhcm0sY29ydGV4LWE3NQ0K
ICAgICAgIC0gYXJtLGNvcnRleC1tMA0KICAgICAgIC0gYXJtLGNvcnRleC1tMCsNCiAgICAgICAt
IGFybSxjb3J0ZXgtbTENCi0tIA0KMS43LjkuNQ0K

