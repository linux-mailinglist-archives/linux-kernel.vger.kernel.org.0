Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A265CDF0D0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 17:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfJUPGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 11:06:00 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41712 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfJUPF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:05:59 -0400
Received: from marcel-macbook.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9230CCECB0;
        Mon, 21 Oct 2019 17:14:57 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Add delay for wcn3990
 stability"
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191021141827.11150-1-jeffrey.l.hugo@gmail.com>
Date:   Mon, 21 Oct 2019 17:05:57 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, c-hbandi@codeaurora.org,
        bgodavar@codeaurora.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <41343F73-DBCE-43BB-84AD-4548F8A66D10@holtmann.org>
References: <20191021141827.11150-1-jeffrey.l.hugo@gmail.com>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffrey,

> This reverts commit cde9dde6e11a5ab54b6462cd46d82878926783bc.
> 
> The frame reassembly errors were root caused to a transient gpio issue.
> The missing response was root caused to an issue with properly managing
> RFR in the uart driver.  Addressing those root causes occurs outside of
> hci_qca and eliminates the need for the 50ms delay, so remove it.
> 
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
> drivers/bluetooth/hci_qca.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

