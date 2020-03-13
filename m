Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93326184378
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 10:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgCMJOE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Mar 2020 05:14:04 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:60302 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgCMJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:14:03 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 02D9DRgI002000; Fri, 13 Mar 2020 18:13:28 +0900
X-Iguazu-Qid: 34trpDa8K1TWntZwMG
X-Iguazu-QSIG: v=2; s=0; t=1584090807; q=34trpDa8K1TWntZwMG; m=vEOlm1BxUkjudJqJdtLsiNSwohsgru41t5DrtqALAws=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1511) id 02D9DQqa024336;
        Fri, 13 Mar 2020 18:13:26 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 02D9DQYU017268;
        Fri, 13 Mar 2020 18:13:26 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 02D9DPQU027303;
        Fri, 13 Mar 2020 18:13:26 +0900
From:   <masahiro31.yamada@kioxia.com>
To:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] nvme: Add compat_ioctl handler for
 NVME_IOCTL_SUBMIT_IO
Thread-Topic: [PATCH V2] nvme: Add compat_ioctl handler for
 NVME_IOCTL_SUBMIT_IO
Thread-Index: AdXy3d6dwSgpOC+0SI6LHpzHuGP6yQGODKPg
Date:   Fri, 13 Mar 2020 09:13:24 +0000
X-TSB-HOP: ON
Message-ID: <e2d4098485af4757a2252b0568f71a4d@TGXML281.toshiba.local>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.167.9.22]
msscp.transfermailtomossagent: 103
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?
