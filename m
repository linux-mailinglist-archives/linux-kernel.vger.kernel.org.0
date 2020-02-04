Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D70D51515CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 07:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgBDGQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 01:16:52 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:27950 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725834AbgBDGQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:16:52 -0500
X-UUID: 55f74f98744144e3ae0c794c64d4982e-20200204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=LprOJOijdZe80h8OGzteezFYChw3EE39c4wiuUnDtF0=;
        b=ZNP3WteBDyc0JSvV8TNMDX+YQTywR2016TPxr/aRc8nqU+8MVBaiiAV9zdSnzTsrZd8mQILYClSKBfYbdYQCfIHwLMyBXryhKpewa9vBk/1FGGHYtnfIVjpB9BLURRSktOzGIm9EXKdNB586YQvUYTqhpvat1U4A4DYPfn6G1O4=;
X-UUID: 55f74f98744144e3ae0c794c64d4982e-20200204
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 19461820; Tue, 04 Feb 2020 14:16:46 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 4 Feb 2020 14:15:41 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 4 Feb 2020 14:16:26 +0800
Message-ID: <1580797004.21785.2.camel@mtksdccf07>
Subject: Re: [PATCH v5 3/8] scsi: ufs: Remove the check before call setup
 clock notify vops
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Can Guo <cang@codeaurora.org>
CC:     <asutoshd@codeaurora.org>, <nguyenb@codeaurora.org>,
        <hongwus@codeaurora.org>, <rnayak@codeaurora.org>,
        <linux-scsi@vger.kernel.org>, <kernel-team@android.com>,
        <saravanak@google.com>, <salyzyn@google.com>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        "open list" <linux-kernel@vger.kernel.org>
Date:   Tue, 4 Feb 2020 14:16:44 +0800
In-Reply-To: <1580721472-10784-4-git-send-email-cang@codeaurora.org>
References: <1580721472-10784-1-git-send-email-cang@codeaurora.org>
         <1580721472-10784-4-git-send-email-cang@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5CEF086D327535007C23E6A24037356C767E8A4DAF7265E51FF647C467FA1C552000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTAzIGF0IDAxOjE3IC0wODAwLCBDYW4gR3VvIHdyb3RlOg0KPiBUaGUg
ZnVuY3Rpb25hbGl0eSBvZiB2ZW5kb3Igc3BlY2lmaWMgb3BzIHNob3VsZCBiZSBoYW5kbGVkIHBy
b3Blcmx5IGluDQo+IHBsYXRmb3JtIHNwZWNpZmljIGRyaXZlciwgYnV0IHNob3VsZCBub3QgY291
bnQgb24gdGhlIFVGUyBkcml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDYW4gR3VvIDxjYW5n
QGNvZGVhdXJvcmEub3JnPg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IFN0YW5sZXkgQ2h1IDxzdGFu
bGV5LmNodUBtZWRpYXRlay5jb20+DQoNCg==

