Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29E2AA760
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 17:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390420AbfIEPdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 11:33:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59874 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731960AbfIEPdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:33:19 -0400
Received: from marcel-macbook.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id C2496CECD1;
        Thu,  5 Sep 2019 17:42:05 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Use cmd_timeout to reset Realtek
 device
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190905023631.GA29398@laptop-alex>
Date:   Thu, 5 Sep 2019 17:33:17 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Chou <max.chou@realtek.com>
Content-Transfer-Encoding: 7bit
Message-Id: <F68A732A-E6F7-468E-9F36-F27BE332B5D0@holtmann.org>
References: <20190905023631.GA29398@laptop-alex>
To:     Alex Lu <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> Realtek Bluetooth controller provides a BT_DIS reset pin for hardware
> reset of it. The cmd_timeout is helpful on Realtek bluetooth controller
> where the firmware gets stuck.
> 
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> ---
> Changes in v2
>  - Provide a dedicated btusb_rtl_cmd_timeout in case of Realtek hardware
> 
> drivers/bluetooth/btusb.c | 31 +++++++++++++++++++++++++++++++
> 1 file changed, 31 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

