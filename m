Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAAFA4474
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 14:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfHaMb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 08:31:29 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40269 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbfHaMb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 08:31:28 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6CDCACECF0;
        Sat, 31 Aug 2019 14:40:13 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] Bluetooth: btrtl: Remove redundant prefix from calls
 to rtl_dev macros
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190831084030.GA10145@laptop-alex>
Date:   Sat, 31 Aug 2019 14:31:27 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Chou <max.chou@realtek.com>
Content-Transfer-Encoding: 7bit
Message-Id: <1498CCC4-9780-4C49-9971-7B97E1A7BA4D@holtmann.org>
References: <20190831084030.GA10145@laptop-alex>
To:     Alex Lu <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> the rtl: or RTL: prefix in the string is pointless. The rtl_dev_* macros
> already does that.
> 
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> ---
> drivers/bluetooth/btrtl.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

