Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16FB6A8886
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfIDOMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 10:12:40 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35528 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730512AbfIDOMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:12:39 -0400
Received: from marcel-macbook.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5217FCECA3;
        Wed,  4 Sep 2019 16:21:25 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] bluetooth: bpa10x: change return value
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190831192341.32539-1-navid.emamdoost@gmail.com>
Date:   Wed, 4 Sep 2019 16:12:37 +0200
Cc:     emamd001@umn.edu, Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4ABEEBF4-8C38-40E2-AB8E-CC40CAD093B5@holtmann.org>
References: <20190831192341.32539-1-navid.emamdoost@gmail.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Navid,

> When returning from bpa10x_send_frame, it is necessary to propagate any
> potential errno returned from usb_submit_urb.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
> drivers/bluetooth/bpa10x.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

