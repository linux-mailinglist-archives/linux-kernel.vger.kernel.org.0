Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D743AD9947
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 20:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbfJPSgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 14:36:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40818 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJPSgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:36:23 -0400
Received: from surfer-172-29-2-69-hotspot.internet-for-guests.com (p578ac27a.dip0.t-ipconnect.de [87.138.194.122])
        by mail.holtmann.org (Postfix) with ESMTPSA id 68CD6CECDD;
        Wed, 16 Oct 2019 20:45:19 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] Revert "Bluetooth: hci_ll: set operational frequency
 earlier"
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191002114626.12407-1-aford173@gmail.com>
Date:   Wed, 16 Oct 2019 20:36:20 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, adam.ford@logicpd.com, sre@kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1550E9D9-43ED-4345-A9AF-6D9F097FC64E@holtmann.org>
References: <20191002114626.12407-1-aford173@gmail.com>
To:     Adam Ford <aford173@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

> As nice as it would be to update firmware faster, that patch broke
> at least two different boards, an OMAP4+WL1285 based Motorola Droid
> 4, as reported by Sebasian Reichel and the Logic PD i.MX6Q +
> WL1837MOD.
> 
> This reverts commit a2e02f38eff84f199c8e32359eb213f81f270047.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

patch has been applied to bluetooth-next tree.

Regards

Marcel

