Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E09D1EF492
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 05:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbfKEErk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 23:47:40 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:27618 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfKEErk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 23:47:40 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191105044737epoutp0466b00cb78a2597c06c4c61577186c259~UKtNcKjtK0727007270epoutp04I
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 04:47:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191105044737epoutp0466b00cb78a2597c06c4c61577186c259~UKtNcKjtK0727007270epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572929257;
        bh=S7GszCat8t/vAG5IxSAad5wseTjeEI6qkoAfBu7k5j8=;
        h=To:Cc:From:Date:References:From;
        b=XWPoK3uAYUS1u7L7DNBel+3y4KFvsf0iMjVy1c9WjKxPcWxt6gkZRuHTuvv3MyV5W
         ARaB/SrKx683LOPkSIjStZHBhQebx02Vf0qlbaaMUIZSoHdwNWfVGYKyxjKzxTp4Kj
         GTj0NDw03AhaIUYaTCLhL9ovqqY928A4K2nPeN8U=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191105044736epcas1p4d4ce4d6de8e439628309d9ca3759e0ec~UKtMuIABr0481404814epcas1p4k;
        Tue,  5 Nov 2019 04:47:36 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 476cbV1BQ9zMqYkf; Tue,  5 Nov
        2019 04:47:34 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.40.04144.ADEF0CD5; Tue,  5 Nov 2019 13:47:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191105044721epcas1p39e8005d2ce341355cc1005c99565a766~UKs-AIAJq1495114951epcas1p3O;
        Tue,  5 Nov 2019 04:47:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191105044721epsmtrp1d4caed0ba3b598746c08c335d3e08e71~UKs_-dYjD1652916529epsmtrp1H;
        Tue,  5 Nov 2019 04:47:21 +0000 (GMT)
X-AuditID: b6c32a35-2dfff70000001030-3a-5dc0feda50fd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.C1.25663.9DEF0CD5; Tue,  5 Nov 2019 13:47:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191105044721epsmtip1da04a5e78ede5f62709355d7c6576c33~UKs_2g11S1653816538epsmtip1G;
        Tue,  5 Nov 2019 04:47:21 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f618ed4d-05ce-75cd-8cd9-24d8fe5a2551@samsung.com>
