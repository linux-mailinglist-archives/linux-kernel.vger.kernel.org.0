Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 399B777860
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 13:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfG0LNY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 27 Jul 2019 07:13:24 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:47888 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfG0LNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 07:13:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3AB43606D4AC;
        Sat, 27 Jul 2019 13:13:22 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3FIFmhAxF4DT; Sat, 27 Jul 2019 13:13:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 51920606D4B6;
        Sat, 27 Jul 2019 13:13:21 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dDwU3E9fLcRX; Sat, 27 Jul 2019 13:13:21 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2113D606D4AC;
        Sat, 27 Jul 2019 13:13:21 +0200 (CEST)
Date:   Sat, 27 Jul 2019 13:13:21 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        yi zhang <yi.zhang@huawei.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <294578939.51712.1564226001053.JavaMail.zimbra@nod.at>
In-Reply-To: <0B80F9D4116B2F4484E7279D5A66984F7A4DB4@dggemi524-mbx.china.huawei.com>
References: <1563602720-113903-1-git-send-email-chengzhihao1@huawei.com> <0B80F9D4116B2F4484E7279D5A66984F7A4DB4@dggemi524-mbx.china.huawei.com>
Subject: =?utf-8?Q?Re:_=E7=AD=94=E5=A4=8D:_[PATCH]_ubifs:_ubifs=5Ftnc=5Fsta?=
 =?utf-8?Q?rt=5Fcommit:_Fix_OOB_in_layout=5Fin=5Fgaps?=
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: ubifs_tnc_start_commit: Fix OOB in layout_in_gaps
Thread-Index: AQHVPsBTBWetoNcJ1UaytZ+21M4VxabeWhAgfGLlKWo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "richard" <richard@nod.at>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Artem Bityutskiy" <dedekind1@gmail.com>, "yi
> zhang" <yi.zhang@huawei.com>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Samstag, 27. Juli 2019 13:09:59
> Betreff: 答复: [PATCH] ubifs: ubifs_tnc_start_commit: Fix OOB in layout_in_gaps

> ping

I had no time to look at this yet. It is on my list.

Thanks,
//richard
