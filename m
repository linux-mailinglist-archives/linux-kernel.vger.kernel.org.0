Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A8F17A39F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 12:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgCELEr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Mar 2020 06:04:47 -0500
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:42646 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgCELEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:04:47 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 025B4DCI005604; Thu, 5 Mar 2020 20:04:13 +0900
X-Iguazu-Qid: 34tKIIhGyyktrZlkUi
X-Iguazu-QSIG: v=2; s=0; t=1583406253; q=34tKIIhGyyktrZlkUi; m=qVuwNcuxOzDkksuSilLCPobt7vXxKE/1sSG+5jF+1CA=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1513) id 025B4BSt010847;
        Thu, 5 Mar 2020 20:04:11 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 025B4A3v016619;
        Thu, 5 Mar 2020 20:04:10 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 025B4Adf007560;
        Thu, 5 Mar 2020 20:04:10 +0900
From:   <masahiro31.yamada@kioxia.com>
To:     <hch@lst.de>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nvme: add a compat_ioctl handler for NVME_IOCTL_SUBMIT_IO
Thread-Topic: [PATCH] nvme: add a compat_ioctl handler for
 NVME_IOCTL_SUBMIT_IO
Thread-Index: AdXwWtP+3uT/YWciSkKTlF+qgQWgkQBmYx6AADpE/zA=
Date:   Thu, 5 Mar 2020 11:04:09 +0000
X-TSB-HOP: ON
Message-ID: <42c9a559129f4608b809a3fc093a1d6b@TGXML281.toshiba.local>
References: <c0d7091c43154d9ea7a978c42a78b01a@TGXML281.toshiba.local>
 <20200304161317.GA11268@lst.de>
In-Reply-To: <20200304161317.GA11268@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [133.116.224.115]
msscp.transfermailtomossagent: 103
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>This should not be exposed in the UAPI header.  I think it should just
>go into the #ifdef CONFIG_COMPAT block in core.c near the comment and
>the compat_ioctl handler.

Thank you. I tried to describe it.
Please correct me, if I am misunderstanding what you mean.
