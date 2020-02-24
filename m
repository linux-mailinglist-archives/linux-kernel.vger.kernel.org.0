Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5F0A169D18
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 05:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgBXEjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 23:39:53 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:26486 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727242AbgBXEjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:39:52 -0500
X-UUID: 750066f1849f4e64a762aaa0b2ce19e2-20200224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=FqzRRGkBPzJNmllxyKwuxmHigUaOX+q9iziFNeWmVkk=;
        b=s9a5Tg565TH17pkZsCK14EBj4FratBhAm+LMZg9XwZpumqkTuR7yrZGXgYgEar1JmanOXf5XE93AYvMnBkxNNORyI2zeuCFS4lK3agttR9qWtLECQNYTVBJUPHvzdiAfYLv1zUu4zLEyGGVhDMLyoKPD24ziGdtb8mdoTVotckM=;
X-UUID: 750066f1849f4e64a762aaa0b2ce19e2-20200224
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 639562518; Mon, 24 Feb 2020 12:39:43 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 24 Feb 2020 12:39:39 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 24 Feb 2020 12:39:57 +0800
Message-ID: <1582519179.26304.72.camel@mtksdccf07>
Subject: Re: [PATCH v2 1/2] scsi: ufs: Allow vendor apply device quirks in
 advance
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
Date:   Mon, 24 Feb 2020 12:39:39 +0800
In-Reply-To: <1582517363-11536-2-git-send-email-cang@codeaurora.org>
References: <1582517363-11536-1-git-send-email-cang@codeaurora.org>
         <1582517363-11536-2-git-send-email-cang@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 941886056E767A9B3BBD2E75D7652BDBCE7A7B6AE233C6AE2659D8022B1819A92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2FuLA0KDQpPbiBTdW4sIDIwMjAtMDItMjMgYXQgMjA6MDkgLTA4MDAsIENhbiBHdW8gd3Jv
dGU6DQo+IEN1cnJlbnRseSB1ZnNoY2Rfdm9wc19hcHBseV9kZXZfcXVpcmtzKCkgY29tZXMgYWZ0
ZXIgYWxsIFVuaVBybyBwYXJhbWV0ZXJzDQo+IGhhdmUgYmVlbiB0dW5lZC4gTW92ZSBpdCB1cCBz
byB0aGF0IHZlbmRvcnMgaGF2ZSBhIGNoYW5jZSB0byBhcHBseSBkZXZpY2UNCj4gcXVpcmtzIGlu
IGFkdmFuY2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDYW4gR3VvIDxjYW5nQGNvZGVhdXJvcmEu
b3JnPg0KDQpBcyBkaXNjdXNzZWQsIHVmcy1tZWRpYXRlayBuZWVkcyB0byBkbyBjb3JyZXNwb25k
aW5nIHBhdGNoIGFuZCBJIHdpbGwNCnN1Ym1pdCBpdCBvbmNlIHRoaXMgY29tbWl0IGlzIG1lcmdl
ZC4NCg0KUmV2aWV3ZWQtYnk6IFN0YW5sZXkgQ2h1IDxzdGFubGV5LmNodUBtZWRpYXRlay5jb20+
DQoNCg==

