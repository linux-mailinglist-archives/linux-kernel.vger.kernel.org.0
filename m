Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B23A4471
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 14:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfHaMa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 08:30:58 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54675 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbfHaMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 08:30:58 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7B147CECF0;
        Sat, 31 Aug 2019 14:39:42 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 2/2] Bluetooth: btrtl: Add firmware version print
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190831083602.GA10103@laptop-alex>
Date:   Sat, 31 Aug 2019 14:30:55 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Chou <max.chou@realtek.com>
Content-Transfer-Encoding: 7bit
Message-Id: <F9786DAC-5298-4CC6-B197-FE57A43D6B5D@holtmann.org>
References: <20190831083602.GA10103@laptop-alex>
To:     Alex Lu <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> This patch is used to print fw version for debug convenience
> 
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> ---
> Changes in v3
>  - Remove the pointless rtl: prefix in the format string
> Changes in v2
>  - Re-order the code so that no forward declaration is needed
> 
> drivers/bluetooth/btrtl.c | 56 ++++++++++++++++++++++++---------------
> 1 file changed, 35 insertions(+), 21 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