Date:   Tue, 5 Nov 2019 13:52:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmt3u9TnN1m1qnETpv/pHi1KuuVqgZhazyD6EHEQ276EXFvdrd
        RDPEiPJBllqYLsXKpBJRk+WrZPOmqAS9o1IsKSktX2SaFD22XSP/+853zvc73zm/I8akZYRM
        nKk3syY9o6UIb7z9QYhCMfzboYnk23FV+esXuOp0fQuhet5dQ6hGTt0iEnB1W2MxobbXNnmq
        z9sakXq+LSAZP5IVm8EyaaxJzupTDWmZ+vQ4at/+lF0pyi2RtILeptpKyfWMjo2jdiclKxIz
        tc6WlDyb0VqcVDLDcVREfKzJYDGz8gwDZ46jWGOa1rjNGM4xOs6iTw9PNei205GRUUpn4bGs
        jOtnuj2NEz457Y5ZogDd8y5BYjGQMTDEm0qQt1hKdiJY+sh7CsFXBDf6y0RCsIhgsuYPVoK8
        3IqXp37gQqIHwYj997JkFsGzxV8iV5UfuRkm+4fdVRhpQ/BlqhN3JQgyFOwTrwkXXkMGwcul
        D8hlRELGw4TNrcXJYBhv+iRy0f7kYXi4wLhoCbkWhqrH3a9g5HoYHq8TCTgQOqZrMFcrIFsJ
        uHL1rofgdDc0V04vY1/4PGDzFLAMJi+cXcZ5cHuojxDERQhs9ifLgmiwN1x0m8DIEGjpjhDo
        IOj6WYuExqthZuGch7BHCRSdlQolm+D52KhIwBugvrCYELAa+I4K9xKlpAbuzbeKypDcumI0
        64rRrCtGs/43cRXhjWgda+R06SxHG+mVn92G3NcYquxElx4l8YgUI8pHMlfo0Eg9mGwuV8cj
        EGOUn+RpVY9GKkljck+wJkOKyaJlOR4pnYsvx2T+qQbnbevNKbQyKjo6WhVDb1HSNLVesvNm
        g0ZKpjNmNotljazpn04k9pIVoC6ZcjAmbO6k6kCEb21OcWJBol/eM//v72b6a/zyDzruhPUM
        8FXlXRG1R68pQnziRlvKPz+eCigteWWoG8tzJA9s7PuEHwrpTeiPTXrfXLrUev/bvlUz+S/e
        BNrwp9WV3m0VeYkdd2cGx3rDh+zD1h17jndbgkez+LLVE5c9NMzetxTOZTB0KGbimL8nMWxe
        owMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSnO7NfwdiDY7+VbaYeOMKi0Xz4vVs
        Fpd3zWGzuN24gs2BxWPTqk42j/1z17B79G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV8ai1l3s
        BS94KrYdeM/WwLibq4uRk0NCwETiauMvli5GLg4hgd2MEl/3X2OHSEhKTLt4lLmLkQPIFpY4
        fLgYouYto8SKhh+MIDUiAhoSL4/eAmtmFtjCKNE2aSYTSIJNQEti/4sbbCA2v4CixNUfjxlB
        BvEK2Em82AJWwiKgIvFkzXMwW1QgQuL59htgM3kFBCVOznzCAmIzC6hL/Jl3iRnCFpe49WQ+
        E4QtL7H97RzmCYwCs5C0zELSMgtJyywkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl
        5+duYgQHt5bWDsYTJ+IPMQpwMCrx8H5oPxArxJpYVlyZe4hRgoNZSYT34oy9sUK8KYmVValF
        +fFFpTmpxYcYpTlYlMR55fOPRQoJpCeWpGanphakFsFkmTg4pRoYhf9L3kyUmSW8WXTLBqZ7
        abc6CkwLvFy86h12q1xiMnrQZ6scErsu6a6mSfI8f4uF/r7zP/d27p///eHlhLroehF/V0lb
        cUbO2OscE7mP3rwXo5S8vWr1U4M7TTGZVeWtsub5N5WOHb205gubbYddevCO9ve/RHmMP99L
        W6TKdrbcse1g4iMlluKMREMt5qLiRADrMM8PagIAAA==
X-CMS-MailID: 20191105044721epcas1p39e8005d2ce341355cc1005c99565a766
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191105044721epcas1p39e8005d2ce341355cc1005c99565a766
References: <CGME20191105044721epcas1p39e8005d2ce341355cc1005c99565a766@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.5. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Detailed description for this pull request:
1. Clean up the and fix the minor issue of extcon provider driver
- extcon-intel-cht-wc don't reset the USB data connection at probe time
  in order to prevent the removing all devices from bus.
- extcon-sm5502 reset the registers at proble time in order to
  prevent the some stuck state. And remove the redundant variable
  initialization.

Best Regards,
Chanwoo Choi

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.5

for you to fetch changes up to ddd1bbbae486ff5913c8fc72c853dcea60713236:

  extcon: sm5502: remove redundant assignment to variable cable_type (2019-10-31 13:47:42 +0900)

----------------------------------------------------------------
Colin Ian King (1):
      extcon: sm5502: remove redundant assignment to variable cable_type

Stephan Gerhold (1):
      extcon: sm5502: Reset registers during initialization

Yauhen Kharuzhy (1):
      extcon-intel-cht-wc: Don't reset USB data connection at probe

 drivers/extcon/extcon-intel-cht-wc.c | 16 ++++++++++++++--
 drivers/extcon/extcon-sm5502.c       |  6 +++++-
 drivers/extcon/extcon-sm5502.h       |  2 ++
 3 files changed, 21 insertions(+), 3 deletions(-)


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
