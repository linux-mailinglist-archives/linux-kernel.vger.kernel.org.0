Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA30912CC1F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 04:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfL3D3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Dec 2019 22:29:06 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:49879 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726894AbfL3D3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 22:29:06 -0500
X-UUID: faa82c971376403da96ccaa12d00c45c-20191230
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/4cmGo5jk+InL1JQXnv8LJ5xJENmJ8A8wH1U3y98Dxs=;
        b=KpY8jNLLVCSxKpZxOwPsCIbPbZeZnMM1JpaZr8Sb03gWy5uVpRUEhWIFJttkPMh3bxzhcp8OIBqgStIi06+5K09+/z2hJVQi1iSIW4881FMkHqfYfxfRv8IEGhqFr/JYIRhZkfRinQBuNAlw56Z80dtjRFGhCNHClDd3dNQuQ6o=;
X-UUID: faa82c971376403da96ccaa12d00c45c-20191230
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1156605609; Mon, 30 Dec 2019 11:28:57 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 30 Dec 2019 11:28:34 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 30 Dec 2019 11:29:18 +0800
Message-ID: <1577676536.29596.2.camel@mtkswgap22>
Subject: Re: [PATCH] mm/page_owner: print largest memory consumer when OOM
 panic occurs
From:   Miles Chen <miles.chen@mediatek.com>
To:     Qian Cai <cai@lca.pw>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-mediatek@lists.infradead.org>,
        <wsd_upstream@mediatek.com>
Date:   Mon, 30 Dec 2019 11:28:56 +0800
In-Reply-To: <D8935037-8A59-4A64-9C35-52486DC01015@lca.pw>
References: <1577669436.25204.8.camel@mtkswgap22>
         <D8935037-8A59-4A64-9C35-52486DC01015@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE5LTEyLTI5IGF0IDIwOjUxIC0wNTAwLCBRaWFuIENhaSB3cm90ZToNCj4gDQo+
ID4gT24gRGVjIDI5LCAyMDE5LCBhdCA4OjMwIFBNLCBNaWxlcyBDaGVuIDxtaWxlcy5jaGVuQG1l
ZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gWWVzLCBwcmludGluZyB0b3AgMTAgd2lsbCBi
ZSB0b28gbXVjaC4gVGhhdCdzIHdoeSBJIHByaW50IG9ubHkgdGhlDQo+ID4gZ3JlYXRlc3QgY29u
c3VtZXIsIGFuZCB0ZXN0IGlmIHRoaXMgYXBwcm9hY2ggd29ya3MuDQo+ID4gDQo+ID4gSSB3aWxs
IHJlc2VuZCB0aGlzIHBhdGNoIGFmdGVyIHRoZSBicmVhay4gTGV0J3Mgd2FpdCBmb3Igb3RoZXJz
Jw0KPiA+IGNvbW1lbnRzPw0KPiANCj4gU3VyZSwgYnV0IHRvIG1ha2UgbXkgcG9pbnQgY2xlYXIu
DQoNCk5vIHByb2JsZW0uIFRoYW5rcyBmb3IgeW91ciByZXBsaWVzLg0KDQogIE1pbGVzDQo+IA0K
PiBOYWNrZWQtYnk6IFFpYW4gQ2FpIDxjYWlAbGNhLnB3Pg0KDQoNCg==

