Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7837218EDF6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 03:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgCWC0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 22:26:02 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48751 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgCWC0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 22:26:02 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 566B8891AF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 15:25:59 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1584930359;
        bh=bWdvbtemEJH5lhjVe6KKJq6aIJiapPUHg8GUIOQKP58=;
        h=From:To:CC:Subject:Date;
        b=q6JKPxeJm915cOn42ahIgqRs8L/iiU+JrFLy6bejb8rmLICoRUQA1WHi7arJsi1gN
         BXGUky/EV8C8ogy/iU3lOMPZv/jfJNso1FSTR00bdEXeYXKvKlaUlfBFAG1CxH5LXV
         sfS5v2ijMpsluoeQ7oXXDTnwWRNFsMS0xsA/pQ+LfoGd2eWSYUxo7u6Yuojex0Mj/x
         hQGWsY8rV/5hOfgP3LJnpKQMKPHbvLDLnvfZsz4arfCnAuFIwZKSoGdRc7+7ZvgBu9
         gT+bulINVs90irPiNRrZ4ZtQaNhGrMvkO+FPtkW/bUAoVUrD706v/r1ebK9cqsi6KG
         Ic46LpId8mO2Q==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e781e350001>; Mon, 23 Mar 2020 15:25:57 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 23 Mar 2020 15:25:58 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Mon, 23 Mar 2020 15:25:58 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "cai@lca.pw" <cai@lca.pw>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
Subject: Argh, can't find dcache properties !
Thread-Topic: Argh, can't find dcache properties !
Thread-Index: AQHWALpiXt3RJnRHvUCUrPyClavMpQ==
Date:   Mon, 23 Mar 2020 02:25:57 +0000
Message-ID: <be8c123a90f6d1664a902b6ad6c754b9f3d9e567.camel@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.14.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <085B17206966C34EB5E44D3E6DDA78A6@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLA0KDQpKdXN0IGJvb3RpbmcgdXAgdjUuNS4xMSBvbiBhIEZyZWVzY2FsZSBUMjA4MFJE
QiBhbmQgSSdtIHNlZWluZyB0aGUNCmZvbGxvd2luZyBtZXNhZ2UuDQoNCmtlcm4ud2FybmluZyBs
aW51eGJveCBrZXJuZWw6IEFyZ2gsIGNhbid0IGZpbmQgZGNhY2hlIHByb3BlcnRpZXMgIQ0Ka2Vy
bi53YXJuaW5nIGxpbnV4Ym94IGtlcm5lbDogQXJnaCwgY2FuJ3QgZmluZCBpY2FjaGUgcHJvcGVy
dGllcyAhDQoNClRoaXMgd2FzIGNoYW5nZWQgZnJvbSBEQkcoKSB0byBwcl93YXJuKCkgaW4gY29t
bWl0IDNiOTE3NmU5YTg3NA0KKCJwb3dlcnBjL3NldHVwXzY0OiBmaXggLVdlbXB0eS1ib2R5IHdh
cm5pbmdzIikgYnV0IHRoZSBtZXNzYWdlIHNlZW1zDQp0byBiZSBtdWNoIG9sZGVyIHRoYW4gdGhh
dC4gU28gaXQncyBwcm9iYWJseSBiZWVuIGFuIGlzc3VlIG9uIHRoZSBUMjA4MA0KKGFuZCBvdGhl
ciBRb3JJUSBTb0NzKSBmb3IgYSB3aGlsZS4NCg0KTG9va2luZyBhdCB0aGUgY29kZSB0aGUgdDIw
OHggZG9lc24ndCBzcGVjaWZpeSBhbnkgb2YgdGhlIGQtY2FjaGUtDQpzaXplL2ktY2FjaGUtc2l6
ZSBwcm9wZXJ0aWVzLiBTaG91bGQgSSBhZGQgdGhlbSB0byBzaWxlbmNlIHRoZSB3YXJuaW5nDQpv
ciBzd2l0Y2ggaXQgdG8gcHJfZGVidWcoKS9wcl9pbmZvKCk/DQoNClRoYW5rcywNCkNocmlzDQoN
Cg==
